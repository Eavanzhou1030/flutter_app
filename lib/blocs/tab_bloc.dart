import 'dart:collection';
import 'package:flutter_application/common/component_index.dart';
import 'package:flutter_application/data/repository/wan_repository.dart';

class TabBloc implements BlocBase {
  BehaviorSubject<List<TreeModel>> _tabTree = BehaviorSubject<List<TreeModel>>(); // Bloc StreamController

  Sink<List<TreeModel>> get _tabTreeSink =>_tabTree.sink; // StreamController sink入口

  Stream<List<TreeModel>> get tabTreeStream => _tabTree.stream; // StreamController stream

  List<TreeModel> treeList;

  WanRepository wanRepository = new WanRepository();

  @override
  Future getData({String labelId, int page}) {
    switch(labelId) {
      case Ids.titleReposTree:
        return getProjectTree(labelId);
        break;
      case Ids.titleWxArticleTree:
        return getWxArticleTree(labelId);
        break;
      case Ids.titleSystemTree:
        return getSystemTree(labelId);
        break;
      default:
        return Future.delayed(new Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labelId}) {
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    return getData(labelId: labelId);
  }

  void bindSystemData(TreeModel model) {
    if(model == null) {
      return ;
    }
    treeList = model.children;
  }

  Future getProjectTree(String labelId) {
    return wanRepository.getProjectTree().then((list) {
      _tabTreeSink.add(UnmodifiableListView<TreeModel>(list)); // 创建一个不可修改的列表, StreamController的入口处添加事件
    });
  }

  Future getWxArticleTree(String labelId) {
    return wanRepository.getWxArticleChapters().then((list) {
      _tabTreeSink.add(UnmodifiableListView<TreeModel>(list));
    });
  }

  Future getSystemTree(String labelId) {
    return Future.delayed(Duration(milliseconds: 500)).then((_) {
      _tabTreeSink.add(UnmodifiableListView<TreeModel>(treeList));
    });
  }

  Future getTree(String label) {
    return wanRepository.getProjectTree().then((list) {
      if(treeList == null) {
        treeList = new List();
      }
      treeList.clear();
      treeList.addAll(list);
      _tabTreeSink.add(UnmodifiableListView<TreeModel>(treeList));
    });
  }

  @override
  void dispose() {
    _tabTree.close();
  }
}