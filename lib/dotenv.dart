/// Loads environment variables from a `.env` file.
///
/// ## usage
///
/// Call [DotEnv.load] to parse the file(s).
/// Read variables from the underlying [Map] using the `[]` operator.
///
///     import 'package:dotenv/dotenv.dart';
///
///     void main() {
///       var env = DotEnv(includePlatformEnvironment: true)
///         ..load('path/to/my/.env');
///       var foo = env['foo'];
///       var homeDir = env['HOME'];
///       // ...
///     }
///
/// Verify required variables are present:
///
///     const _requiredEnvVars = ['host', 'port'];
///     bool get hasEnv => env.isEveryDefined(_requiredEnvVars);
export 'package:dotenv/src/dotenv.dart';
