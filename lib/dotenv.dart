/// Loads environment variables from a `.env` file.
///
/// ## usage
///
/// Prefix the library import and call [load].
/// You may wish to expose the [env] map with a top-level getter.
///
///     import 'package:dotenv/dotenv.dart' as dotenv;
///
///     Map<String, String> get _env => dotenv.env;
///
///     void main() {
///       dotenv.load();
///       var x = _env['foo'];
///       // ...
///     }
///
/// Verify required variables are present:
///
///     const _requiredEnvVars = const ['host', 'port'];
///     bool get hasEnv => dotenv.isEveryDefined(_requiredEnvVars);
library dotenv;

import 'dart:io';

part 'src/parser.dart';

var _env = new Map.from(Platform.environment);

/// A copy of [Platform.environment](dart:io) including variables loaded at runtime from a file.
Map<String, String> get env => _env;

/// Overwrite [env] with a new writable copy of [Platform.environment](dart:io).
Map clean() => _env = new Map.from(Platform.environment);

/// True if all supplied variables have nonempty value; false otherwise.
/// Differs from [containsKey](dart:core) by excluding null values.
/// Note [load] should be called first.
bool isEveryDefined(Iterable<String> vars) =>
    vars.every((k) => _env[k] != null && _env[k].isNotEmpty);

/// Read environment variables from [filename] and add them to [env].
void load([String filename = '.env', Parser psr = const Parser()]) {
  var f = new File.fromUri(new Uri.file(filename));
  var lines = _verify(f);
  _env.addAll(psr.parse(lines));
}

List<String> _verify(File f) {
  if (f.existsSync()) return f.readAsLinesSync();
  stderr.writeln('[dotenv] Load failed: file not found: $f');
  return [];
}
