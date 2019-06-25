import 'package:flutter/material.dart';
import 'blocs/bloc_provider.dart';


class UnderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context); // 实例化bloc
    print('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Under Page'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: bloc.stream, // streamBuild监听Bloc流的输出结果
          initialData: bloc.value,
          builder: (context, snapshot) => Text(
            'you hit me ${snapshot.data} times',
            style: Theme.of(context).textTheme.display1,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.increment(), // streamBuilder发出actions
        child: Icon(Icons.add),
      ),
    );
  }
}