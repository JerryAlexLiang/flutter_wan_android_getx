import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnKnownRoutePage extends StatelessWidget {
  const UnKnownRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.back(),
          child: Image.asset(
            'images/unknownPage.jpeg',
            height: Get.height,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
