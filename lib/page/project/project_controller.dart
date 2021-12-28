import 'package:flutter/material.dart';
import 'package:flutter_wan_android_getx/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/base_response.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/tree_model.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:get/get.dart';

class ProjectController extends BaseGetXWithPageRefreshController
    with GetSingleTickerProviderStateMixin {
  /// 项目分类
  // final projectTreeList = RxList<TreeModel?>();
  final projectTreeList = List<TreeModel?>.empty(growable: true).obs;

  /// TabBar索引
  final projectChildrenIndex = 0.obs;

  late TabController tabController;

  // @override
  // void onInit() {
  //   super.onInit();
  //   if(projectTreeList.isNotEmpty){
  //     tabController.addListener(() {
  //       projectChildrenIndex.value = tabController.index;
  //     });
  //   }
  // }

  @override
  void onReady() {
    super.onReady();
    initProjectTreeList();
  }

  Future<void> initProjectTreeList() async {
    // BaseResponse response =
    //     await DioUtil().request(RequestApi.projectTree, method: DioMethod.get);
    //
    // var success = response.success;
    // if (success != null) {
    //   ///列表转换的时候一定要加一下强转List<dynamic>，否则会报错
    //   List<TreeModel> dataList = (response.data as List<dynamic>)
    //       .map((e) => TreeModel.fromJson(e))
    //       .toList();
    //   projectTreeList.assignAll(dataList);
    //   if (projectTreeList.isNotEmpty) {
    //     tabController =
    //         TabController(length: projectTreeList.length, vsync: this);
    //   }
    // }

    handleRequest(
      loadingType: Constant.lottieRocketLoading,
      future: DioUtil().request(RequestApi.projectTree, method: DioMethod.get),
      onSuccess: (response) {
        ///列表转换的时候一定要加一下强转List<dynamic>，否则会报错
        List<TreeModel> dataList = (response as List<dynamic>)
            .map((e) => TreeModel.fromJson(e))
            .toList();
        if (dataList.isNotEmpty) {
          projectTreeList.assignAll(dataList);
          tabController = TabController(
              length: projectTreeList.length,
              initialIndex: projectChildrenIndex.value,
              vsync: this);
          loadState = LoadState.success;
        } else {
          loadState = LoadState.empty;
        }
      },
      onFail: (value) {
        loadState = LoadState.fail;
      },
      onError: (error) {
        loadState = LoadState.fail;
      },
    );
  }
}
