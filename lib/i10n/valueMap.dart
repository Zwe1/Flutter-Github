// 支持的自定义国际化语言列表
const List<String> supportedLanguages = ['en', 'zh'];

// 国际化译文
const Map<String, Map<String, String>> localizationsValuesMap = {
  'en': {
    'home': 'Home',
    'title': 'Title',
    'login': 'Login',
    'username_empty': "please input your username",
    'pwd_empty': "please input your password",
    'username': 'username',
    'un_placeholder': 'username or email',
    'pwd': 'password',
    'theme': 'Theme',
    'language': 'Language',
    'lougout': 'Lougout',
    'cancel': 'Cancel',
    'ok': 'Ok',
  },
  'zh': {
    'home': '主页',
    'title': '标题',
    'login': '登录',
    'username_empty': '用户名称不能为空',
    'pwd_empty': '用户密码不能为空',
    'username': '用户名称',
    'un_placeholder': '名称或邮箱',
    'pwd': '用户密码',
    'theme': '主题',
    'language': '语言',
    'lougout': '退出',
    'cancel': '取消',
    'ok': '确定',
  }
};
