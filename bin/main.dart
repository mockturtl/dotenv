// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dotenv/dotenv.dart';
import 'package:logging/logging.dart';
import 'package:pico_log/pico_log.dart';
import 'dart:io';

final env = new Map.from(Platform.environment);
final pkgroot = Platform.script.resolve('..');
final f = new File.fromUri(pkgroot.resolve('.env'));

final log = new Logger('main');

main() {
  LogInit.setup();

  _verify(f);

  var lines = f.readAsLinesSync();
  _verifyLineFormat(lines);

  var _vars = {};
  lines.forEach((line) {
    var substrs = line.split('=');
    var rawK = substrs[0];
    var k = rawK.replaceAll('export', '').trim();
    var rawV = substrs[1];
    var v = rawV
        .replaceAll(new RegExp(r'"'), '')     // double-quoted values
        .replaceAll(new RegExp(r"'"), '')     // single-quoted values
        .replaceAll(new RegExp(r'#.*$'), '')  // comments
        .trim();                              // TODO: variable substitution
    _vars[k] = v;
  });

  _vars.forEach((k, v) {
    log.fine('env: $k = $v');
  });

  env.addAll(_vars);
}

void _verifyLineFormat(Iterable lines) {
  if (!lines.every((String l) => l.contains('='))) {
    log.severe('Missing "="; aborting');
    exit(13);
  }
}

void _verify(File f) {
  if (!f.existsSync()) {
    log.severe('Cannot find "$f"; aborting.');
    exit(11);
  }
}
