import 'dart:io';

import 'package:dotenv/dotenv.dart' show load, clean, isEveryDefined, env;

void main() {
  load();

  _p('read all vars? ${isEveryDefined(['foo', 'baz'])}');

  _p('value of foo is ${env['foo']}');
  _p('value of baz is ${env['baz']}');
  _p('your home directory is: ${env['HOME']}');

  clean();

  _p('cleaned!');
  _p('env has key foo? ${env.containsKey('foo')}');
  _p('env has key baz? ${env.containsKey('baz')}');
  _p('your home directory is still: ${env['HOME']}');
}

_p(msg) => stdout.writeln(msg);
