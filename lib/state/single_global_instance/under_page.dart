import 'package:flutter/material.dart';
import 'blocs/count_bloc.dart';

class UnderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Under Page'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: bloc.stream, // streamBuilder监听Bloc流的输出结果
          initialData: bloc.value,
          builder: (context, snapshot) => Text('you hit me: ${snapshot.data} timers', style: Theme.of(context).textTheme.display1,)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.increment(), // streamBuilder发出action，添加到Bloc的sink入口，进行处理
        child: Icon(Icons.add),
      ),
    );
  }
}