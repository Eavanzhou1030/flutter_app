import 'package:flutter/material.dart';
import './blocs/bloc_provider.dart';
import './under_page.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context); // 实例化bloc
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Page'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: bloc.stream, // streamBuilder监听bloc流的输出结果
          initialData: bloc.value,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Text(
              'you hit me: ${snapshot.data} times',
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UnderPage()));
        },
        child: Icon(Icons.forward),
      ),
    );
  }
}