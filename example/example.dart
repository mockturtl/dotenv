import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:logging/logging.dart';

get env => dotenv.env;

final log = new Logger('example');

void main() {
  _config();

  dotenv.load();
  log.info('main: value of foo is ${env['foo']}');
  log.info('main: value of baz is ${env['baz']}');
  log.info('main: your home directory is: ${env['HOME']}');
}

void _config() {
  Logger.root.level = Level.FINE;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name} ${_toMsg(rec)}');
  });
}

String _toMsg(LogRecord rec) =>
    '${rec.time}: [${rec.loggerName}] ${rec.message}';
