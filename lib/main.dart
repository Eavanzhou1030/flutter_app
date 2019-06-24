

import 'package:flutter/material.dart';
// import 'state/scoped/blocs/bloc_provider.dart';
// import 'state/scoped/top_page.dart';

// import 'state/single_global_instance/top_page.dart';

import 'state/rxdart/blocs/bloc_provider.dart';
import 'state/rxdart/top_page.dart';

void main() => runApp(MyApp());

// scope入口
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       child: MaterialApp(
//         title: 'Scope Bloc',
//         home: TopPage(),
//       ),
//     );
//   }
// }

// global_instance入口
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'global instance',
//       home: TopPage(),
//     );
//   }
// }

// rsdart入口
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'Top page',
        home: TopPage()
      ),
    );
  }
}