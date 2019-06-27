import 'package:flutter/material.dart';
import 'package:flutter_application/common/component_index.dart';

class ComListPage extends StatelessWidget {
  final String labelId;
  final int cid;
  ComListPage({Key key, this.labelId, this.cid}):super(key: key);

  @override
  Widget build(BuildContext context) {
    LogUtil.e('ComListPage build ...');
    RefreshController _controller = RefreshController(); // 刷新控制器
    final ComListBloc bloc = BlocProvider.of<ComListBloc>(context);
    bloc.comListEventStream.listen((event) { // 流监听事件，发起刷新加载更多请求
      if(cid == event.cid) {
        _controller.sendBack(false, event.status);
      }
    });

    return StreamBuilder(
      stream: bloc.comListStream,
      builder: (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
        int loadStatus = Utils.getLoadStatus(snapshot.hasError, snapshot.data);
        if(loadStatus == LoadStatus.loading) {
          bloc.onRefresh(labelId: labelId, cid: cid);
        }
        return RefreshScaffold(
          labelId: cid.toString(),
          loadStatus: loadStatus,
          controller: _controller,
          onRefresh: ({bool isReload}) {
            return bloc.onRefresh(labelId: labelId, cid: cid);
          },
          onLoadMore: (up) {
            return bloc.onLoadMore(labelId: labelId, cid: cid);
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            ReposModel model = snapshot.data[index];
            // return labelId == Ids.titleReposTree 
          },
        );
      },
    );
  }
}