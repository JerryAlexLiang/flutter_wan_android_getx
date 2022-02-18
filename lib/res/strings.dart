import 'package:get/get.dart';

class StringsConstant {
  static const String jumpSplash = "跳过"; //首页
  static const String homePage = "首页"; //首页
  static const String accountTreePage = "体系"; //体系
  static const String navigationPage = "导航"; //导航
  static const String projectPage = "项目"; //项目
  static const String minePage = "我的"; //我的
  static const String changeTheme = "更改主题"; //更改主题
  static const String setting = "设置"; //设置
  static const String theme = "主题"; //主题
  static const String settingTheme = "主题设置"; //主题设置
  static const String darkTheme = "夜间模式"; //夜间模式
  static const String lightTheme = "日间模式"; //日间模式
  static const String systemMode = "跟随系统"; //跟随系统
  static const String language = "语言"; //语言
  static const String simplifiedChinese = "简体中文"; //简体中文
  static const String traditionalChineseHongKong = "繁体中文(香港)"; //繁体中文(香港)
  static const String usEnglish = "英语(US)"; //英语
  static const String exitAppToast = "再次点击退出程序";
  static const String search = "搜索";
  static const String noData = "暂无数据哦";
  static const String noMoreData = "我也是有底线的~";
  static const String loading = "加载中...";
  static const String pullToRefresh = "下拉刷新";
  static const String refreshFailed = "刷新失败~";
  static const String refreshSuccess = "刷新成功~";
  static const String pullToLoading = "上拉加载";
  static const String releaseStartRefreshing = "松手开始刷新数据";
  static const String releaseStartLoading = "松手开始加载数据";
  static const String loadFailed = "加载失败";
  static const String clickRetry = "点击重试";
  static const String freshTag = "新";
  static const String loginSuccess = "登陆成功";
  static const String loginFail = "登录失败 !";
  static const String logoutSuccess = "退出登录成功";
  static const String logoutFail = "退出登录失败";
  static const String myCompany = 'Flutter-玩Android';
  static const String loginContent = '登录';
  static const String registerContent = '注册';
  static const String logoutContent = '退出登录';
  static const String level = '等级';
  static const String rank = '排名';
  static const String collectCount = '站内收藏';
  static const String coinCount = '积分';
  static const String shareCount = '分享';
  static const String browsingHistory = '浏览历史';
  static const String editUserNameHint = '请输入用户名';
  static const String editPasswordHint = '请输入密码';
  static const String editEnsurePasswordHint = '请再次输入密码';
  static const String switchButtonLoginDesc = '已有账号，去登录';
  static const String switchButtonRegisterDesc = '没有账号，去注册';
  static const String loginRegisterInfo = '注册账号成功即登录';
  static const String userNameEmptyInfo = '用户名不能为空~';
  static const String passwordEmptyInfo = '密码不能为空~';
  static const String ensurePasswordEmptyInfo = '确认密码不能为空~';
  static const String ensurePasswordFail = '两次输入的密码不一致!';
  static const String searchHistory = '搜索历史';
  static const String searchHistoryLimit = '最近20条搜索记录';
  static const String alertContent = '提示';
  static const String deleteSearchHistoryAlertContent = '是否删除全部历史记录?';
  static const String cancel = '取消';
  static const String confirm = '确定';
  static const String hotSearch = '热门搜索';
  static const String seeAllRecommends = '查看全部推荐词';
}

