import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/blocs/bloc_index.dart';
import 'package:flutter_application/common/common.dart';
import 'package:flutter_application/ui/pages/user/user_login_page.dart';
import 'package:flutter_application/utils/util_index.dart';

// loading
class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}

// like button
class LikeBtn extends StatelessWidget {
  final String labelId;
  final int id;
  final bool isLike;

  const LikeBtn({
    Key key,
    this.labelId,
    this.id,
    this.isLike
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

// status views
class StatusViews extends StatelessWidget {
  final int status;
  final GestureTapCallback onTap;

  StatusViews(this.status, {Key key, this.onTap}):super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(status) {
      case LoadStatus.fail:
        return Container(
          width: double.infinity,
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                onTap();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Utils.getImgPath('ic_network_error'),
                    package: BaseConstant.packageBase,
                    width: 100,
                    height: 100
                  ),
                  Gaps.vGap10,
                  Text('网络出现问题了~请检查您的网络设置', style: TextStyles.listContent),
                  Gaps.vGap5,
                  Text('点击屏幕，重新加载', style: TextStyles.listContent)
                ],
              ),
            ),
          ),
        );
      break;
      case LoadStatus.loading:
        return Container(
          alignment: Alignment.center,
          color: Colours.gray_f0,
          child: ProgressView(),
        );
        break;
      case LoadStatus.empty:
        return Container(
          color: Colors.white,
          width: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  Utils.getImgPath('ic_data_empty'),
                  package: BaseConstant.packageBase,
                  height: 60,
                  width: 60
                ),
                Gaps.vGap10,
                Text('空空如也~', style: TextStyles.listContent2,)
              ],
            ),
          ),
        );
        break;
      default:
        return Container();
        break;
    }
  }
}