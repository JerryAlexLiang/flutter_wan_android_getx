import 'package:flutter/material.dart';

/// 虽然我们可以通过 AutomaticKeepAliveClientMixin 快速的实现页面缓存功能，但是通过混入的方式实现不是很优雅，
/// 因为必须更改 Page 的代码，有侵入性，这就导致不是很灵活，比如一个组件能同时在列表中和列表外使用，为了在列表中缓存它，则我们必须实现两份。
/// 为了解决这个问题，封装了一个 KeepAliveWrapper 组件，如果哪个列表项需要缓存，只需要使用 KeepAliveWrapper 包裹一下它即可.

class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({Key? key, this.keepAlive = true, required this.child})
      : super(key: key);

  final bool keepAlive;
  final Widget child;

  @override
  _KeepAliveWrapperState createState() {
    return _KeepAliveWrapperState();
  }
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive状态需要更新，实现在AutomaticKeepAliveClientMixin中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  /// 重写此方法，返回true时，保存页面数据状态，防止切换页面后数据重新加载，另外需要配合PageView使用
  @override
  bool get wantKeepAlive => widget.keepAlive;
}
