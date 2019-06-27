import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/common/common.dart';
import 'package:flutter_application/common/component_index.dart';
import 'package:flutter_application/res/index.dart';
import 'package:lpinyin/lpinyin.dart';

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static int getLoadStatus(bool hasError, List data) {
    if(hasError) return LoadStatus.fail;
    if(data == null) {
      return LoadStatus.loading;
    } else if(data.isEmpty) {
      return LoadStatus.empty;
    } else {
      return LoadStatus.success;
    }
  }

  static String getTimeLine(BuildContext context, int timeMillis) {
    return TimelineUtil.format(
      timeMillis,
      locale: Localizations.localeOf(context).languageCode,
      dayFormat: DayFormat.Common
    );
  }

  static String getPinyin(String str) {
    return PinyinHelper.getShortPinyin(str).substring(0,1).toLowerCase();
  }
}