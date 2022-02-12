import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:linux_cli_manuals/app/app_module.dart';
import 'package:linux_cli_manuals/app/app_widget.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    // 必须加上这一行。
    await windowManager.ensureInitialized();

    // Use it only after calling `hiddenWindowAtLaunch`
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.hide();
      await windowManager.setSize(const Size(800, 600));
      await windowManager.center();
      await windowManager.setTitle("Linux Cli Manuals");
      await windowManager.show();
    });
  }

  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}