///使用Get配置语言环境
///使用Get.updateLocale(locale);即可更新
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        //简体中文
        'zh_CN': {
          StringsConstant.jumpSplash: '跳过',
          StringsConstant.homePage: '首页',
          StringsConstant.accountTreePage: '体系',
          StringsConstant.navigationPage: '导航',
          StringsConstant.projectPage: '项目',
          StringsConstant.minePage: '我的',
          StringsConstant.changeTheme: '更改主题',
          StringsConstant.setting: '设置',
          StringsConstant.theme: '主题',
          StringsConstant.settingTheme: '主题设置',
          StringsConstant.darkTheme: '夜间模式',
          StringsConstant.lightTheme: '日间模式',
          StringsConstant.systemMode: '跟随系统',
          StringsConstant.language: '语言',
          StringsConstant.simplifiedChinese: '简体中文',
          StringsConstant.traditionalChineseHongKong: '繁体中文(香港)',
          StringsConstant.usEnglish: '英语(US)',
          StringsConstant.exitAppToast: '再次点击退出程序',
          StringsConstant.search: '搜索',
          StringsConstant.noData: '暂无数据哦',
          StringsConstant.loading: '加载中...',
          StringsConstant.noMoreData: "我也是有底线的~",
          StringsConstant.pullToRefresh: "下拉刷新",
          StringsConstant.refreshFailed: "刷新失败~",
          StringsConstant.refreshSuccess: "刷新成功~",
          StringsConstant.pullToLoading: "上拉加载",
          StringsConstant.releaseStartRefreshing: "松手开始刷新数据",
          StringsConstant.releaseStartLoading: "松手开始加载数据",
          StringsConstant.loadFailed: '加载失败~',
          StringsConstant.clickRetry: "点击重试",
          StringsConstant.freshTag: "新",
          StringsConstant.loginSuccess: "登陆成功",
          StringsConstant.loginFail: "登录失败 !",
          StringsConstant.logoutSuccess: "退出登录成功",
          StringsConstant.logoutFail: "退出登录失败",
          StringsConstant.myCompany: "Flutter-玩Android",
          StringsConstant.loginContent: "登录",
          StringsConstant.registerContent: "注册",
          StringsConstant.logoutContent: "退出登录",
          StringsConstant.level: "等级",
          StringsConstant.rank: "排名",
          StringsConstant.collectCount: "站内收藏",
          StringsConstant.coinCount: "积分",
          StringsConstant.shareCount: "分享",
          StringsConstant.browsingHistory: "浏览历史",
          StringsConstant.editUserNameHint: "请输入用户名",
          StringsConstant.editPasswordHint: "请输入密码",
          StringsConstant.editEnsurePasswordHint: "请再次输入密码",
          StringsConstant.switchButtonLoginDesc: "已有账号，去登录",
          StringsConstant.switchButtonRegisterDesc: "没有账号，去注册",
          StringsConstant.loginRegisterInfo: "注册账号成功即登录",
          StringsConstant.userNameEmptyInfo: '用户名不能为空~',
          StringsConstant.passwordEmptyInfo: "密码不能为空~",
          StringsConstant.ensurePasswordEmptyInfo: "确认密码不能为空~",
          StringsConstant.ensurePasswordFail: "两次输入的密码不一致!",
          StringsConstant.searchHistory: "搜索历史",
          StringsConstant.searchHistoryLimit: "最近20条搜索记录",
          StringsConstant.alertContent: "提示",
          StringsConstant.deleteSearchHistoryAlertContent: "是否删除全部历史记录?",
          StringsConstant.cancel: "取消",
          StringsConstant.confirm: "确定",
          StringsConstant.hotSearch: "热门搜索",
          StringsConstant.seeAllRecommends: "查看全部推荐词",
        },
        //繁体中文（香港）
        'zh_HK': {
          StringsConstant.jumpSplash: '跳过',
          StringsConstant.homePage: '首頁',
          StringsConstant.accountTreePage: '體系',
          StringsConstant.navigationPage: '導航',
          StringsConstant.projectPage: '項目',
          StringsConstant.minePage: '我的',
          StringsConstant.changeTheme: '更改主題',
          StringsConstant.setting: '設置',
          StringsConstant.theme: '主題',
          StringsConstant.settingTheme: '主题設置',
          StringsConstant.darkTheme: '夜間模式',
          StringsConstant.lightTheme: '日間模式',
          StringsConstant.systemMode: '跟隨系統',
          StringsConstant.language: '語言',
          StringsConstant.simplifiedChinese: '简体中文',
          StringsConstant.traditionalChineseHongKong: '繁体中文(香港)',
          StringsConstant.usEnglish: '英語(US)',
          StringsConstant.exitAppToast: '再按一次退出程序',
          StringsConstant.search: '搜索',
          StringsConstant.noData: '暫無數據哦',
          StringsConstant.loading: '加載中...',
          StringsConstant.noMoreData: "我也是有底線的~",
          StringsConstant.pullToRefresh: "下拉刷新",
          StringsConstant.refreshFailed: "刷新失敗~",
          StringsConstant.refreshSuccess: "刷新成功~",
          StringsConstant.releaseStartRefreshing: "鬆手開始刷新數據",
          StringsConstant.pullToLoading: "上拉加載",
          StringsConstant.releaseStartLoading: "鬆手開始加載數據",
          StringsConstant.loadFailed: '加載失敗~',
          StringsConstant.clickRetry: "點擊重試",
          StringsConstant.freshTag: "新",
          StringsConstant.loginSuccess: "登陆成功",
          StringsConstant.loginFail: "登录失败 !",
          StringsConstant.logoutSuccess: "退出登录成功",
          StringsConstant.logoutFail: "退出登录失败",
          StringsConstant.myCompany: "Flutter-玩Android",
          StringsConstant.loginContent: "登录",
          StringsConstant.registerContent: "注册",
          StringsConstant.logoutContent: "退出登录",
          StringsConstant.level: "等级",
          StringsConstant.rank: "排名",
          StringsConstant.collectCount: "站内收藏",
          StringsConstant.coinCount: "积分",
          StringsConstant.shareCount: "分享",
          StringsConstant.browsingHistory: "浏览历史",
          StringsConstant.editUserNameHint: "请输入用户名",
          StringsConstant.editPasswordHint: "请输入密码",
          StringsConstant.editEnsurePasswordHint: "请再次输入密码",
          StringsConstant.switchButtonLoginDesc: "已有账号，去登录",
          StringsConstant.switchButtonRegisterDesc: "没有账号，去注册",
          StringsConstant.loginRegisterInfo: "注册账号成功即登录",
          StringsConstant.userNameEmptyInfo: '用户名不能为空~',
          StringsConstant.passwordEmptyInfo: "密码不能为空~",
          StringsConstant.ensurePasswordEmptyInfo: "确认密码不能为空~",
          StringsConstant.ensurePasswordFail: "两次输入的密码不一致!",
          StringsConstant.searchHistory: "搜索历史",
          StringsConstant.searchHistoryLimit: "最近20条搜索记录",
          StringsConstant.alertContent: "提示",
          StringsConstant.deleteSearchHistoryAlertContent: "是否删除全部历史记录?",
          StringsConstant.cancel: "取消",
          StringsConstant.confirm: "确定",
          StringsConstant.hotSearch: "热门搜索",
          StringsConstant.seeAllRecommends: "查看全部推荐词",
        },
        //English
        'en_US': {
          StringsConstant.jumpSplash: 'Skip',
          StringsConstant.homePage: 'Home',
          StringsConstant.accountTreePage: 'System',
          StringsConstant.navigationPage: 'Navigation',
          StringsConstant.projectPage: 'Project',
          StringsConstant.minePage: 'Mine',
          StringsConstant.changeTheme: 'Change Theme',
          StringsConstant.setting: 'Setting',
          StringsConstant.theme: 'Theme',
          StringsConstant.settingTheme: 'Setting Theme',
          StringsConstant.darkTheme: 'DarkMode',
          StringsConstant.lightTheme: 'LightMode',
          StringsConstant.systemMode: 'Follow The System',
          StringsConstant.language: 'Language',
          StringsConstant.simplifiedChinese: 'Simplified Chinese',
          StringsConstant.traditionalChineseHongKong:
              'Traditional Chinese(HongKong)',
          StringsConstant.usEnglish: 'English(US)',
          StringsConstant.exitAppToast: 'Click Again ToExit The Program',
          StringsConstant.search: 'Search',
          StringsConstant.noData: 'No data yet',
          StringsConstant.loading: 'Loading...',
          StringsConstant.noMoreData: "There's no more data~",
          StringsConstant.pullToRefresh: "Pull to refresh",
          StringsConstant.refreshFailed: "Refresh the failure~",
          StringsConstant.refreshSuccess: "Refresh the success~",
          StringsConstant.releaseStartRefreshing: "Release start refreshing",
          StringsConstant.pullToLoading: "Pull to loading",
          StringsConstant.releaseStartLoading: "Release start leading",
          StringsConstant.loadFailed: 'Load failed~',
          StringsConstant.clickRetry: "Click retry",
          StringsConstant.freshTag: "New",
          StringsConstant.loginSuccess: "Login success!",
          StringsConstant.loginFail: "Login fail !",
          StringsConstant.logoutSuccess: "Logout success",
          StringsConstant.logoutFail: "Logout fail",
          StringsConstant.myCompany: "Flutter-Wan Android",
          StringsConstant.loginContent: "Login",
          StringsConstant.registerContent: "Register",
          StringsConstant.logoutContent: "Log out",
          StringsConstant.level: "Level",
          StringsConstant.rank: "Rank",
          StringsConstant.collectCount: "Collect",
          StringsConstant.coinCount: "Coin",
          StringsConstant.shareCount: "Share",
          StringsConstant.browsingHistory: "History",
          StringsConstant.editUserNameHint: "Please enter user name",
          StringsConstant.editPasswordHint: "Please enter your password",
          StringsConstant.editEnsurePasswordHint:
              "Please enter your password again",
          StringsConstant.switchButtonLoginDesc: "Have an account, log in",
          StringsConstant.switchButtonRegisterDesc:
              "Not have an account, sign up",
          StringsConstant.loginRegisterInfo:
              "Log in once the account is successfully registered",
          StringsConstant.userNameEmptyInfo: 'The user name cannot be empty~',
          StringsConstant.passwordEmptyInfo: "The password cannot be empty~",
          StringsConstant.ensurePasswordEmptyInfo:
              "Confirm password cannot be empty~",
          StringsConstant.ensurePasswordFail:
              "The entered passwords are inconsistent!",
          StringsConstant.searchHistory: "Search history",
          StringsConstant.searchHistoryLimit: "The last 20 searches",
          StringsConstant.alertContent: "Alert",
          StringsConstant.deleteSearchHistoryAlertContent:
              "Whether to delete all historical records?",
          StringsConstant.cancel: "Cancel",
          StringsConstant.confirm: "Confirm",
          StringsConstant.hotSearch: "Hot search",
          StringsConstant.seeAllRecommends: "See all the recommendations",
        },
      };
}
