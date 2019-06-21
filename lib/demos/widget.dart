import 'package:flutter/material.dart';

class WidgetPage extends StatefulWidget {
  final String title;
  WidgetPage(this.title);

  @override
  State<StatefulWidget> createState() => WidgetPageState();
}

class WidgetPageState extends State<WidgetPage> {
  double testHeight = 50.0;
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget page'),
      ),
    );
  }
}