import 'package:azlistview/azlistview.dart';

class ListItem extends ISuspensionBean {
  final List<TextSpanValue> name;
  final List<TextSpanValue> desc;
  final String path;
  final String _tag;

  ListItem(this.name, this.desc, this.path)
      : _tag = path.substring(1, 2).toUpperCase();

  @override
  String getSuspensionTag() => _tag;
}

class TextSpanValue {
  final String text;
  final bool isWord;

  TextSpanValue(this.text, this.isWord);
}
