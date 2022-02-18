import 'package:flutter/material.dart';

class TestStateFullWidget extends StatefulWidget {
  const TestStateFullWidget({Key? key}) : super(key: key);

  @override
  _TestStateFullWidgetState createState() {
    return _TestStateFullWidgetState();
  }
}

class _TestStateFullWidgetState extends State<TestStateFullWidget> {

  /// initState()  Widget初始化当前State
  @override
  void initState() {
    super.initState();
  }

  /// didChangeDependencies()  在initState()之后调用，当State对象依赖关系发生变化的时候也会调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// deactivate()   当State被暂时从视图树中移除时会调用这个方法，页面切换时也会调用该方法，和Android里的onPause差不多
  @override
  void deactivate() {
    super.deactivate();
  }

  /// dispose()  Widget销毁时调用
  @override
  void dispose() {
    super.dispose();
  }

  /// didUpdateWidget(covariant TestStateFullWidget oldWidget)  Widget状态发生变化的时候调用
  @override
  void didUpdateWidget(covariant TestStateFullWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
