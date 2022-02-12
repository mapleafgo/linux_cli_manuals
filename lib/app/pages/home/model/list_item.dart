class ListItem {
  final List<TextSpanValue> name;
  final List<TextSpanValue> desc;
  final String path;

  ListItem(this.name, this.desc, this.path);
}

class TextSpanValue {
  final String text;
  final bool isWord;

  TextSpanValue(this.text, this.isWord);
}
