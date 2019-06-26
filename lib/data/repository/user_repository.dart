import 'package:base_library/base_library.dart';
import 'package:flutter_application/common/common.dart';
import 'package:flutter_application/data/api/apis.dart';
import 'package:flutter_application/data/protocol/models.dart';

// 注册、登录http请求
class UserRepository {
  Future<UserModel> login(LoginReq req) async {
    BaseRespR<Map<String, dynamic>> baseResp = await DioUtil()
      .requestR<Map<String, dynamic>>(Method.post, WanAndroid.user_login, data: req.toJson());
    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }
    baseResp.response.headers.forEach((String name, List<String> values) {
      if(name == 'set-cookie') {
        String cookie = values.toString();
        LogUtil.e('set-cookie:' + cookie);
        SpUtil.putString(BaseConstant.keyAppToken, cookie);
        DioUtil().setCookie(cookie);
      }
    });
    UserModel model = UserModel.fromJson(baseResp.data);
    SpUtil.putObject(BaseConstant.keyUserModel, model);
    return model;
  }

  Future<UserModel> register(RegisterReq req) async {
    BaseRespR<Map<String, dynamic>> baseResp = await DioUtil()
      .requestR<Map<String, dynamic>>(Method.post, WanAndroid.user_register, data: req.toJson());

    if(baseResp.code != Contanst.status_success) {
      return Future.error(baseResp.msg);
    }

    baseResp.response.headers.forEach((String name, List values) {
      if(name == 'set-cookie') {
        String cookie = values.toString();
        LogUtil.e('set-cookie:' + cookie);
        SpUtil.putString(BaseConstant.keyAppToken, cookie);
        DioUtil().setCookie(cookie);
      }
    });
    UserModel model = UserModel.fromJson(baseResp.data);
    SpUtil.putObject(BaseConstant.keyUserModel, model);
    return model;
  }
}