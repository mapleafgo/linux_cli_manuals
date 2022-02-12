import 'package:flutter_modular/flutter_modular.dart';
import 'package:linux_cli_manuals/app/pages/detail/detail_controller.dart';
import 'package:linux_cli_manuals/app/pages/detail/detail_page.dart';

class DetailModule extends Module {
  @override
  List<Bind> get binds => [Bind.factory((_) => DetailController())];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          "/:cli",
          child: (_, args) => DetailPage(cli: args.params['cli']),
        ),
      ];
}
