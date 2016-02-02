import 'dart:io';

import 'package:args/args.dart';
import 'package:dotenv/dotenv.dart';

final _argPsr = new ArgParser()
  ..addFlag('help', abbr: 'h', negatable: false, help: 'Print this help text.')
  ..addOption('file',
      abbr: 'f',
      defaultsTo: '.env',
      help:
          'File to read.\nProvides environment variable definitions, one per line.');

/// Prints the environment map.
///
/// ## usage
///
///     pub global run dotenv --help
void main(List<String> argv) {
  var opts = _argPsr.parse(argv);

  if (opts['help']) return _usage();

  dotenv.load(opts['file']);
  _p(dotenv);
}

void _usage() {
  _p('Parse variable definitions from a file, print the environment and exit.');
  _p('Usage: pub global run dotenv [-f <file>]\n${_argPsr.usage}');
}

void _p(msg) => stdout.writeln(msg);
