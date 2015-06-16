import 'dart:io';

import 'package:dotenv/dotenv.dart' show load, clean, isEveryDefined, env;

void main() {
  load();

  p('read all vars? ${isEveryDefined(['foo', 'baz'])}');

  p('value of foo is ${env['foo']}');
  p('value of baz is ${env['baz']}');
  p('your home directory is: ${env['HOME']}');

  clean();

  p('cleaned!');
  p('env has key foo? ${env.containsKey('foo')}');
  p('env has key baz? ${env.containsKey('baz')}');
  p('your home directory is still: ${env['HOME']}');
}

p(String msg) => stdout.writeln(msg);
