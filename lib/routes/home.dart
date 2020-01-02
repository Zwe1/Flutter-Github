import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/utils/gmAvatar.dart';
import 'package:startup_namer/utils/profileChangeNotifier.dart';

class HomeRoute extends StatefulWidget {
  @override
  HomeRouteState createState() => HomeRouteState();
}

class HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      body: buildBody(context),
      // drawer: myDraw(),
    );
  }

  buildBody(context) async {
    UserModal userModal = Provider.of<UserModal>(context);

    if (!userModal.isLogin) {
      // 用户未登录
      return Center(
        child: RaisedButton(
          child: Text('登录'),
          onPressed: () => Navigator.of(context).pushNamed('login'),
        ),
      );
    } else {
      // var data = await Git(context).getRepos(refresh: true, params: {
      //   'page': 1,
      //   'page_size': 20,
      // });

      // return InfiniteListView.separated(
      //     itemBuilder: (BuildContext context, int index) {
      //   return RepoItem(index);
      // });
      return Text('content');
    }
  }

  // Widget myDraw() {}
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //  菜单头部
            _buildHeader(),
            Expanded(
              // 功能菜单
              child: _buildMenus(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModal>(
      builder: (BuildContext context, UserModal value, Widget child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipOval(
                    child: value.isLogin
                        ? gmAvatar(value.user.avatar_url, width: 80)
                        : Image.asset('imgs/avatar-default.png', width: 80),
                  ),
                ),
                Text(value.isLogin
                    ? value.user.login
                    : Localizations.of(context, null)),
                // style: TextStyle(
                //     fontWeight: FontWeight.bold, color: Colors.white)
              ],
            ),
          ),
          onTap: () {
            // 没登录，点击时跳转登录
            if (!value.isLogin) Navigator.of(context).pushNamed('login');
          },
        );
      },
    );
  }

  Widget _buildMenus() {
    return Consumer<UserModal>(
      builder: (BuildContext context, UserModal userModal, Widget child) {
        // var i18n = Localizations.of(context, null);

        return ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text('themes'),
              onTap: () => Navigator.pushNamed(context, 'themes'),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text('language'),
              onTap: () => Navigator.pushNamed(context, 'language'),
            ),
            if (userModal.isLogin)
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: Text('logout'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          content: Text('退出'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('取消'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            FlatButton(
                              child: Text('确定 '),
                              onPressed: () {
                                //该赋值语句会触发MaterialApp rebuild
                                userModal.user = null;
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                },
              )
          ],
        );
      },
    );
  }
}
