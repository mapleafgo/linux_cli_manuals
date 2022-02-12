import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:linux_cli_manuals/app/pages/home/home_controller.dart';
import 'package:linux_cli_manuals/app/pages/home/model/list_item.dart';
import 'package:linux_cli_manuals/app/widgets/search/search_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    super.initState();
    controller.init().then((_) => controller.filter(""));
  }

  List<TextSpan> _getTextSpan(BuildContext context, List<TextSpanValue> value) {
    List<TextSpan> list = [];
    for (var item in value) {
      list.add(TextSpan(
        text: item.text,
        style: item.isWord
            ? TextStyle(color: Theme.of(context).primaryColor)
            : null,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        onChanged: controller.filter,
        onSubmitted: controller.filter,
      ),
      body: Observer(
        builder: (_) {
          return ListView.separated(
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (cxt, i) {
              var item = controller.data[i];
              return ListTile(
                title: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(cxt).style,
                    children: _getTextSpan(cxt, item.name),
                  ),
                ),
                subtitle: RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(cxt).style,
                  children: _getTextSpan(cxt, item.desc),
                )),
                onTap: () => controller.detail(item.path),
              );
            },
            itemCount: controller.data.length,
          );
        },
      ),
    );
  }
}
