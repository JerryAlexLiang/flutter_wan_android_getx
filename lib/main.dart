import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/config/config.dart';
import 'package:flutter_wan_android_getx/http/base_response.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/test/test_mxnzp_model.dart';
import 'package:flutter_wan_android_getx/test/test_wan_project_tree_model.dart';
import 'package:flutter_wan_android_getx/utils/logger_util.dart';

void main() async {
  await Config.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // initData();
    initData2();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
      }else{
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

  // // DioUtil().request('/project/tree/json', method: DioMethod.get).then((value) {
  //     //   LoggerUtil.d('==============>  $value', tag: "wan");
  //     //
  //     //   var encode = json.encode(value);
  //     //
  //     //   var decode = json.decode(encode);
  //     //
  //     //   LoggerUtil.d('==============>  $decode', tag: "wan1");
  //     //
  //     //   TestModel model = testModelFromJson(TestModel(), value);
  //     //
  //     //   LoggerUtil.d('==============>  $model', tag: "wan2");
  //     //   LoggerUtil.d('==============>  ${model.errorCode}\n${model.errorMsg}\n${testModelDataToJson(model.data!.toList(growable: true).first)}', tag: "wan3");
  //     //
  //     //
  //     // });

  Future<void> initData2() async {
    BaseResponse response = await DioUtil().request(
        '/project/tree/json',
        method: DioMethod.get);

    LoggerUtil.d('==============>wan 0  $response', tag: "wan");

    //拿到res.data就可以进行Json解析了，这里一般用来构造实体类
    var success = response.success;
    if (success != null) {
      if (success) {

        var data = response.data;
        var data2 = data as List<dynamic>;
        data2.map((e) => null).toList();

        // TestWanProjectTreeModel model = TestWanProjectTreeModel().fromJson(data);
        // LoggerUtil.d('==============>01  $model', tag: "mxnzp");
    //     LoggerUtil.d('==============>02  ${model.origin}', tag: "mxnzp");
    //     LoggerUtil.d('==============>03  ${model.result}', tag: "mxnzp");




        LoggerUtil.d('==============>03  ${response.message}', tag: "wan");
      }else{
        LoggerUtil.d('==============>05  ${response.message}', tag: "wan");
      }
    }
  }
}
