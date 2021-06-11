import 'dart:io';

import 'package:args/args.dart';
import 'package:dotenv/dotenv.dart';

final _argPsr = new ArgParser()
  ..addFlag('help', abbr: 'h', negatable: false, help: 'Print this help text.')
  ..addOption('file',
      abbr: 'f',
      defaultsTo: '.env',
      help:
          'File to read.\nProvides environment variable definitions, one per line.')
  ..addFlag(
    'skip-platform',
    abbr: 's',
    help: 'Skip Platform environment variables',
  );

/// Prints the [dotEnv] map.
///
/// ## usage
///
///     pub global run dotenv --help
void main(List<String> argv) {
  var opts = _argPsr.parse(argv);

  if (opts['help'] == true) return _usage();
  var file = opts['file'] as String;
  if (opts.arguments.contains('-s')) {
    _loadAndPrint(DotEnv(), file);
    return;
  }

  _loadAndPrint(dotEnv, file);
}

void _loadAndPrint(DotEnv dotEnv, String file) {
  dotEnv.load(file);
  _p(dotEnv.env);
}

void _usage() {
  _p('Parse variable definitions from a file, print the environment and exit.');
  _p('Usage: pub global run dotenv [-f <file>]\n${_argPsr.usage}');
}

void _p(msg) => stdout.writeln(msg);
