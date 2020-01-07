import 'dart:convert';
import 'package:startup_namer/utils/gitApi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_namer/models/index.dart';
import 'package:startup_namer/utils/httpRequest.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  // 持久化数据
  static SharedPreferences _perfs;
  // 用户配置
  static Profile profile;
  // 仓库数据
  static List<Repo> repoList;
  // 缓存
  static NetCache netCache = new NetCache();
  // 主题列表
  static List<MaterialColor> get themes => _themes;
  // 是否生产版本
  static bool isRelease = bool.fromEnvironment('dart.vm.product');

  // 初始化全局信息
  static Future init() async {
    _perfs = await SharedPreferences.getInstance();

    String p = _perfs.getString('profile');

    if (profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(p));
      } catch (e) {
        print(e);
      }
    } else {
      profile = Profile();
    }

    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    Git.init();
  }

  static saveProfile() =>
      _perfs.setString('profile', jsonEncode(profile.toJson()));
}
