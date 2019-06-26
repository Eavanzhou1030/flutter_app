import 'package:flutter/material.dart';
import 'package:flutter_application/common/component_index.dart';

class TabPage extends StatefulWidget {
  final String labelId;
  final String title;
  final String titleId;
  final TreeModel treeModel;

  const TabPage({Key key, this.labelId, this.title, this.titleId, this.treeModel}):super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}