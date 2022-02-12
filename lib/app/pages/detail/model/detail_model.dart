import 'package:mobx/mobx.dart';

part 'detail_model.g.dart';

class DetailModel = _DetailModel with _$DetailModel;

abstract class _DetailModel with Store {
  @observable
  String value = "";

  @action
  void reset(String data) {
    value = data;
  }
}
