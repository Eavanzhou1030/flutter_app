import 'package:scoped_model/scoped_model.dart';


// ScopedModel在不同的页面之间使用inhreitedWidget，实现状态共享
class CountModel extends Model {
  int _count = 0;
  get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // model实现了listenable接口，调用notifyListeners函数的通知观察者修改状态
  }

  // 重写of方法
  CountModel of(context) => ScopedModel.of<CountModel>(context);
}
