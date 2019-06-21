import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/count_model.dart';

class UnderScreen extends StatefulWidget {
  final String title;
  UnderScreen({Key key, @required this.title}):super(key: key);

  @override
  _UnderScreenState createState() => _UnderScreenState();
}

class _UnderScreenState extends State<UnderScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<CountModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:', style: TextStyle(fontSize: 20.0),),
              Text(
                '${model.count}',
                style: TextStyle(fontSize: 36.0),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'Increment',
          onPressed: () => model.increment(),
        ),
      );
    });
  }
}