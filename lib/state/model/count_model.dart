import 'package:scoped_model/scoped_model.dart';

// Model是一个包含与状态相关信息的单位，将状态数据和操作数据的方法抽象封装到model中

class CountModel extends Model {
  int _count = 0;
  get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // 状态变化的时候通知所有用到该model的子项更新状态
  }

  CountModel of(context) => ScopedModel.of<CountModel>(context);
}