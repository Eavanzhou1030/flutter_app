import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'state/model/count_model.dart';
import 'state/top_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // 创建顶层状态
  CountModel countModel = CountModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CountModel>(
      model: countModel,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        // home: ,
      ),
    );
  }
}