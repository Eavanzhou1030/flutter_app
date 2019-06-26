import 'package:flutter/material.dart';
import 'package:flutter_application/common/component_index.dart';

class _Page {
  final String labelId;
  _Page(this.labelId);
}

final List<_Page> _allPages = <_Page> [
  _Page('主页'),
  _Page('项目'),
  _Page('动态'),
  _Page('体系'),
];

/**
 * 主页的整体布局
 * defaultTabController tabbar tabbarview实现滚动的tab已经实现tab与view之间的联动
 */
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LogUtil.e('MainPagess building....');
    return DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  Utils.getImgPath('ali_connors'),
                ),
              )
            ),
          ),
          centerTitle: true,
          title: TabLayout(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        // body: ,
      ),
    );
  }
}

/**
 * tab的主体内容
 */
class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.all(12.0),
      tabs: _allPages.map((_Page page) => Tab(text: page.labelId)).toList(),
    );
  }
}