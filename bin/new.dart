import 'dart:io';

const String envFile = '.env';
const String gitignore = '.gitignore';

/// Creates `.env` if the file does not exist, and adds it to `.gitignore`.
void main() {
  _touch(envFile);

  var g = _touch(gitignore);
  if (_anyLineContains(envFile, g)) return _handleError();

  g.writeAsStringSync('$envFile*\n', mode: FileMode.APPEND);
  stdout.writeln('Added \'$envFile*\' to $gitignore.');
}

bool _anyLineContains(String str, File f) =>
    f.readAsLinesSync().any((line) => line.contains(str));

void _handleError() {
  stderr
      .writeln('Found $gitignore with line containing \'$envFile\'; exiting.');
  exitCode = 1;
}

File _touch(String filename) {
  var f = new File.fromUri(new Uri.file(filename));
  if (f.existsSync()) return f;

  f.createSync();
  stdout.writeln('Created file: $filename');
  return f;
}
