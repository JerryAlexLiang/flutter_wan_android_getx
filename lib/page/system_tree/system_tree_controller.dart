import 'package:flutter_wan_android_getx/base/base_getx_with_page_refresh_controller.dart';
import 'package:flutter_wan_android_getx/constant/constant.dart';
import 'package:flutter_wan_android_getx/http/dio_method.dart';
import 'package:flutter_wan_android_getx/http/dio_util.dart';
import 'package:flutter_wan_android_getx/http/request_api.dart';
import 'package:flutter_wan_android_getx/model/tree_model.dart';
import 'package:flutter_wan_android_getx/widget/state/load_state.dart';
import 'package:get/get.dart';

class SystemTreeController extends BaseGetXWithPageRefreshController {
  /// 体系数据列表
  // final RxList<TreeModel?>? treeList = RxList<TreeModel?>();
  final treeList = RxList<TreeModel?>();

  @override
  void onInit() {
    super.onInit();
    refreshLoadState = LoadState.success;
  }

  @override
  void onReadyInitData() {
    super.onReadyInitData();
    initSystemTreeData();
  }

  /// 请求体系数据
  Future<void> initSystemTreeData() async {
    handleRequestWithRefreshPaging(
      loadingType: Constant.showLoadingDialog,
      future: DioUtil().request(RequestApi.treeList, method: DioMethod.get),
      onSuccess: (response) {
        refreshLoadState = LoadState.success;

        ///列表转换的时候一定要加一下强转List<dynamic>，否则会报错
        List<TreeModel> dataList = (response as List<dynamic>)
            .map((e) => TreeModel.fromJson(e))
            .toList();
        treeList.assignAll(dataList);
      },
      onFail: (value) {
        refreshLoadState = LoadState.fail;
      },
      onError: (error) {
        refreshLoadState = LoadState.fail;
      },
    );
  }
}
