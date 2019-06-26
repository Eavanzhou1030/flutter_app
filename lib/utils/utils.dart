import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/common/common.dart';
import 'package:flutter_application/res/index.dart';
import 'package:lpinyin/lpinyin.dart';

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }
}