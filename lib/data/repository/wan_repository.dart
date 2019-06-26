import 'package:base_library/base_library.dart';
import 'package:flutter_application/common/common.dart';
import 'package:flutter_application/data/api/apis.dart';
import 'package:flutter_application/data/protocol/models.dart';

class WanRepository {
  Future<List<BannerModel>> getBanner() async {
    BaseResp<List> baseResp = await DioUtil().request<List>(
      Method.get, WanAndroid.getPath(path: WanAndroid.BANNER));
      List<BannerModel> bannerList;
      if(baseResp.code != Contanst.status_success) {
        return Future.error(baseResp.msg);
      }
      if(baseResp.data != null) {
        bannerList = baseResp.data.map((value) {
          return BannerModel.fromJson(value);
        }).toList();
      }
      return bannerList;
  }

  Future<List<ReposModel>> getArticleListProject(int page) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
      .request<Map<String, dynamic>>(Method.get, WanAndroid.getPath(path: WanAndroid.ARTICLE_LISTPROJECT, page: page));
    List<ReposModel> list;
    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }
    if(baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ReposModel.formJson(value);
      }).toList();
    }
    return list;
  }

  Future<List<ReposModel>> getArticleList({int page, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
      .request<Map<String, dynamic>>(Method.get, WanAndroid.getPath(path: WanAndroid.ARTICLE_LIST, page: page), data: data);
    List<ReposModel> list;
    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }
    if(baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((values) {
        return ReposModel.formJson(values);
      }).toList();
    }
    return list;
  }

  Future<List<TreeModel>> getTree() async {
    BaseResp<List> baseResp = await DioUtil()
      .request<List>(Method.get, WanAndroid.getPath(path: WanAndroid.TREE));
    List<TreeModel> treeList;
    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }
    if(baseResp.data != null) {
      treeList = baseResp.data.map((value) {
        return TreeModel.fromJson(value);
      }).toList();
    }
    return treeList;
  }

   Future<List<ReposModel>> geProjectList({int page: 1, data}) async{
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
      .request<Map<String, dynamic>>(Method.get, WanAndroid.getPath(path: WanAndroid.PROJECT_LIST, page: page), data: data);
    List<ReposModel> list;
    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }
    if(baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ReposModel.formJson(value);
      }).toList();
    }
    return list;
  }

  Future<List<ReposModel>> getWxArticleList({int id, int page: 1, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
      .request<Map<String, dynamic>>(Method.get, WanAndroid.getPath(path: WanAndroid.WXARTICLE_LIST, page: page), data: data);
    List<ReposModel> list;
    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }
    if(baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ReposModel.formJson(value);
      }).toList();
    }
    return list;
  }

  Future<List<TreeModel>> getWxArticleChapters() async {
    BaseResp<List> baseResp = await DioUtil()
      .request<List>(Method.get, WanAndroid.getPath(path: WanAndroid.WXARTICLE_CHAPTERS));
    List<TreeModel> treeList;
    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }
    if(baseResp.data != null) {
      treeList = baseResp.data.map((value) {
        return TreeModel.fromJson(value);
      }).toList();
    }
    return treeList;
  }

  Future<List<TreeModel>> getProjectTree() async {
    BaseResp<List> baseResp = await DioUtil()
      .request<List>(Method.get, WanAndroid.getPath(path: WanAndroid.PROJECT_TREE));
    List<TreeModel> treeList;
    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }
    if(baseResp.data != null) {
      treeList = baseResp.data.map((value) {
        return TreeModel.fromJson(value);
      }).toList();
    }
    return treeList;
  }
}