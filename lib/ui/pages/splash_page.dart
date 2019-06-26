import 'package:flutter/material.dart';
import 'package:flutter_application/common/component_index.dart';
import 'package:flutter_application/models/models.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil; // 时间工具类

  List<String> _guideList = [
    Utils.getImgPath('guide1'),
    Utils.getImgPath('guide2'),
    Utils.getImgPath('guide3'),
    Utils.getImgPath('guide4'),
  ];

  List<Widget> _bannerList = List();

  int _status = 0;
  int _count = 3;

  SplashModel _splashModel; // 数据存储类

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  // 异步的初始化数据
  void _initAsync() async {
    await SpUtil.getInstance();
    _loadSplashData();
    // 定义订阅器
    Observable.just(1).delay(Duration(milliseconds: 500)).listen((_) {
      if(SpUtil.getBool(Contanst.key_guide, defValue: true) && ObjectUtil.isNotEmpty(_guideList)) {
        SpUtil.putBool(Contanst.key_guide, false);
        _initBanner();
      } else {
        _initSplash();
      }
    });
  }

  // 加载引导数据
  void _loadSplashData() {
    _splashModel = SpHelper.getObject(Contanst.key_splash_model);
    if(_splashModel != null) {
      setState(() {});
    }
    HttpUtils httpUtil = new HttpUtils();
    httpUtil.getSplash().then((model) {
      if(!ObjectUtil.isEmpty(model.imgUrl)) {
        if(_splashModel == null || (_splashModel.imgUrl != model.imgUrl)) {
          SpHelper.putObject(Contanst.key_splash_model, model);
          setState(() {
            _splashModel = model;
          });
        }
      } else {
        SpHelper.putObject(Contanst.key_splash_model, null);
      }
    });
  }

  // 初始化banner数据
  void _initBanner() {
    _initBannerData();
    setState(() {
      _status = 2;
    });
  }
  void _initBannerData() {
    for(int i = 0, length = _guideList.length; i < length; i++) {
      if(i == length - 1) {
        _bannerList.add(Stack(
          children: <Widget>[
            Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 160.0),
                child: InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.indigoAccent,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        '立即体验',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
      } else {
        _bannerList.add(Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }

  // 初始化
  void _initSplash() {
    if(_splashModel == null) {
      _goMain();
    }else {
      _doCountDown();
    }
  }
  void _doCountDown() {
    setState(() {
      _status = 1;
    });
    _timerUtil = new TimerUtil(mTotalTime: 3 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if(_tick == 0) {
        _goMain();
      }
    });
    _timerUtil.startCountDown();
  }
  // 跳转到首页
  void _goMain() {
    RouteUtil.goMain(context);
  }

  // 定义SplashBg widget
  Widget _buildSplashBg() {
    return Image.asset(
      Utils.getImgPath('splash_bg'),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );
  }

  // 定义广告widget
  Widget _buildAdWidget() {
    if(_splashModel == null) {
      return Container(
        height: 0.0,
      );
    }
    return Offstage(
      offstage: !(_status == 1), // true 不显示  false 显示
      child: InkWell(
        onTap: () {
          if(ObjectUtil.isEmpty(_splashModel.url)) return;
          _goMain();
          // NavigatorUtil.pushWeb(context, title: )
        },
        child: Container(
          alignment: Alignment.center,
          child: CachedNetworkImage(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
            imageUrl: _splashModel.imgUrl,
            placeholder: (context, url) => _buildSplashBg(),
            errorWidget: (context, url, error) => _buildSplashBg(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: !(_status == 0),
            child: _buildSplashBg(),
          ),
          Offstage(
            offstage: !(_status == 2),
            child: ObjectUtil.isEmpty(_bannerList)
              ? Container()
              : Swiper(
                autoStart: false,
                circular: false,
                indicator: CircleSwiperIndicator(
                  radius: 4.0,
                  padding: EdgeInsets.only(bottom: 30.0),
                  itemColor: Colors.black26
                ),
                children: _bannerList,
              ),
          ),
          _buildAdWidget(),
          Offstage(
            offstage: !(_status == 1),
            child: Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                  _goMain();
                },
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    '跳过$_count',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0x66000000),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: Border.all(
                      width: 0.33,
                      color: Colours.divider
                    )
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if(_timerUtil != null) _timerUtil.cancel();
  }
}