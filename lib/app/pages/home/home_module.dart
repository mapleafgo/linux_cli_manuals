import 'package:flutter_modular/flutter_modular.dart';
import 'package:linux_cli_manuals/app/pages/home/home_controller.dart';
import 'package:linux_cli_manuals/app/pages/home/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [Bind.factory((_) => HomeController())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => const HomePage()),
      ];
}
