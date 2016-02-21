/// Loads environment variables from a `.env` file.
///
/// ## Usage
///
/// Use the top-level [env] map to access environment variables.
///
/// To load variables from a `.env` file, load it with [dotenv.load].
///
///     import 'package:dotenv/dotenv.dart';
///
///     void main() {
///       dotenv.load();  // filename optional
///       var x = env['MY_VAR'];
///     }
///
/// Note that variables from [Platform.environment] are included automatically.
///
/// Variables defined in the `.env` file will override values from [Platform.environment].
///
/// Verify required variables are present:
///
///     const _requiredEnvVars = const ['host', 'port'];
///     bool get hasEnv => dotenv.isEveryDefined(_requiredEnvVars);
///
/// This will check that each variable is set and its value is not `null` or empty.
library dotenv;

import 'dart:io';
import 'package:logging/logging.dart';

import 'package:dotenv/src/parser.dart';

/// An **unmodifiable** copy of [Platform.environment] including variables loaded at runtime from a file.
Map<String, String> get env => dotenv._toMap();

/// Wrapper for top-level functions.
const DotEnv dotenv = const DotEnv._();

/// Logger for this library.  Access via `Logger.root.children['dotenv']`.
final Logger _log = new Logger('dotenv');

/// Provides the public interface for the [dotenv] constant.
class DotEnv {
  static final Map<String, String> _env = new Map.from(Platform.environment);

  const DotEnv._();

  @override
  String toString() => _env.toString();

  /// Proxy for [Map.containsKey]. True if the key exists, even if its value is `null` or empty.
  bool containsKey(String k) => _env.containsKey(k);

  /// Reads variables from [filename] and adds them to the environment.
  /// Logs a warning if [filename] does not exist.
  void load([String filename = '.env', Parser psr = const Parser()]) {
    var f = new File.fromUri(new Uri.file(filename));
    var lines = _verify(f);
    _env.addAll(psr.parse(lines));
  }

  /// True if all supplied variables have nonempty value; false otherwise.
  /// Differs from [Map.containsKey] by excluding null and empty values.
  /// Note [dotenv.load] should be called first.
  bool isEveryDefined(Iterable<String> vars) =>
      vars.every((k) => _env[k] != null && _env[k].isNotEmpty);

  /// Overwrites [_env] with a new copy of [Platform.environment].
  void clean() {
    _env.clear();
    _env.addAll(Platform.environment);
  }

  Map _toMap() => new Map.unmodifiable(_env);

  List<String> _verify(File f) {
    if (f.existsSync()) {
      return f.readAsLinesSync();
    } else {
      _log.warning('Load failed. File not found: ${f}');
      return [];
    }
  }
}

/// Overwrite [_env] with a new writable copy of [Platform.environment].
///
/// **This function is deprecated, please use `dotenv.clean()` instead**
@deprecated
void clean() => dotenv.clean();

/// True if all supplied variables have nonempty value; false otherwise.
/// Differs from [containsKey](dart:core) by excluding null values.
/// Note `dotenv.load()` should be called first.
///
/// **This function is deprecated, please use `dotenv.isEveryDefined()` instead**
@deprecated
bool isEveryDefined(Iterable<String> vars) => dotenv.isEveryDefined(vars);

/// Read environment variables from [filename] and add them to environment.
/// Logs to [stderr] if [filename] does not exist.
///
/// **This function is deprecated, please use `dotenv.load()` instead**
@deprecated
void load([String filename = '.env', Parser psr = const Parser()]) {
  dotenv.load(filename, psr);
}
