import 'dart:io';

import 'package:args/args.dart';

/// Creates `.env` if the file does not exist, and adds it to `.gitignore`.
///
/// ## usage
///
///     dart pub global run dotenv:new --help
void main(List<String> args) {
  var opts = _argPsr.parse(args);

  if (opts.wasParsed(_flagHelp)) return _usage();

  String envFile = opts[_flagFilename].toString();
  _touch(envFile);

  var g = _touch(gitignore);
  if (_anyLineContains(envFile, g)) return _handleIgnored(envFile);

  _appendTo(g, '$envFile*');
}

const String gitignore = '.gitignore';

const _flagFilename = 'filename';
const _flagHelp = 'help';

final _argPsr = new ArgParser()
  ..addFlag(_flagHelp,
      abbr: 'h', negatable: false, help: 'Print this help text.')
  ..addOption(_flagFilename,
      abbr: 'f',
      defaultsTo: '.env',
      help: 'File to create.\nDo not check secrets into version control!');

bool _anyLineContains(String str, File f) =>
    f.readAsLinesSync().any((line) => line.contains(str));

void _appendTo(File f, String line) {
  f.writeAsStringSync('$line\n', mode: FileMode.append);
  _p("Added '$line' to ${f.path}.");
}

void _handleIgnored(String filename) {
  _pErr("Found $gitignore with line containing '$filename'; exiting.");
  exitCode = 1;
}

void _p(String msg) => stdout.writeln(msg);

void _pErr(String msg) => stderr.writeln(msg);

File _touch(String filename) {
  var f = new File.fromUri(new Uri.file(filename));
  if (f.existsSync()) return f;

  f.createSync();
  _p('Created file: $filename');
  return f;
}

void _usage() {
  _p('Create a new file and gitignore it.');
  _p('Usage: pub global run dotenv:new [-f <file>]\n${_argPsr.usage}');
}
