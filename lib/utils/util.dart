import 'dart:convert';

import 'package:flutter/material.dart';

class Utils {
  /// 日期信息转换，距离当前时间
  /// [dateTime] 时间
  static getTimeInfo(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final int diff =
        now.millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch;
    if (diff < 0) return '';
    if (diff / 1000 < 60) return '刚刚';
    if (diff / 60000 < 60) return '${(diff / 60000).floor()}分钟前';
    if (diff / 3600000 < 24) return '${(diff / 3600000).floor()}小时前';
    if (diff / 86400000 < 31) return '${(diff / 86400000).floor()}天前';
    if (diff / 2592000000 < 12) return '${(diff / 2592000000).floor()}月前';
    return '${(diff / 31536000000).floor()}年前';
  }

  static getTabInfo(String tab, bool good, bool top, bool isClass) {
    String str;
    Color color;
    if (top) {
      str = '置顶';
      color = Color(0xffe74c3c);
    } else if (good) {
      str = '精华';
      color = Color(0xffe67e22);
    } else {
      switch (tab) {
        case 'share':
          str = '分享';
          color = Color(0xff1abc9c);
          break;
        case 'ask':
          str = '问答';
          color = Color(0xff3498db);
          break;
        case 'job':
          str = '招聘';
          color = Color(0xff9b59b6);
          break;
        case 'dev':
          str = '测试';
          color = Color(0xff80bd01);
          break;
        default:
          str = '暂无';
          color = Colors.white;
          break;
      }
    }
    return isClass ? color : str;
  }

  static String paramsEncode(dynamic params) {
    String jsonString = json.encode(params);
    return jsonEncode(Utf8Encoder().convert(jsonString));
  }

  static String paramsDecode(String paramsString) {
    var list = [];

    ///字符串解码
    jsonDecode(paramsString).forEach(list.add);
    return Utf8Decoder().convert(list);
  }
}
