import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:startup_namer/utils/globalVariables.dart';

// 缓存对象
class CacheObject {
  Response response;
  int timeStamp;

  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;

  // 重写操作符
  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

// 缓存请求
class NetCache extends Interceptor {
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  Future onRequest(RequestOptions options) async {
    if (!Global.profile.cache.enable) return options;
    // refresh设置是否‘下拉刷新’
    bool refresh = options.extra['refresh'] = true;

    if (refresh) {
      if (options.extra['list'] == true) {
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        cache.remove(options.uri.toString());
      }
      return options;
    }

    if (options.extra['noCache'] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra['cacheKey'] ?? options.uri.toString();

      var ob = cache[key];

      if (ob != null) {
        var mstillNow = DateTime.now().millisecondsSinceEpoch - ob.timeStamp;
        if (mstillNow / 1000 < Global.profile.cache.maxAge) {
          return cache[key].response;
        } else {
          // 缓存过期则清除缓存
          cache.remove(key);
        }
      }
    }
  }

  @override
  Future onResponse(Response response) async {
    if (Global.profile.cache.enable) {
      _saveCache(response);
    }
  }

  _saveCache(Response resp) {
    RequestOptions options = resp.request;
    if (options.extra['noCache'] != true &&
        options.method.toLowerCase() == 'get') {
      if (cache.length == Global.profile.cache.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      cache[key] = CacheObject(resp);
    }
  }
}
