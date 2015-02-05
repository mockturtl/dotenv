library parser.test;

import 'package:unittest/unittest.dart';
import 'package:dotenv/dotenv.dart';

void main() => run();

void run() {
  skip_group('[Parser]', () {
    var subj = new ParserTest();
    test('it parses', subj.parse);
  });
}

const _psr = const Parser();

class ParserTest {
  void parse() {}
}
