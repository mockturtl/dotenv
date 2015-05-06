library dotenv.test;

import 'dart:io';
import 'package:collection/equality.dart' show MapEquality;
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:test/test.dart';

void main() => run();

void run() {
  group('[dotenv]', () {
    var subj = new DotenvTest();

    setUp(() => dotenv.env.addAll(vars));
    tearDown(() => dotenv.clean());

    test('it can clean previously defined variables', subj.clean);
    test('it is equal to the read-only process environment when clean',
        subj.clean2);
    test('it confirms all required vars are defined', subj.every);
    test('it fails when a required var is not defined', subj.every_fail);
  });

  group('load', () {
    var subj = new DotenvTest();
    test('it', subj.load);
  }, skip: 'pending');
}

const extra = const {'servlets': 'yes', 'rats': 'yes', 'horses': 'omgyes'};
const vars = const {'x': '1', 'y': 'false', 'z': 'foo', 'empty': ''};

class DotenvTest {
  void clean() {
    dotenv.env.addAll(extra);
    dotenv.clean();
    extra.keys.forEach((k) => expect(dotenv.env.containsKey(k), isFalse));
    vars.keys.forEach((k) => expect(dotenv.env.containsKey(k), isFalse));
  }

  void clean2() {
    expect(_clean, isFalse);
    dotenv.clean();
    expect(_clean, isTrue);
  }

  void load() {}

  void every() {
    dotenv.env.addAll(extra);
    expect(dotenv.isEveryDefined(['x', 'y', 'z']), isTrue);
    expect(dotenv.isEveryDefined(['servlets', 'rats', 'horses']), isTrue);
  }

  void every_fail() {
    expect(dotenv.isEveryDefined(['empty']), isFalse);
    expect(dotenv.isEveryDefined(['no_such_key']), isFalse);
  }
}

bool get _clean => const MapEquality().equals(dotenv.env, Platform.environment);
