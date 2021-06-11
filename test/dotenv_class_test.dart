import 'package:collection/collection.dart' show MapEquality;
import 'package:dotenv/dotenv.dart';
import 'package:test/test.dart';

void main() {
  group('[dotenv]', () {
    var subj = DotenvTest();
    setUp(() => subj.dotenv.env.addAll(vars));
    tearDown(() => subj.dotenv.clear());

    test('it can clean previously defined variables', subj.clean);
    test('it is equal to empty map when clean', subj.clean2);
    test('it confirms all required vars are defined', subj.every);
    test('it fails when a required var is not defined', subj.every_fail);
    test('it loads the file', subj.load, skip: 'pending');
  });
}

const extra = const {'servlets': 'yes', 'rats': 'yes', 'horses': 'omgyes'};
const vars = const {'x': '1', 'y': 'false', 'z': 'foo', 'empty': ''};

class DotenvTest {
  var dotenv = DotEnv();

  void clean() {
    dotenv.env.addAll(extra);
    dotenv.clear();
    extra.keys.forEach((k) => expect(dotenv.env.containsKey(k), isFalse));
    vars.keys.forEach((k) => expect(dotenv.env.containsKey(k), isFalse));
  }

  void clean2() {
    expect(_clean, isFalse);
    dotenv.clear();
    expect(_clean, isTrue);
  }

  void every() {
    dotenv.env.addAll(extra);
    expect(dotenv.isEveryDefined(['x', 'y', 'z']), isTrue);
    expect(dotenv.isEveryDefined(['servlets', 'rats', 'horses']), isTrue);
  }

  void every_fail() {
    expect(dotenv.isEveryDefined(['empty']), isFalse);
    expect(dotenv.isEveryDefined(['no_such_key']), isFalse);
  }

  void load() {}

  bool get _clean => const MapEquality().equals(dotenv.env, Map.identity());
}
