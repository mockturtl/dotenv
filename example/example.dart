import 'dart:io';

import 'package:dotenv/dotenv.dart' as dotenv;

void main() {
  dotenv.load();

  stdout.writeln('main: value of foo is ${env['foo']}');
  stdout.writeln('main: value of baz is ${env['baz']}');
  stdout.writeln('main: your home directory is: ${env['HOME']}');
}

get env => dotenv.env;
