part of dotenv;

class Parser {
  static final _log = new Logger('Parser');

  const Parser();

  Map<String, String> parse(List<String> lines) {
    if (!_validate(lines)) {
      _log.severe('parse: validation failed; aborting');
      exitCode = 1;
      return {};
    }

    var out = {};
    lines.forEach((line) {
      var substrs = line.split('=');
      var rawK = substrs[0];
      var k = rawK.replaceAll('export', '').trim(); // omit 'export' keyword
      var rawV = substrs[1];
      var v = rawV.replaceAll(new RegExp(r'"'), '') // double-quoted values
          .replaceAll(new RegExp(r"'"), '') // single-quoted values
          .replaceAll(new RegExp(r'#.*$'), '') // comments
          .trim(); // TODO: variable substitution
      out[k] = v;
    });
    out.forEach((k, v) => _log.finer('parse: $k=$v'));
    return out;
  }

  bool _validate(Iterable lines) {
    if (lines.any((String l) => !l.contains('='))) {
      _log.severe('_validate: missing "="');
      return false;
    }
    return true;
  }
}
