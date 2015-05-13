import 'dart:io';

import 'package:dotenv/dotenv.dart' as dotenv;

void main() {
  dotenv.load();

  stdout.writeln('read all vars? ${dotenv.isEveryDefined(['foo', 'baz'])}');

  stdout.writeln('value of foo is ${env['foo']}');
  stdout.writeln('value of baz is ${env['baz']}');
  stdout.writeln('your home directory is: ${env['HOME']}');

  dotenv.clean();

  stdout.writeln('cleaned!');
  stdout.writeln('env has key foo? ${env.containsKey('foo')}');
  stdout.writeln('env has key baz? ${env.containsKey('baz')}');
  stdout.writeln('your home directory is still: ${env['HOME']}');
}

get env => dotenv.env;
