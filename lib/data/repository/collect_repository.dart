import 'package:base_library/base_library.dart';
import 'package:flutter_application/common/common.dart';
import 'package:flutter_application/data/api/apis.dart';
import 'package:flutter_application/data/protocol/models.dart';

class CollectRepository {
  Future<List<ReposModel>> getCollectList(int page) async{
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil()
      .request<Map<String, dynamic>>(Method.get, WanAndroid.getPath(path: WanAndroid.lg_collect_list, page: page));
    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }
    List<ReposModel> list;
    if(baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        ReposModel model = ReposModel.formJson(value);
        model.collect = true;
        return model;
      }).toList();
    }
    return list;
  }

  Future<bool> collect(int id) async {
    BaseResp baseResp = await DioUtil().request(Method.post, WanAndroid.getPath(path: WanAndroid.lg_collect, page: id));
    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }
    return true;
  }

  Future<bool> unCollect(int id) async {
    BaseResp baseResp = await DioUtil().request(Method.post, WanAndroid.getPath(path: WanAndroid.lg_uncollect_originid, page: id));
    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }
    return true;
  }
}