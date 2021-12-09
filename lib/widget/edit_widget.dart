import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wan_android_getx/utils/formatter/customized_length_formatter.dart';
import 'package:flutter_wan_android_getx/utils/formatter/customized_text_formatter.dart';

/// 类名: edit_widget.dart
/// 创建日期: 12/7/21 on 6:11 PM
/// 描述: 输入框样式，左边图标，右边输入框
/// 作者: 杨亮

class EditWidget extends StatefulWidget {
  ///输入框文字改变
  final ValueChanged<String>? onChanged;

  ///提示文字
  final String hintText;

  ///图标Widget
  final Widget iconWidget;

  ///图标Widget
  final bool passwordType;

  final TextInputType keyboardType;

  final TextEditingController? textEditingController;

  const EditWidget({
    Key? key,
    this.onChanged,
    this.hintText = "",
    this.passwordType = false,
    required this.iconWidget,
    this.keyboardType = TextInputType.number,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<EditWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  bool showPassWord = false;
  bool eyeExpand = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          child: TextField(
            controller: widget.textEditingController,
            keyboardType: widget.keyboardType,
            textAlign: TextAlign.left,
            autofocus: false,
            maxLines: 1,
            // 隐藏文本
            obscureText: eyeExpand && widget.passwordType,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
            cursorColor: Colors.blue,
            cursorRadius: const Radius.circular(10),
            cursorWidth: 1.0,
            onChanged: (text) {
              if (widget.onChanged != null) {
                widget.onChanged!(text);
              }
              setState(() {
                showPassWord = text.isNotEmpty;
              });
            },
            inputFormatters: [
              ///输入长度和格式限制
              CustomizedLengthTextInputFormatter(16),
              CustomizedTextInputFormatter(
                filterPattern: RegExp("[a-zA-Z]|[0-9]"),
              ),
            ],

            ///样式
            decoration: InputDecoration(
              fillColor: Colors.white12,
              filled: true,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              border: _getEditBorder(false),
              focusedBorder: _getEditBorder(true),
              disabledBorder: _getEditBorder(false),
              enabledBorder: _getEditBorder(false),
              contentPadding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                left: 60,
                right: 16,
              ),
            ),
          ),
          margin: const EdgeInsets.only(top: 8, bottom: 8, left: 25, right: 25),
        ),
        Positioned(
          width: 36,
          height: 36,
          left: 36,
          child: widget.iconWidget,
        ),
        Positioned(
          left: 76,
          child: Container(
            width: 1,
            height: 18,
            color: Colors.white54,
          ),
        ),
        Positioned(
          right: 40,
          child: Visibility(
            visible: showPassWord && widget.passwordType,
            child: IconButton(
              icon: Icon(
                eyeExpand ? Icons.visibility_off : Icons.remove_red_eye,
                size: 24,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  eyeExpand = !eyeExpand;
                });
              },
            ),
          ),
        )
      ],
    );
  }

  ///获取输入框的Border属性，可公用
  ///[isEdit]是否获取焦点
  OutlineInputBorder _getEditBorder(bool isEdit) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: isEdit ? Colors.blue : Colors.grey,
        width: 1,
      ),
    );
  }
}
