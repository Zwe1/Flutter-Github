import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:startup_namer/models/index.dart';
import 'package:startup_namer/utils/globalVariables.dart';

class Git {
  BuildContext context;
  Options options;

  Git([this.context]) {
    options = Options(extra: {'context': context});
  }

  // 请求reqeust
  static Dio dio = new Dio(BaseOptions(
    baseUrl: 'https://api.github.com/',
    //     headers: {
    //   HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
    //       "application/vnd.github.symmetra-preview+json",
    // }
  ));

  static void init() {
    dio.interceptors.add(Global.netCache);
    // 设置token
    // dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;

    // if (!Global.isRelease) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     // 启用代理
    //     client.findProxy = (Uri uri) {
    //       return 'PROXY 10.1.10.250:8888';
    //     };
    //     // 禁止https整数娇艳
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //   };
    // }
  }

  // 用户登录
  Future<User> login(String login, String pwd) async {
    String basic = 'Basic' + base64.encode(utf8.encode('$login:$pwd'));

    var response = await dio.get('users/$login');
    // options: options.merge(
    //     headers: {HttpHeaders.authorizationHeader: basic},
    //     extra: {'noCache': true}));

    dio.options.headers[HttpHeaders.authorizationHeader] = basic;

    // 清理缓存
    Global.netCache.cache.clear();

    Global.profile.token = basic;

    return User.fromJson(response.data);
  }

  // 获取仓库列表
  Future<List<Repo>> getRepos(
      {String url, Map<String, dynamic> params, bool refresh = false}) async {
    if (refresh) {
      options.extra.addAll({'refresh': true, 'list': true});
    }

    var response =
        await dio.get<List>(url, queryParameters: params, options: options);

    return response.data.map((e) => Repo.fromJson(e)).toList();
  }
}
