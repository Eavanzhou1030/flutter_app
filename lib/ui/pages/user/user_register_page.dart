import 'package:flutter/material.dart';
import 'package:flutter_application/common/component_index.dart';
import 'package:flutter_application/data/protocol/models.dart';
import 'package:flutter_application/data/repository/user_repository.dart';

class UserRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 子widget是否调整自己的大小，避免窗口的底部插入
      body:  Stack(
        children: <Widget>[
          Image.asset(
            Util.getImgPath('ic_login_bg'),
            package: BaseConstant.packageBase, // package作用？
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          UserRegisterBody(),
        ],
      )
    );
  }
}

class UserRegisterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllerName = new TextEditingController();
    TextEditingController _controllerPwd = new TextEditingController();
    TextEditingController _controllerRePwd = new TextEditingController();
    UserRepository userRepository = new UserRepository();

    void _userRegister() {
      String username = _controllerName.text;
      String password = _controllerPwd.text;
      String passwordRe = _controllerRePwd.text;
      if(username.isEmpty || username.length < 6) {
        Util.showSnackBar(context, username.isEmpty ? '请输入用户名~' : '用户名至少是6位');
        return ;
      }
      if(password.isEmpty || password.length < 6) {
        Util.showSnackBar(context, password.isEmpty ? '请输入密码~' : '密码至少是6位~');
        return ;
      }
      if(passwordRe.isEmpty || passwordRe.length < 6) {
        Util.showSnackBar(context, passwordRe.isEmpty ? '请确认输入密码~' : '密码至少是6位~');
        return ;
      }

      if(password != passwordRe) {
        Util.showSnackBar(context, '密码不一致');
        return ;
      }

      RegisterReq req = new RegisterReq(username, password, passwordRe);
      userRepository.register(req).then((UserModel model){
        LogUtil.e("LoginRespL${model.toString()}");
        Util.showSnackBar(context, '注册成功~');
        Observable.just(1).delay(new Duration(milliseconds: 500)).listen((_){
          // Event.sendAppEvent(context, Constant.)
        });
      }).catchError((error) {
        LogUtil.e('LoginResp error: ${error.toString()}');
        Util.showSnackBar(context, error.toString());
      });
    }

    return Column(
      children: <Widget>[
        Expanded(child: Container()),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 20, top: 15, right: 20),
            child: Column(
              children: <Widget>[
                LoginItem(
                  controller: _controllerName,
                  prefixIcon: Icons.person,
                  hintText: '请输入用户名',
                ),
                Gaps.vGap10,
                LoginItem(
                  controller: _controllerPwd,
                  prefixIcon: Icons.lock,
                  hintText: '请输入密码',
                ),
                Gaps.vGap10,
                LoginItem(
                  controller: _controllerRePwd,
                  prefixIcon: Icons.lock,
                  hintText: '请再次输入确认密码',
                ),
                RoundButton(
                  text: '注册',
                  margin: EdgeInsets.only(top: 20),
                  onPressed: () {
                    _userRegister();
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}