import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  Widget builTextField(TextEditingController controller) {
    return TextField(
      // controller: controller,
      // maxLength: 30,
      // maxLines: 1,
      // autocorrect: true, // 是否自动更正
      // autofocus: true, // 自动聚焦
      // obscureText: true, // 是否是密码
      // textAlign: TextAlign.center,
      // style: TextStyle(fontSize: 30.0, color: Colors.blue),
      // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],//允许的输入格式
      // onChanged: (text) {
      //   print('文本框发生变化, $text');
      // },
      // onSubmitted: (text) {
      //   print('按回车的回调，$text');
      // },
      // enabled: true, // 是否禁用
      decoration: InputDecoration(
        // fillColor: Colors.blue.shade100,
        // filled: true,
        // helperText: 'Helper',
        // prefixIcon: Icon(Icons.local_airport),
        // suffixText: 'airport'
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ), // 输入之后还会显示
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.addListener(() {
      print('input ${controller.text}');
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('文本框组件'),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: builTextField(controller),
      ),
    );
  }
}