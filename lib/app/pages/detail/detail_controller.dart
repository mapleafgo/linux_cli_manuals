import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:linux_cli_manuals/app/pages/detail/model/detail_model.dart';

class DetailController extends Disposable {
  final DetailModel _model = DetailModel();

  String get data => _model.value;

  Future init(keyword) {
    var article = rootBundle.loadString("assets/command/$keyword.md");
    return article.then((value) => _model.reset(value));
  }

  @override
  void dispose() {}
}
