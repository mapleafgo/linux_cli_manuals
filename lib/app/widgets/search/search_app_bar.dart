import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final double? toolbarHeight;

  const SearchAppBar(
      {Key? key,
      this.toolbarHeight,
      this.onChanged,
      this.onSubmitted,
      this.focusNode})
      : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: widget.preferredSize,
      child: Stack(
        children: [
          AppBar(backgroundColor: Colors.white),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: SafeArea(
              bottom: false,
              child: TextField(
                focusNode: widget.focusNode,
                controller: _textController,
                onChanged: widget.onChanged,
                onSubmitted: widget.onSubmitted,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    tooltip: "清空",
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _textController.clear();
                      widget.onSubmitted!("");
                    },
                  ),
                  border: InputBorder.none,
                  hintText: "搜索关键字",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
