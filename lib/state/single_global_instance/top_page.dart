import 'package:flutter/material.dart';
import 'blocs/count_bloc.dart';
import './under_page.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Page'),
      ),
      body: StreamBuilder(
        stream: bloc.stream,
        initialData: bloc.value,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Text('You hit me ${snapshot.data} times');
        },
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