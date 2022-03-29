import 'dart:io';
import 'dart:math';

import 'package:dotenv/src/parser.dart';
import 'package:test/test.dart';

void main() {
  group('Parser', () {
    setUp(() => rand = Random());
    var subj = ParserTest();
    test('it swallows "export"', subj.swallow);

    test('it strips trailing comments', subj.strip);
    test('it ignores comment lines', subj.strip_line);

    test('it handles unquoted values', subj.unquote_noop);
    test('it handles double quoted values', subj.unquote_double);
    test('it handles single quoted values', subj.unquote_single);
    test('it handles escaped quotes within values', subj.unquote_escape);

    test('it skips empty lines', subj.parse_empty);
    test('it ignores duplicate keys', subj.parse_dup);
    test('it substitutes known variables into other values', subj.parse_subs);
    test('it discards surrounding quotes', subj.parse_quot);

    test('it detects unquoted values', subj.surroundingQuote_none);
    test('it detects double-quoted values', subj.surroundingQuote_double);
    test('it detects single-quoted values', subj.surroundingQuote_single);

    test('it performs variable substitution', subj.interpolate);
    test('it skips undefined variables', subj.interpolate_missing);
    test('it handles explicitly null values in env', subj.interpolate_missing2);
    test('it falls back to the process environment for undefined variables',
        subj.interpolate_fallback);
    test('it handles \${surrounding braces} on vars', subj.interpolate_curlies);

    test('it handles equal signs in values', subj.parseOne_equals);
    test('it knows quoted # is not a comment', subj.parseOne_pound);
    test('it handles quotes in a comment',
        subj.parseOne_commentQuote_terminalChar);
    test('it does NOT handle comments ending with a quote',
        subj.parseOne_commentQuote_terminalChar2);
    test('it skips var substitution in single quotes', subj.parseOne_quot);
    test('it performs var subs in double quotes', subj.parseOne_doubleQuot);
    test('it performs var subs without quotes', subj.parseOne_unQuot);
  });
}

const ceil = 100000;

const _psr = const Parser();

late Random rand;

class ParserTest {
  void interpolate() {
    var out = _psr.interpolate(r'a$foo$baz', {'foo': 'bar', 'baz': 'qux'});
    expect(out, equals('abarqux'));
  }

  void interpolate_curlies() {
    var r = rand.nextInt(ceil); // avoid runtime collision with real env vars
    var out = _psr.interpolate('optional_\${foo_$r}', {'foo_$r': 'curlies'});
    expect(out, equals('optional_curlies'));
  }

  void interpolate_fallback() {
    var out = _psr.interpolate('a\$HOME', {});
    expect(out, equals('a${Platform.environment['HOME']}'));
  }

  void interpolate_missing() {
    var r = rand.nextInt(ceil); // avoid runtime collision with real env vars
    var out = _psr.interpolate('a\$jinx_$r', {});
    expect(out, equals('a'));
  }

  void interpolate_missing2() {
    var r = rand.nextInt(ceil); // avoid runtime collision with real env vars
    var out = _psr.interpolate('a\$foo_$r\$baz_$r', {'foo_$r': ''});
    expect(out, equals('a'));
  }

  void parse_dup() {
    var out = _psr.parse(['foo=bar', 'foo=baz']);
    expect(out, equals({'foo': 'bar'}));
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

  void parse_quot() {
    var out = _psr.parse([r"foo = 'bar'", r'export baz="qux"']);
    expect(out, equals({'foo': 'bar', 'baz': 'qux'}));
  }

  void parse_subs() {
    var out = _psr.parse(['foo=bar', r'baz=super$foo']);
    expect(out, equals({'foo': 'bar', 'baz': 'superbar'}));
  }

  void parseOne_commentQuote_terminalChar() {
    // note terminal whitespace
    var sing = _psr.parseOne("fruit = 'banana' # comments can be 'sneaky!' ");
    var doub = _psr.parseOne('fruit = "banana" # comments can be "sneaky!" ');
    var none = _psr.parseOne('fruit =  banana  # comments can be "sneaky!" ');

    expect(sing['fruit'], equals('banana'));
    expect(doub['fruit'], equals('banana'));
    expect(none['fruit'], equals('banana'));
  }

  void parseOne_commentQuote_terminalChar2() {
    var fail =
        _psr.parseOne('fruit = banana # I\'m a comment with a final "quote"');
    expect(
        fail['fruit'], equals('banana # I\'m a comment with a final "quote"'));
  }

  void parseOne_doubleQuot() {
    var r = rand.nextInt(ceil); // avoid runtime collision with real env vars
    var out = _psr.parseOne('some_var="my\$key_$r"', env: {'key_$r': 'val'});
    expect(out['some_var'], equals('myval'));
  }

  void parseOne_equals() {
    var none = _psr.parseOne('foo=bar=qux');
    var sing = _psr.parseOne("foo='bar=qux'");
    var doub = _psr.parseOne('foo="bar=qux"');

    expect(none['foo'], equals('bar=qux'));
    expect(sing['foo'], equals('bar=qux'));
    expect(doub['foo'], equals('bar=qux'));
  }

  void parseOne_pound() {
    var double = _psr.parseOne('foo = "ab#c"');
    var single = _psr.parseOne("foo = 'ab#c'");

    expect(double['foo'], equals('ab#c'));
    expect(single['foo'], equals('ab#c'));
  }

  void parseOne_quot() {
    var r = rand.nextInt(ceil); // avoid runtime collision with real env vars
    var out = _psr.parseOne("some_var='my\$key_$r'", env: {'key_$r': 'val'});
    expect(out['some_var'], equals('my\$key_$r'));
  }

  void parseOne_unQuot() {
    var r = rand.nextInt(ceil); // avoid runtime collision with real env vars
    var out = _psr.parseOne("some_var=my\$key_$r", env: {'key_$r': 'val'});
    expect(out['some_var'], equals('myval'));
  }

  void strip() {
    var out = _psr.strip(
        'needs=explanation  # It was the year when they finally immanentized the Eschaton.');
    expect(out, equals('needs=explanation'));
  }

  void strip_line() {
    var out =
        _psr.strip('  # It was the best of times, it was a waste of time.');
    expect(out, isEmpty);
  }

  void surroundingQuote_double() {
    var out = _psr.surroundingQuote('"double quoted"');
    expect(out, equals('"'));
  }

  void surroundingQuote_none() {
    var out = _psr.surroundingQuote('no quotes here!');
    expect(out, isEmpty);
  }

  void surroundingQuote_single() {
    var out = _psr.surroundingQuote("'single quoted'");
    expect(out, equals("'"));
  }

  void swallow() {
    var out = _psr.swallow(' export foo = bar  ');
    expect(out, equals('foo = bar'));
  }

  void unquote_double() {
    var out = _psr.unquote('"val"');
    expect(out, equals('val'));
  }

  void unquote_escape() {
    var out = _psr.unquote("val_with_\"escaped\"_\'quote\'s");
    expect(out, equals('''val_with_"escaped"_'quote's'''));
  }

  void unquote_noop() {
    var out = _psr.unquote('str');
    expect(out, equals('str'));
  }

  void unquote_single() {
    var out = _psr.unquote("'val'");
    expect(out, equals('val'));
  }
}
