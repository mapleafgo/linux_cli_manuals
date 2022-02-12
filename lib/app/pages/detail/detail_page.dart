import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:linux_cli_manuals/app/pages/detail/detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final String cli;

  const DetailPage({Key? key, required this.cli}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends ModularState<DetailPage, DetailController> {
  @override
  void initState() {
    super.initState();
    controller.init(widget.cli);
  }

  void _launchURL() async {
    var url =
        "https://github.com/jaywcjlove/linux-command/tree/master/command/${widget.cli}.md";
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cli),
        actions: [
          IconButton(
            tooltip: "访问源",
            onPressed: _launchURL,
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: Observer(builder: (_) => Markdown(data: controller.data)),
    );
  }
}
