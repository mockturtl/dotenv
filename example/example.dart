import 'dart:io';

import 'package:dotenv/dotenv.dart' show dotenv;

void main() {
  dotenv.load();

  p('read all vars? ${dotenv.isEveryDefined(['foo', 'baz'])}');

  p('value of foo is ${dotenv['foo']}');
  p('value of baz is ${dotenv['baz']}');
  p('your home directory is: ${dotenv['HOME']}');

  dotenv.clean();

  p('cleaned!');
  p('env has key foo? ${dotenv.has('foo')}');
  p('env has key baz? ${dotenv.has('baz')}');
  p('your home directory is still: ${dotenv['HOME']}');
}

p(String msg) => stdout.writeln(msg);
