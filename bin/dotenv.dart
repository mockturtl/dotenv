import 'dart:io';

import 'package:dotenv/dotenv.dart' as dotenv;

/// Prints the [env] map.
void main() {
  dotenv.load();
  stdout.writeln(dotenv.env);
}
