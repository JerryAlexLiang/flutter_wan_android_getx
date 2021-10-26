import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wan_android_getx/config/config.dart';
import 'package:flutter_wan_android_getx/http/base_response.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/routes/app_pages.dart';
import 'package:flutter_wan_android_getx/routes/app_routes.dart';
import 'package:flutter_wan_android_getx/test/test_mxnzp_model.dart';
import 'package:flutter_wan_android_getx/test/test_wan_project_tree_model.dart';
import 'package:flutter_wan_android_getx/theme/app_theme.dart';
import 'package:flutter_wan_android_getx/utils/keyboard_util.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  await Config.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );

    return RefreshConfiguration(
      hideFooterWhenNotFull: false,
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: () {
          return OKToast(
            child: GetMaterialApp(
              locale: Get.deviceLocale,
              localizationsDelegates: const [
                //这行是关键
                RefreshLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return Scaffold(
                  body: GestureDetector(
                    child: child,
                    onTap: KeyboardUtils.hideKeyboard(context),
                  ),
                );
              },
              enableLog: true,
              smartManagement: SmartManagement.keepFactory,
              /// 主题颜色
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.system,
              defaultTransition: Transition.fade,
              initialRoute: AppRoutes.main,
              getPages: AppPages.routes,
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> initData() async {
    BaseResponse response = await DioUtil().request(
        '/api/convert/translate?content=我是一个帅哥&from=zh&to=en',
        newBaseUrl: RequestApi.mxnzpBaseUrl,
        method: DioMethod.get);

    LoggerUtil.d('==============>00  $response', tag: "mxnzp");

    //拿到res.data就可以进行Json解析了，这里一般用来构造实体类
    var success = response.success;
    if (success != null) {
      if (success) {
        TestMxnzpModel model = TestMxnzpModel().fromJson(response.data);
        LoggerUtil.d('==============>01  $model', tag: "mxnzp");
        LoggerUtil.d('==============>02  ${model.origin}', tag: "mxnzp");
        LoggerUtil.d('==============>03  ${model.result}', tag: "mxnzp");
      } else {
        LoggerUtil.d('==============>05  ${response.message}', tag: "mxnzp");
      }
    }

    //   await DioUtil()
    //       .request('/api/convert/translate?content=我是一个帅哥&from=zh&to=en',
    //           newBaseUrl: RequestApi.mxnzpBaseUrl, method: DioMethod.get)
    //       .then((value) {
    //     LoggerUtil.d('==============>20  $value', tag: "mxnzp");
    //
    //     BaseResponse response = value;
    //
    //     //拿到res.data就可以进行Json解析了，这里一般用来构造实体类
    //     var success = response.success;
    //     if (success != null) {
    //       if (success) {
    //         TestMxnzpModel model = TestMxnzpModel().fromJson(response.data);
    //         LoggerUtil.d('==============>21  $model', tag: "mxnzp");
    //         LoggerUtil.d('==============>22  ${model.origin}', tag: "mxnzp");
    //         LoggerUtil.d('==============>23  ${model.result}', tag: "mxnzp");
    //       } else {
    //         LoggerUtil.d('==============>25  ${response.message}', tag: "mxnzp");
    //       }
    //     }
    //   });
  }

  Future<void> initData2() async {
    BaseResponse response =
        await DioUtil().request('/project/tree/json', method: DioMethod.post);

    LoggerUtil.d('==============>wan 0  $response', tag: "wan");

    //拿到res.data就可以进行Json解析了，这里一般用来构造实体类
    var success = response.success;
    if (success != null) {
      if (success) {
        LoggerUtil.d('==============>01  ${response.data}', tag: "wan");

        ///列表转换的时候一定要加一下强转List<dynamic>，否则会报错
        List<TestWanProjectTreeModel> model = (response.data as List<dynamic>)
            .map((e) => TestWanProjectTreeModel().fromJson(e))
            .toList();

        LoggerUtil.d('==============>02  ${json.encode(model)}', tag: "wan");
        LoggerUtil.d('==============>022  ${model.map((e) => e.name)}',
            tag: "wan");
        LoggerUtil.d('==============>023  ${model.map((e) => e.name).toList()}',
            tag: "wan");

        LoggerUtil.d('==============>03  ${response.message}', tag: "wan");
      } else {
        LoggerUtil.d('==============>05  ${response.message}', tag: "wan");
      }
    }
  }
}
