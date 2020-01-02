import 'dart:convert';
import 'package:startup_namer/utils/gitApi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_namer/models/index.dart';

const themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  // 持久化数据
  static SharedPreferences perfs;
  // 用户配置
  static Profile profile = new Profile();
  // 缓存
  static CacheConfig netCache = new CacheConfig();
  // 主题列表
  static List<MaterialColor> get themes => themes;
  // 是否生产版本
  static bool isRelease = bool.fromEnvironment('dart.vm.product');

  // 初始化全局信息
  static Future init() async {
    perfs = await SharedPreferences.getInstance();
    Profile p;
    var profile = perfs.getString('profile');
    if (profile != null) {
      try {
        p = Profile.fromJson(jsonDecode(profile));
      } catch (e) {
        print(e);
      }
    }

    p.cache = p.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    Git.init();
  }

  static saveProfile() =>
      perfs.setString('profile', jsonEncode(profile.toJson()));
}
