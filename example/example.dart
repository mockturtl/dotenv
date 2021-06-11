import 'dart:io';

import 'package:dotenv/dotenv.dart';

void main() {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  p('read all vars? ${env.isEveryDefined(['foo', 'baz'])}');

  p('foo=${env['foo']}');
  p('baz=${env['baz']}');
  p('your home directory is: ${env['HOME']}');

  env.clear();
  p('cleared!');

  p('env has key foo? ${env.isDefined('foo')}');
  p('env has key baz? ${env.isDefined('baz')}');
  p('your home directory is still: ${env['HOME']}');
}

p(String msg) => stdout.writeln(msg);
