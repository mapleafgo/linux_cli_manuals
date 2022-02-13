import 'package:azlistview/azlistview.dart';
import 'package:linux_cli_manuals/app/pages/home/model/list_item.dart';
import 'package:mobx/mobx.dart';

part 'cli_list_model.g.dart';

class CliListModel = _CliListModel with _$CliListModel;

abstract class _CliListModel with Store {
  @observable
  ObservableList<ListItem> value = ObservableList<ListItem>();

  @action
  void reset(List<ListItem> array) {
    value.clear();
    SuspensionUtil.setShowSuspensionStatus(array);
    value.addAll(array);
  }
}
