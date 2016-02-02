/// Loads environment variables from a `.env` file.
///
/// ## Usage
///
/// Use top-level [dotenv] constant to access environment variables.
///
/// In order to use variables defined in `.env` file one must first load it with
/// `dotenv.load()`.
///
///     import 'package:dotenv/dotenv.dart';
///
///     void main() {
///       dotenv.load();
///       var x = dotenv['MY_VAR'];
///     }
///
/// Note that variables from [Platform.environment] will be loaded automatically.
///
/// > Variables defined in `.env` file will override variable values from
/// > [Platform.environment] if names are the same.
///
/// Verify required variables are present:
///
///     const _requiredEnvVars = const ['host', 'port'];
///     bool get hasEnv => dotenv.isEveryDefined(_requiredEnvVars);
///
/// The above code will check that each variable is set and it's value is not
/// `null` and not empty.
library dotenv;

import 'dart:io';
import 'package:logging/logging.dart';

part 'src/parser.dart';

/// Logger for this library.
///
/// Can be accessed by client code via `Logger.root.children['dotenv']`.
final Logger _logger = new Logger('dotenv');

/// A copy of [Platform.environment](dart:io) including variables loaded at
/// runtime from a file.
const DotEnv dotenv = const DotEnv._();

/// Provides public interface for [dotenv] constant.
class DotEnv {
  static final Map _env = new Map.from(Platform.environment);

  const DotEnv._();

  /// Returns value of environment variable specified by [name]. If
  /// variable does not exist returns `null`, so this method can not be used
  /// to test for variable presence.
  ///
  /// To test if variable exists one must use [has] or [isEveryDefined].
  String operator [](String name) => _env[name];

  /// Returns `true` if environment variable exists. This will return `true`
  /// even if variable value is set to `null` or is empty.
  ///
  /// This is equivalent to `Map.containsKey()`.
  bool has(String name) => _env.containsKey(name);

  /// Returns unmodifiable map with all environment variables.
  Map toMap() => new Map.unmodifiable(_env);

  /// Reads variables from [filename] and adds them to environment.
  /// Logs a warning if [filename] does not exist.
  void load([String filename = '.env', Parser parser = const Parser()]) {
    var f = new File.fromUri(new Uri.file(filename));
    var lines = _verify(f);
    _env.addAll(parser.parse(lines));
  }

  List<String> _verify(File f) {
    if (f.existsSync()) {
      return f.readAsLinesSync();
    } else {
      _logger.warning('Load failed. File not found: ${f}');
      return [];
    }
  }

  /// True if all supplied variables have nonempty value; false otherwise.
  /// Differs from [Map.containsKey] by excluding null values.
  /// Note [dotenv.load] should be called first.
  bool isEveryDefined(Iterable<String> vars) =>
      vars.every((k) => _env[k] != null && _env[k].isNotEmpty);

  /// Overwrite environment with a new copy of
  /// [Platform.environment](dart:io).
  void clean() {
    _env.clear();
    _env.addAll(Platform.environment);
  }

  @override
  String toString() => _env.toString();
}

/// A copy of [Platform.environment](dart:io) including variables loaded
/// at runtime from a file.
///
/// This returns __modifiable__ map so it is possible to make changes to
/// environment directly via returned map object. One should not rely on this
/// functionality since it's considered deprecated and will be removed in
/// consequent releases.
///
/// **This function is deprecated, please use top-level [dotenv] constant.**
@deprecated
Map<String, String> get env => DotEnv._env;

/// Overwrite environment with a new writable copy of
/// [Platform.environment](dart:io).
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
