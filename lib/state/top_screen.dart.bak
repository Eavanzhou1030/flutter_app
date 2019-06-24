import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './model/count_model.dart';
import './under_screen.dart';

class TopScreen extends StatefulWidget {
@override
  _TopScreenState createState() =>_TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  // 静态获取model实例的方法
  Model getModel(BuildContext context) {
    // 直接使用of
    final countModel = ScopedModel.of<CountModel>(context);
    // 使用CountModel重写of
    final countModel2 = CountModel().of(context);

    countModel.increment();
    countModel2.increment();
    return countModel;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CountModel>(builder: (context, build, model) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Top Screen'),
        ),
        body: Center(
          child: Text(
            model.count.toString(),
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.forward),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return UnderScreen(title: 'Under Screen');
            }));
          },
        ),
      );
    });
  }
}