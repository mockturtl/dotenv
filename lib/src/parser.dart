part of dotenv;

/// [Parser] creates key-value pairs from strings formatted as environment
/// variable definitions.
class Parser {
  static final _log = new Logger('Parser');

  static final _comment = new RegExp(r'#.*$'); // from # to EOL
  static final _keyword = 'export';
  static final _surroundQuotes = new RegExp(r'''^(['"])(.*)\1$''');

  const Parser();

  /// Creates a [Map] suitable for merging into [Platform.environment].
  /// Duplicate keys are silently discarded.
  Map<String, String> parse(Iterable<String> lines) {
    var out = {};
    lines.forEach((line) {
      var kv = parseOne(line);
      if (kv.isEmpty) return;
      out.putIfAbsent(kv.keys.single, () => kv.values.single);
    });
    out.forEach((k, v) => _log.finer('parse: $k=$v'));
    return out;
  }

  /// Parse a single line into a key-value pair.  Exposed for testing.
  Map<String, String> parseOne(String line) {
    var stripped = strip(line);
    if (!_valid(stripped)) return {};

    var sides = stripped.split('=');
    var lhs = sides[0];
    var k = swallow(lhs);
    if (k.isEmpty) return {};

    var rhs = sides[1];
    var v = dequote(rhs);
    return {k: v};
  }

  /// Strip quotes (single or double) surrounding a value.  Exposed for testing.
  String dequote(String val) => val
      .replaceFirstMapped(_surroundQuotes, (m) => m[2])
      .trim(); // TODO: variable substitution

  /// Strip comments (trailing or whole-line).  Exposed for testing.
  String strip(String line) => line.replaceAll(_comment, '').trim();

  /// Omit 'export' keyword.  Exposed for testing.
  String swallow(String line) => line.replaceAll(_keyword, '').trim();

  bool _valid(String line) {
    if (line.isEmpty || !line.contains('=')) return false;
    return true;
  }
}
