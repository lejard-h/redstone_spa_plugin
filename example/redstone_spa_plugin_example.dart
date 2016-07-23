// Copyright (c) 2016, Hadrien Lejard. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:redstone/redstone.dart' as Redstone;
import 'package:redstone_spa_plugin/redstone_spa_plugin.dart';

main() {
  String pathToWebDebug = "../web";
  String pathToWebRelease = "../build/web";

  Redstone.addPlugin(RedstoneSpaPlugin(pathToWebDebug, [r"\/ignore(.*)", r"\/path-to-ignore(.*)", r"\/api(.*)"]));

  Redstone.start();
}
