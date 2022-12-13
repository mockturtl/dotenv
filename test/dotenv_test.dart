import 'package:collection/collection.dart' show MapEquality;
import 'package:dotenv/src/dotenv.dart';
import 'package:test/test.dart';

void main() {
  group('DotEnv', () {
    late DotEnv subj;
    setUp(() {
      subj = DotEnv();
      subj.addAll(_vars);
    });

    group('clear:', () {
      test('removes previously defined variables', () {
        subj.addAll(_extra);
        subj.clear();
        _extra.keys.forEach((k) => expect(subj.map.containsKey(k), false));
        _vars.keys.forEach((k) => expect(subj.map.containsKey(k), false));
      });

      test('has map equality with the empty map', () {
        bool isEmptyMap(Map<String, String> other) =>
            const MapEquality().equals(other, Map<String, String>.of({}));

        expect(isEmptyMap(subj.map), false);
        subj.clear();
        expect(isEmptyMap(subj.map), true);
      });
    });

    group('operator[]', () {
      test('reads a value', () {
        expect(subj['x'], '1');
      });

      test('returns null when key is absent', () {
        expect(subj['nope'], null);
      });
    });

    group('addAll:', () {
      test('inserts new entries', () {
        subj.map.addAll(_extra);
        _extra.keys.forEach((k) => expect(subj.map.containsKey(k), true));
      });
    });

    group('isEveryDefined:', () {
      test('confirms all required vars exist', () {
        subj.map.addAll(_extra);
        var nonempty = _vars.keys.where((k) => _vars[k]!.isNotEmpty);
        expect(subj.isEveryDefined(nonempty), true);
        expect(subj.isEveryDefined(_extra.keys), true);
      });

      test('it fails when a required var is not defined', () {
        expect(subj.isEveryDefined(['empty']), false);
        expect(subj.isEveryDefined(['no_such_key']), false);
      });
    });

    group('load', () {
      test('it loads the file', () {
        subj.load(['test/fixtures/.test_env']);
        expect(subj['some_test'], 'value');
      });
    });
    group('getOrElse', () {
      test('reads a value', () {
        expect(
          subj.getOrElse('x', () => throw Exception('Should get value of 1')),
          '1',
        );
      });
      test('calls orElse when value is not defined', () {
        final got = subj.getOrElse('nope', () => 'value');
        expect(got, 'value');
        expect(
          () => subj.getOrElse('nope', () => throw Exception()),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}

const _extra = const {'servlets': 'yes', 'rats': 'yes', 'horses': 'omgyes'};
const _vars = const {'x': '1', 'y': 'false', 'z': 'foo', 'empty': ''};
