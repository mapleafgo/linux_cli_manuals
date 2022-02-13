import 'package:azlistview/azlistview.dart';
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
  final double _susItemHeight = 30;

  @override
  void initState() {
    super.initState();
    controller.init().then((_) => controller.filter(""));
  }

  @override
  void didChangeDependencies() {
    SuspensionUtil.setShowSuspensionStatus(controller.data);
    super.didChangeDependencies();
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

  Widget _getSusItem(BuildContext context, String name) {
    return Container(
      height: _susItemHeight,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16.0),
      color: const Color(0xffdcdcdc),
      alignment: Alignment.centerLeft,
      child: Text(
        name,
        softWrap: false,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black87,
        ),
      ),
    );
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
          return AzListView(
            itemScrollController: controller.scrollController,
            data: controller.data,
            itemCount: controller.data.length,
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
                  ),
                ),
                onTap: () => controller.detail(item.path),
              );
            },
            susItemHeight: _susItemHeight,
            susItemBuilder: (cxt, i) {
              var item = controller.data[i];
              return _getSusItem(cxt, item.getSuspensionTag());
            },
          );
        },
      ),
    );
  }
}
