import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './states/count_state.dart';

class UnderScreen extends StatefulWidget {
  @override
  _UnderScreenState createState() => _UnderScreenState();
}

class _UnderScreenState extends State<UnderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Under Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You haved push many times'),
            StoreConnector<CountState, int>( // storeConnector通过StoreProvider找到顶层的store，而且能够在state发生变化的时候rebuild widget
              converter: (store) => store.state.count,
              builder: (context, count) {
                Text(
                  count.toString(),
                  style: Theme.of(context).textTheme.display1,
                );
              }
            )
          ],
        ),
      ),
      floatingActionButton: StoreConnector<CountState, VoidCallback> (
        converter: (store) {
          return () => store.dispatch(Action.increment);
        },
        builder: (context, callback) {
          return FloatingActionButton(
            onPressed: callback,
            child: Icon(Icons.add),
          );
        }
      )
    );
  }
}