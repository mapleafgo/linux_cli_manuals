import 'dart:ui';

import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double? toolbarHeight;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const SearchAppBar(
      {Key? key, this.toolbarHeight, this.onChanged, this.onSubmitted})
      : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  var textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
            child: TextField(
              controller: textController,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              autofocus: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  tooltip: "清空",
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    textController.clear();
                    widget.onSubmitted!("");
                  },
                ),
                border: InputBorder.none,
                hintText: "搜索关键字",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
