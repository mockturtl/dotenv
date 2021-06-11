library dotenv;

import 'dart:io';

import 'package:meta/meta.dart';

part 'parser.dart';

class DotEnv {
  var _env = Map<String, String>();

  DotEnv();

  String operator [](String index) => _env[index]!;

  void addAll(Map<String, String> variableMap) => _env.addAll(variableMap);

  /// Variables loaded at runtime from a file
  Map<String, String> get env => _env;

  /// Remove all variables from [env]
  Map<String, String> clear() => _env..clear();

  /// True if all supplied variables have nonempty value; false otherwise.
  /// Differs from [containsKey](dart:core) by excluding null values.
  /// Note [load] should be called first.
  bool isEveryDefined(Iterable<String> vars) =>
      vars.every((k) => (_env[k]?.isNotEmpty ?? false));

  List<String> _verify(File f) {
    if (f.existsSync()) return f.readAsLinesSync();
    stderr.writeln('[dotenv] Load failed: file not found: $f');
    return [];
  }

  /// Read environment variables from [filename] and add them to [env].
  /// Logs to [stderr] if [filename] does not exist.
  void load([String filename = '.env', Parser psr = const Parser()]) {
    var f = new File.fromUri(new Uri.file(filename));
    var lines = _verify(f);
    _env.addAll(psr.parse(lines));
  }
}
