part of dotenv;

/// [Parser] creates key-value pairs from strings formatted as environment
/// variable definitions.
class Parser {
  static final _log = new Logger('Parser');

  static const _singleQuot = "'";
  static const _doubleQuot = '"';
  static const _keyword = 'export';

  static final _comment = new RegExp(r'''#.*(?:[^'"])$''');
  static final _surroundQuotes = new RegExp(r'''^(['"])(.*)\1$''');
  static final _bashVar = new RegExp(r'(?:\\)?(\$)([a-zA-Z_][\w]*)+');

  const Parser();

  /// Creates a [Map] suitable for merging into [Platform.environment].
  /// Duplicate keys are silently discarded.
  Map<String, String> parse(Iterable<String> lines) {
    var out = {};
    lines.forEach((line) {
      var kv = parseOne(line, env: out);
      if (kv.isEmpty) return;
      out.putIfAbsent(kv.keys.single, () => kv.values.single);
    });
    out.forEach((k, v) => _log.finer('parse: $k=$v'));
    return out;
  }

  /// Parse a single line into a key-value pair.
  @Deprecated('Exposed for testing') // FIXME
  Map<String, String> parseOne(String line,
      {Map<String, String> env: const {}}) {
    var stripped = strip(line);
    if (!_isValid(stripped)) return {};

    var sides = stripped.split('=');
    var lhs = sides[0];
    var k = swallow(lhs);
    if (k.isEmpty) return {};

    var rhs = sides[1].trim();
    var quotChar = surroundingQuote(rhs);
    var v = unquote(rhs);

    if (quotChar == _singleQuot) // skip substitution in single-quoted values
        return {k: v};

    return {k: interpolate(v, env)};
  }

  /// Substitute $bash_vars in [val] with values from [env].
  @Deprecated('Exposed for testing') // FIXME
  String interpolate(String val, Map<String, String> env) => val
      .replaceAllMapped(_bashVar, (m) {
    var k = m.group(2);
    if (!env.containsKey(k) || env[k] == null) return '';
    return env[k];
  });

  /// If [val] is wrapped in single or double quotes, return the quote character.
  /// Otherwise, return the empty string.
  @Deprecated('Exposed for testing') // FIXME
  String surroundingQuote(String val) {
    if (!_surroundQuotes.hasMatch(val)) return '';
    return _surroundQuotes.firstMatch(val).group(1);
  }

  /// Remove quotes (single or double) surrounding a value.
  @Deprecated('Exposed for testing') // FIXME
  String unquote(String val) =>
      val.replaceFirstMapped(_surroundQuotes, (m) => m[2]).trim();

  /// Strip comments (trailing or whole-line).
  @Deprecated('Exposed for testing') // FIXME
  String strip(String line) => line.replaceAll(_comment, '').trim();

  /// Omit 'export' keyword.
  @Deprecated('Exposed for testing') // FIXME
  String swallow(String line) => line.replaceAll(_keyword, '').trim();

  bool _isValid(String s) => s.isNotEmpty && s.contains('=');
}
