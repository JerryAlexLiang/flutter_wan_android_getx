/// 对Restful APi风格进行统一封装
/// 不管是get()还是post()请求，Dio内部最终都会调用request方法，只是传入的method不一样，所以我们这里定义一个枚举类型在一个方法中进行处理;
enum DioMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
}
