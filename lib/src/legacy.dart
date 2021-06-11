import 'dart:io';
import 'package:dotenv/src/dotenv.dart';

final dotEnv = DotEnv()..env.addAll(Platform.environment);

/// A copy of [Platform.environment](dart:io) including variables loaded at runtime from a file.
@Deprecated("Use dotEnv directly or create a new instance of DotEnv")
Map<String, String> get env => dotEnv.env;

/// Overwrite [env] with a new writable copy of [Platform.environment](dart:io).
@Deprecated("Use dotEnv directly or create a new instance of DotEnv")
Map<String, String> clean() => (dotEnv
  ..clear()
  ..addAll(Platform.environment))
    .env;

/// True if all supplied variables have nonempty value; false otherwise.
/// Differs from [containsKey](dart:core) by excluding null values.
/// Note [load] should be called first.
@Deprecated("Use dotEnv directly or create a new instance of DotEnv")
final bool Function(Iterable<String>) isEveryDefined = dotEnv.isEveryDefined;

/// Read environment variables from [filename] and add them to [env].
/// Logs to [stderr] if [filename] does not exist.
@Deprecated("Use dotEnv directly or create a new instance of DotEnv")
void load([String filename = '.env', Parser psr = const Parser()]) =>
    dotEnv.load(filename, psr);
