import 'package:flutter/material.dart';
import 'blocs/bloc_provider.dart';
import './under_page.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Page'),
      ),
      body: StreamBuilder(
        stream: bloc.stream,
        initialData: bloc.value,
        builder: (context, snapshot) => Text(
          'You haved hit me: ${snapshot.data} times',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.forward),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => UnderPage()));
        },
      ),
    );
  }
}