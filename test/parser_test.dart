import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

void main() {
  group('[Parser]', () {
    var subj = new ParserTest();
    test('it swallows "export"', subj.swallow);

    test('it strips trailing comments', subj.strip);
    test('it ignores comment lines', subj.strip_line);

    test('it handles unquoted values', subj.unquote_noop);
    test('it handles double quoted values', subj.unquote_double);
    test('it handles single quoted values', subj.unquote_single);
    test('it handles escaped quotes within values', subj.unquote_escape);

    test('it skips empty lines', subj.parse_empty);
    test('it ignores duplicate keys', subj.parse_dup);
  });
}

const _psr = const Parser();

class ParserTest {
  void swallow() {
    var out = _psr.swallow(' export foo = bar  ');
    expect(out, equals('foo = bar'));
  }

  void strip() {
    var out = _psr.strip(
        'needs=explanation  # It was the year when they finally immanentized the Eschaton.');
    expect(out, equals('needs=explanation'));
  }

  void strip_line() {
    var out =
        _psr.strip('  # It was the best of times, it was a waste of time.');
    expect(out, equals(''));
  }

  void unquote_single() {
    var out = _psr.unquote("'val'");
    expect(out, equals('val'));
  }

  void unquote_noop() {
    var out = _psr.unquote('str');
    expect(out, equals('str'));
  }

  void unquote_double() {
    var out = _psr.unquote('"val"');
    expect(out, equals('val'));
  }

  void unquote_escape() {
    var out = _psr.unquote("val_with_\"escaped\"_\'quote\'s");
    expect(out, equals('''val_with_"escaped"_'quote's'''));
  }

  void parse_empty() {
    var out = _psr.parse([
      '# Define environment variables.',
      '  # comments will be stripped',
      'foo=bar  # trailing junk',
      ' baz =    qux',
      '# another comment'
    ]);
    expect(out, equals({'foo': 'bar', 'baz': 'qux'}));
  }

  void parse_dup() {
    var out = _psr.parse(['foo=bar', 'foo=baz']);
    expect(out, equals({'foo': 'bar'}));
  }
}
