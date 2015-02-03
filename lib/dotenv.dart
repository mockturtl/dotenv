library dotenv;

import 'package:logging/logging.dart';
import 'dart:io';

/// A copy of [Platform.environment] including variables loaded at runtime from a file.
Map<String, String> env = new Map.from(Platform.environment);

final _log = new Logger('dotenv');
final _pkgroot = Platform.script.resolve('..');

/// Read environment variables from [filename] and add them to [env].
void load([String filename = '.env']) {
  var f = new File.fromUri(_pkgroot.resolve(filename));
  _verify(f);

  var lines = f.readAsLinesSync();
  _verifyLineFormat(lines);

  var _vars = {};
  lines.forEach((line) {
    var substrs = line.split('=');
    var rawK = substrs[0];
    var k = rawK.replaceAll('export', '').trim(); // omit 'export' keyword
    var rawV = substrs[1];
    var v = rawV.replaceAll(new RegExp(r'"'), '') // double-quoted values
        .replaceAll(new RegExp(r"'"), '') // single-quoted values
        .replaceAll(new RegExp(r'#.*$'), '') // comments
        .trim(); // TODO: variable substitution
    _vars[k] = v;
  });

  _vars.forEach((k, v) {
    _log.finer('load: $k=$v');
  });

  env.addAll(_vars);
}

void _verifyLineFormat(Iterable lines) {
  if (!lines.every((String l) => l.contains('='))) {
    _log.severe('Missing "="; aborting');
    exit(13);
  }
}

void _verify(File f) {
  if (!f.existsSync()) {
    _log.severe('Cannot find "$f"; aborting.');
    exit(11);
  }
}
