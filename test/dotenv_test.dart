library dotenv.tests;

import 'dart:io';
import 'dart:mirrors';

import 'package:collection/equality.dart' show MapEquality;
import 'package:dotenv/dotenv.dart';
import 'package:test/test.dart';

const extra = const {'servlets': 'yes', 'rats': 'yes', 'horses': 'omgyes'};
const vars = const {'x': '1', 'y': 'false', 'z': 'foo', 'empty': ''};

void main() {
  group('[dotenv]', () {
    // Workaround due to current limitations of `test` package:
    // See: https://github.com/dart-lang/test/issues/110 for details.
    var libPath = currentMirrorSystem().findLibrary(#dotenv.tests).uri.path;
    var varsFilename =
        libPath.replaceFirst('dotenv_test.dart', 'resources/vars.env');
    var extrasFilename =
        libPath.replaceFirst('dotenv_test.dart', 'resources/extra.env');

    setUp(() {
      dotenv.load(varsFilename);
    });

    tearDown(() {
      dotenv.clean();
    });

    test('it can clean previously defined variables', () {
      dotenv.clean();
      extra.keys.forEach((k) => expect(dotenv.containsKey(k), isFalse));
    });

    test('it is equal to the read-only process environment when clean', () {
      dotenv.clean();
      var eq = const MapEquality();
      expect(eq.equals(env, Platform.environment), isTrue);
    });

    test('it confirms all required vars are defined', () {
      dotenv.load(extrasFilename);
      expect(dotenv.isEveryDefined(['x', 'y', 'z']), isTrue);
      expect(dotenv.isEveryDefined(['servlets', 'rats', 'horses']), isTrue);
    });

    test('it fails when a required var is not defined', () {
      dotenv.load(extrasFilename);
      expect(dotenv.isEveryDefined(['empty']), isFalse);
      expect(dotenv.isEveryDefined(['no_such_key']), isFalse);
    });

    test('it loads the file', () {
      dotenv.load(extrasFilename);
      expect(env['servlets'], equals('yes'));
      expect(env['rats'], equals('yes'));
      expect(env['horses'], equals('omgyes'));
    });

    test('deprecated api works', () {
      load(extrasFilename);
      expect(env['servlets'], equals('yes'));
      expect(env['rats'], equals('yes'));
      expect(env['horses'], equals('omgyes'));

      clean();
      expect(env.containsKey('servlets'), isFalse);
    });
  });
}
