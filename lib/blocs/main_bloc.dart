import 'dart:collection';

import 'package:azlistview/azlistview.dart';
import 'package:flutter_application/common/component_index.dart';
import 'package:flutter_application/data/repository/collect_repository.dart';
import 'package:flutter_application/data/repository/wan_repository.dart';
import 'package:flutter_application/models/models.dart';

class MainBloc implements BlocBase {

  // home
  BehaviorSubject<List<BannerModel>> _banner = BehaviorSubject<List<BannerModel>>();
  Sink<List<BannerModel>> get _bannerSink => _banner.sink;
  Stream<List<BannerModel>> get bannerStream => _banner.stream;

  BehaviorSubject<List<ReposModel>> _recRepos = BehaviorSubject<List<ReposModel>>();
  Sink<List<ReposModel>> get _recReposSink => _recRepos.sink;
  Stream<List<ReposModel>> get recReposStream => _recRepos.stream;

  BehaviorSubject<List<ReposModel>> _recWxArticle = BehaviorSubject<List<ReposModel>>();
  Sink<List<ReposModel>> get _recWxArticleSink => _recWxArticle.sink;
  Stream<List<ReposModel>> get recWxArticleStream => _recWxArticle.stream;

  // Repos
  BehaviorSubject<List<ReposModel>> _repos = BehaviorSubject<List<ReposModel>>();
  Sink<List<ReposModel>> get _reposSink => _repos.sink;
  Stream<List<ReposModel>> get reposStream => _repos.stream;
  List<ReposModel> _reposList;
  int _reposPage = 0;

  // events
  BehaviorSubject<List<ReposModel>> _events = BehaviorSubject<List<ReposModel>>();
  Sink<List<ReposModel>> get _eventsSink => _events.sink;
  Stream<List<ReposModel>> get _eventStream => _events.stream;
  List<ReposModel> _eventsList;
  int _eventPage = 0;

  // system
  BehaviorSubject<List<TreeModel>> _tree = BehaviorSubject<List<TreeModel>>();
  Sink<List<TreeModel>> get _treeSink => _tree.sink;
  Stream<List<TreeModel>> get treeStream => _tree.stream;
  List<TreeModel> _treeList;

  // version
  BehaviorSubject<VersionModel> _version = BehaviorSubject<VersionModel>();
  Sink<VersionModel> get _versionSink => _version.sink;
  Stream<VersionModel> get versionStream => _version.stream.asBroadcastStream();
  VersionModel _versionModel;

  // home event
  BehaviorSubject<StatusEvent> _homeEvent = BehaviorSubject<StatusEvent>();
  Sink<StatusEvent> get homeEventSink => _homeEvent.sink;
  Stream<StatusEvent> get homeEventStream => _homeEvent.stream.asBroadcastStream();

  // personal
  BehaviorSubject<ComModel> _recItem = BehaviorSubject<ComModel>();
  Sink<ComModel> get _recItemSink => _recItem.sink;
  Stream<ComModel> get recItemStream => _recItem.stream.asBroadcastStream();
  ComModel hotRecModel;

  BehaviorSubject<List<ComModel>> _recList = BehaviorSubject<List<ComModel>>();
  Sink<List<ComModel>> get _recListSink => _recList.sink;
  Stream<List<ComModel>> get recListStream => _recList.stream.asBroadcastStream();
  List<ComModel> hotRecList;

  WanRepository wanRepository = WanRepository();
  CollectRepository collectRepository = CollectRepository();
  HttpUtils httpUtils = HttpUtils();

  MainBloc() {
    LogUtil.e('MainBloc.....');
  }

  @override
  Future getData({String labelId, int page}) {

  }

  @override
  Future onLoadMore({String labelId}) {

  }

  @override
  Future onRefresh({String labelId, bool isReload}) {

  }

  Future getHomeData(String labelId) {

  }

  Future getBanner(String labelId) {
    return wanRepository.getBanner().then((list) {
      _bannerSink.add(UnmodifiableListView<BannerModel>(list));
    });
  }

  Future getRecRepos(String labelId) async {
    ComReq comReq = ComReq(402);
    wanRepository.geProjectList(data: comReq.toJson()).then((list) {
      if(list.length > 6) {
        list = list.sublist(0, 6);
      }
      _recReposSink.add(UnmodifiableListView<ReposModel>(list));
    });
  }

  Future getRecWxArticle(String labelId) async {
    int _id = 408;
    wanRepository.getWxArticleList(id: _id).then((list) {
      if(list.length > 6) {
        list = list.sublist(0,6);
      }
      _recWxArticleSink.add(UnmodifiableListView<ReposModel>(list));
    });
  }

  Future getArticleListProject(String labelId, int page) {
    return wanRepository.getArticleListProject(page).then((list) {
      if(_reposList == null) {
        _reposList = List();
      }
      if(page == 0) {
        _reposList.clear();
      }
      _reposList.addAll(list);
      _reposSink.add(UnmodifiableListView<ReposModel>(_reposList));
     homeEventSink.add(StatusEvent(
       labelId,
       ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle
     ));
    }).catchError((_) {
      if(ObjectUtil.isEmpty(_reposList)) {
        _repos.sink.addError('error');
      }
      _reposPage--;
      homeEventSink.add(StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  Future getArticleList(String labelId, int page) {
    return wanRepository.getArticleList(page: page).then((list) {
      if(_eventsList == null) {
        _eventsList = List();
      }
      if(page == 0) {
        _eventsList.clear();
      }
      _eventsList.addAll(list);
      _eventsSink.add(UnmodifiableListView<ReposModel>(_eventsList));
      homeEventSink.add(StatusEvent(
        labelId,
        ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle
      ));
    }).catchError((_) {
      if(ObjectUtil.isEmpty(_eventsList)) {
        _events.sink.addError('error');
      }
      _eventPage--;
      homeEventSink.add(StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  Future getTree(String labelId) {
    return wanRepository.getTree().then((list) {
      if(_treeList == null) {
        _treeList = List();
      }
      for(int i = 0, length = list.length; i < length; i++) {
        String tag = Utils.getPinyin(list[i].name);
        if(RegExp("[A-Z]").hasMatch(tag)) {
          list[i].tagIndex = tag;
        } else {
          list[i].tagIndex = '#';
        }
      }
      SuspensionUtil.sortListBySuspensionTag(list);

      _treeList.clear();
      _treeList.addAll(list);
      _treeSink.add(UnmodifiableListView<TreeModel>(_treeList));
      homeEventSink.add(StatusEvent(
        labelId,
        ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle
      ));
    }).catchError((_) {
      if(ObjectUtil.isEmpty(_treeList)) {
        _tree.sink.addError('error');
      }
      homeEventSink.add(StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  Future getVersion() async {
    httpUtils.getVersion().then((model) {
      _versionModel = model;
      _versionSink.add(_versionModel);
    });
  }

  Future getHotRecItem() async {
    httpUtils.getRecItem().then((model) {
      hotRecModel = model;
      _recItemSink.add(hotRecModel);
    });
  }

  Future getHotRecList(String labelId) async {
    httpUtils.getRecList().then((list) {
      hotRecList = list;
      _recListSink.add(UnmodifiableListView<ComModel>(list));
      homeEventSink.add(StatusEvent(
        labelId,
        ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle
      ));
    }).catchError((_) {
      // homeEventSink.addError('error')
    });
  }
}