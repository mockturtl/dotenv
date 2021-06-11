import 'dart:io';

import 'package:meta/meta.dart';

/// Creates key-value pairs from strings formatted as environment
/// variable definitions.
class Parser {
  static const _singleQuot = "'";
  static const _keyword = 'export';

  static final _comment = new RegExp(r'''#.*(?:[^'"])$''');
  static final _surroundQuotes = new RegExp(r'''^(['"])(.*)\1$''');
  static final _bashVar =
      new RegExp(r'(?:\\)?(\$)(?:{)?([a-zA-Z_][\w]*)+(?:})?');

  /// [Parser] methods are pure functions.
  const Parser();

  /// Substitutes $bash_vars in [val] with values from [env].
  @visibleForTesting
  String interpolate(String val, Map<String, String> env) =>
      val.replaceAllMapped(_bashVar, (m) {
        var k = m.group(2)!;
        return (!_has(env, k)) ? _tryPlatformEnv(k) ?? '' : env[k] ?? '';
      });

  /// Creates a [Map] suitable for merging with [Platform.environment].
  /// Duplicate keys are silently discarded.
  Map<String, String> parse(Iterable<String> lines) {
    var out = <String, String>{};
    lines.forEach((line) {
      var kv = parseOne(line, env: out);
      if (kv.isEmpty) return;
      out.putIfAbsent(kv.keys.single, () => kv.values.single);
    });
    return out;
  }

  /// Parses a single line into a key-value pair.
  @visibleForTesting
  Map<String, String> parseOne(String line,
      {Map<String, String> env: const {}}) {
    var stripped = strip(line);
    if (!_isValid(stripped)) return {};

    var idx = stripped.indexOf('=');
    var lhs = stripped.substring(0, idx);
    var k = swallow(lhs);
    if (k.isEmpty) return {};

    var rhs = stripped.substring(idx + 1, stripped.length).trim();
    var quotChar = surroundingQuote(rhs);
    var v = unquote(rhs);

    if (quotChar == _singleQuot) // skip substitution in single-quoted values
      return {k: v};

    return {k: interpolate(v, env)};
  }

  /// Strips comments (trailing or whole-line).
  @visibleForTesting
  String strip(String line) => line.replaceAll(_comment, '').trim();

  /// If [val] is wrapped in single or double quotes, returns the quote character.
  /// Otherwise, returns the empty string.
  @visibleForTesting
  String surroundingQuote(String val) {
    if (!_surroundQuotes.hasMatch(val)) return '';
    return _surroundQuotes.firstMatch(val)!.group(1)!;
  }

  /// Omits 'export' keyword.
  @visibleForTesting
  String swallow(String line) => line.replaceAll(_keyword, '').trim();

  /// Removes quotes (single or double) surrounding a value.
  @visibleForTesting
  String unquote(String val) =>
      val.replaceFirstMapped(_surroundQuotes, (m) => m[2]!).trim();

  /// [null] is a valid value in a Dart map, but the env var representation is empty string, not the string 'null'
  bool _has(Map<String, String> map, String key) =>
      map.containsKey(key) && map[key] != null;

  bool _isValid(String s) => s.isNotEmpty && s.contains('=');

  String? _tryPlatformEnv(String key) {
    if (!_has(Platform.environment, key)) return '';
    return Platform.environment[key];
  }
}
