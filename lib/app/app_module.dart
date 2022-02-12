import 'package:flutter_modular/flutter_modular.dart';
import 'package:linux_cli_manuals/app/pages/detail/detail_module.dart';
import 'package:linux_cli_manuals/app/pages/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => const [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute("/", module: HomeModule()),
        ModuleRoute("/detail", module: DetailModule()),
      ];
}
