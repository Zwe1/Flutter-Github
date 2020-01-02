## 问题汇总

1. shared_preferences package [安装失败](./assets/shared_preferences.png)

在 android/build.gradle 目录中添加如下

```
    repositories {
        google()
        mavenCentral()  //add this line
        jcenter()
    }
```

## packages

1. 数据持久化

shared_preferences
