@Skip("tbd")
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

void main() => run();

void run() {
  group('[Parser]', () {
    var subj = new ParserTest();
    test('it parses', subj.parse);
    test('it parses', subj.parse);
    test('it parses', subj.die);
    test('it parses', subj.parse);
  });
}

const _psr = const Parser();

class ParserTest {
  void parse() {
    expect(true, isTrue);
  }

  void die() {
    expect(false, isTrue);
  }
}
