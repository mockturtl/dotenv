/// Loads environment variables from a `.env` file.
///
/// ## usage
///
/// You can call [dotEnv.load()], to load the `.env` file
///
///     import 'package:dotenv/dotenv.dart';
///
///     void main() {
///       dotEnv.load();
///       var x = dotEnv['foo'];
///       // ...
///     }
///
/// Verify required variables are present:
///
///     const _requiredEnvVars = const ['host', 'port'];
///     bool get hasEnv => dotEnv.isEveryDefined(_requiredEnvVars);
///
/// `dotEnv` loads environment variables from `Platform.environment` as well.
/// You can also create new instance of `DotEnv` to load variables without
/// `Platform.environment` or to load from multiple sources.
library dotenv;

export 'package:dotenv/src/dotenv.dart';
export 'package:dotenv/src/legacy.dart';
