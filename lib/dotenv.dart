library dotenv;

import 'package:logging/logging.dart';
import 'dart:io';

part 'src/parser.dart';

var _env = new Map.from(Platform.environment);

/// A copy of [Platform.environment] including variables loaded at runtime from a file.
Map<String, String> get env => _env;

final _log = new Logger('dotenv');
final _pkgroot = Platform.script.resolve('..');

/// Overwrite [_env] with a clean [Platform.environment].  Useful for testing.
Map clean() => _env = new Map.from(Platform.environment);

/// True if all supplied variables are present in the environment; false otherwise.
bool isEveryDefined(Iterable<String> vars) =>
    vars.every((k) => _env[k] != null && _env[k].isNotEmpty);

/// Read environment variables from [filename] and add them to [env].
void load([String filename = '.env', Parser psr = const Parser()]) {
  var f = new File.fromUri(_pkgroot.resolve(filename));
  _verify(f);
  var lines = f.readAsLinesSync();
  _env.addAll(psr.parse(lines));
}

void _verify(File f) {
  if (!f.existsSync()) {
    _log.severe('_verify: Cannot find file "$f".');
    exitCode = 1;
  }
}
