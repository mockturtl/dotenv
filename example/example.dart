import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:logging/logging.dart';
import 'package:pico_log/pico_log.dart';

get env => dotenv.env;

final log = new Logger('example');

void main() {
  LogInit.setup(level: Level.FINE);
  dotenv.load();
  log.info('main: value of foo is ${env['foo']}');
  log.info('main: value of baz is ${env['baz']}');
}
