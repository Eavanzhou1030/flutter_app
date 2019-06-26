import 'package:flutter/material.dart';
import 'package:flutter_application/common/component_index.dart';
import 'package:flutter_application/data/repository/user_repository.dart';
// import 'package:flutter_application/ui/pages/user/user_register_page.dart';

class UserLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Image.asset(
            Util.getImgPath('ic_login_bg'),
            package: BaseConstant.packageBase,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          LoginBody()
        ],
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controllName = TextEditingController();
    TextEditingController _controllPwd = TextEditingController();
    UserRepository userRepository = UserRepository();
    UserModel userModel = SpHelper.getObject<UserModel>(BaseConstant.keyUserModel);
    _controllName.text = userModel?.username ?? "";

    void _userLogin() {
      String username = _controllName.text;
      String password = _controllPwd.text;

      if(username.isEmpty || username.length < 6) {
        Util.showSnackBar(context, username.isEmpty ? '请输入用户名~' : '用户名至少是6位~');
        return;
      }

      if(password.isEmpty || password.length < 6) {
        Util.showSnackBar(context, password.isEmpty ? '请输入密码~' : '密码至少是6位~');
        return ;
      }

      LoginReq req = new LoginReq(username, password);
      userRepository.login(req).then((UserModel model) {
        LogUtil.e('LoginResp: ${model.toString()}');
        Util.showSnackBar(context, '登录成功');
        Observable.just(1).delay(Duration(milliseconds: 500)).listen((_) {

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
                  controller: _controllName,
                  prefixIcon: Icons.person,
                  hintText: '请输入用户名',
                ),
                Gaps.vGap15,
                LoginItem(
                  controller: _controllPwd,
                  prefixIcon: Icons.lock,
                  hasSuffixIcon: true,
                  hintText: '请输入密码',
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimens.gap_dp15),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    child: Text(
                      '忘记密码',
                      style: TextStyle(color: Colours.gray_99,fontSize: Dimens.font_sp14),
                    ),
                    onTap: () {
                      Util.showSnackBar(context, '请联系管理员~');
                    },
                  ),
                ),
                RoundButton(
                  text: '登录',
                  margin: EdgeInsets.only(top: 20),
                  onPressed: () {
                    _userLogin();
                  },
                ),
                Gaps.vGap15,
                InkWell(
                  onTap: () {

                  },
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          style: TextStyle(fontSize: 14, color: Colours.text_gray),
                          text: '新用户?'
                        ),
                        TextSpan(
                          style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                          text: '立即注册'
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}