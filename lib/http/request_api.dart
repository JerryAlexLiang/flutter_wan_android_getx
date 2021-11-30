class RequestApi {
  static const String baseUrl = "https://www.wanandroid.com";

  static const String mxnzpBaseUrl = "https://www.mxnzp.com";

  /// 搜索热词 - 热门搜索 热词 GET  https://www.wanandroid.com/hotkey/json
  static const String hotSearch = "/hotkey/json";

  /// 搜索 POST    https://www.wanandroid.com/article/query/0/json
  /// 页码：拼接在链接上，从0开始  k ： 搜索关键词
  /// 注：该接口支持传入 page_size 控制分页数量，取值为[1-40]，不传则使用默认值，一旦传入了 page_size，后续该接口分页都需要带上，否则会造成分页读取错误。
  /// 注意：支持多个关键词，用空格隔开
  /// 使用 RequestApi.articleSearch.replaceFirst(RegExp('page'), '$currentPage'),
  static const String articleSearch = '/article/query/page/json';

  /// 收藏站内文章 https://www.wanandroid.com/lg/collect/1165/json
  /// 方法：POST  参数： 文章id，拼接在链接中  注意链接中的数字，为需要收藏的id
  /// 此接口使用sprintf插件进行String格式化操作
  static const String collectInsideArticle = '/lg/collect/%s/json';

  /// 取消收藏 文章列表   https://www.wanandroid.com/lg/uncollect_originId/2333/json
  /// 方法：POST   id:拼接在链接上
  static const String unCollectInsideArticle = '/lg/uncollect_originId/%s/json';

}
