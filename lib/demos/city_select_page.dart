import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:lpinyin/lpinyin.dart';


class CityInfo extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;

  CityInfo({
    this.name,
    this.tagIndex,
    this.namePinyin
  });

  CityInfo.fromJson(Map<String, dynamic> json)
    : name = json['name'] == null ? '' : json['name'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'tagIndex': tagIndex,
    'namePinyin': namePinyin,
    'isShowSuspension': isShowSuspension
  };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => "CityBean {" + "\"name\": \"" + name + "\"" + "}";
}

class CitySelectPage extends StatefulWidget {
  final String title;
  CitySelectPage(this.title);

  @override
  _CitySelectPageState createState() => _CitySelectPageState();
}

class _CitySelectPageState extends State<CitySelectPage> {
  List<CityInfo> _cityList = List();
  List<CityInfo> _hotCityList = List();

  int _suspensionHeight = 40;
  int _itemHeight = 50;
  String _suspensionTag = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // 加载城市列表
  void loadData() async {

  }

  // 处理城市列表数据
  void _handleList(List<CityInfo> list) {
    if(list == null || list.isEmpty) return;
    for(int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
    }
  }

  // 标签发生变化
  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  // 构建悬停widget
  Widget _buildSusWidget(String susTag) {}

  // 构建悬停的item Widget
  Widget _buildListItem(CityInfo model) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}