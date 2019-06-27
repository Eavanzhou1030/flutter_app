import 'package:flutter/material.dart';
import 'package:flutter_application/common/component_index.dart';

class TabPage extends StatefulWidget {
  final String labelId;
  final String title;
  final String titleId;
  final TreeModel treeModel;

  const TabPage({Key key, this.labelId, this.title, this.titleId, this.treeModel}):super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  List<BlocProvider<ComListBloc>> _children = List();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TabBloc bloc = BlocProvider.of<TabBloc>(context);
    bloc.bindSystemData(widget.treeModel);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: bloc.tabTreeStream,
        builder: (BuildContext context, AsyncSnapshot<List<TreeModel>> snapshot) {
          if(snapshot.data == null) {
            Observable.just(1).delay(Duration(milliseconds: 500)).listen((_) {
              bloc.getData(labelId: widget.labelId);
            });
            return ProgressView(); // 定义单向订阅器，没有数据的时候重新发起请求，返回加载中的进度条
          }
          _children = snapshot.data.map((TreeModel model) {
            // return BlocProvider<ComListBloc>(
            //   // child: ComListPage(
            //   //   labelId: widget.labelId,
            //   //   cid: model.id
            //   // ),
            //   bloc: ComListBloc(),
            // );
          }).cast<BlocProvider<ComListBloc>>().toList(); // 有数据的时候返回列表
          return new DefaultTabController(
            length: snapshot.data == null ? 0 : snapshot.data.length,
            child: Column(
              children: <Widget>[
                Material(
                  color: Theme.of(context).primaryColor,
                  child: SizedBox(
                    height: 48.0,
                    width: double.infinity,
                    child: TabBar(
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: snapshot.data
                          ?.map(
                              (TreeModel model) => new Tab(text: model.name))
                          ?.toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: _children,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for(int i = 0, length = _children.length; i < length; i++) {
      _children[i].bloc.dispose();
    }
    super.dispose();
  }
}