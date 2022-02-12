import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:linux_cli_manuals/app/pages/home/model/cli_list_model.dart';
import 'package:linux_cli_manuals/app/pages/home/model/list_item.dart';

/// 首页控制器
class HomeController extends Disposable {
  final CliListModel _list = CliListModel();
  final List<Map<String, String>> _source = [];

  List<ListItem> get data => _list.value;

  @override
  void dispose() {}

  /// 读取列表过滤
  Future init() {
    var indexes = rootBundle.loadString("assets/dist/data.json");
    return indexes.then((value) => json.decode(value)).then((value) {
      if (value is Map<String, dynamic>) {
        for (var element in value.values) {
          _source.add(Map.castFrom<String, dynamic, String, String>(
              element as Map<String, dynamic>));
        }
      }
    });
  }

  /// 关键字过滤
  filter(String keyword) {
    if (keyword.isEmpty) {
      var tmpList = _source
          .map((e) => ListItem(
                [TextSpanValue(e['n']!, false)],
                [TextSpanValue(e['d']!, false)],
                e['p']!,
              ))
          .toList();
      _list.reset(tmpList);
      return;
    }

    Map<String, ListItem> tmpMap = {};

    for (var element in _source) {
      var key = element['n']!;
      if (key.startsWith(keyword)) {
        tmpMap.putIfAbsent(
          key,
          () {
            return ListItem(
              _splitSpan(key, keyword),
              [TextSpanValue(element['d']!, false)],
              element['p']!,
            );
          },
        );
      }
    }
    for (var element in _source) {
      var key = element['n']!;
      if (key.contains(keyword)) {
        tmpMap.putIfAbsent(
          key,
          () {
            return ListItem(
              _splitSpan(key, keyword),
              [TextSpanValue(element['d']!, false)],
              element['p']!,
            );
          },
        );
      }
    }
    for (var element in _source) {
      var key = element['n']!;
      var desc = element['d']!;
      if (element['d']!.contains(keyword)) {
        tmpMap.putIfAbsent(
          key,
          () {
            return ListItem(
              [TextSpanValue(key, false)],
              _splitSpan(desc, keyword),
              element['p']!,
            );
          },
        );
      }
    }

    _list.reset(tmpMap.values.toList());
  }

  /// 将匹配关键字染色
  _splitSpan(String s, String k) {
    var index = s.indexOf(k);
    return [
      TextSpanValue(s.substring(0, index), false),
      TextSpanValue(s.substring(index, index + k.length), true),
      TextSpanValue(s.substring(index + k.length), false),
    ];
  }

  // _filter(bool Function(Map<String, String>  e) check,
  //     Function(String key, Map<String, String>  e) put,
  //     ) {
  //   for (var element in _source) {
  //     var key = element['n']!;
  //     var desc = element['d']!;
  //     if (check(element)) {
  //       put(
  //         key,e
  //             () {
  //           var list = desc.split(keyword);
  //           return ListItem(
  //             [TextSpanValue(key, false)],
  //             list
  //                 .map((e) =>
  //                 TextSpanValue(e.isNotEmpty ? e : keyword, e.isEmpty))
  //                 .toList(),
  //             element['p']!,
  //           );
  //         },
  //       );
  //     }
  //   }

  detail(path) {
    Modular.to.pushNamed("/detail$path");
  }
}
