import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/i10n/localizations.dart';
import 'package:startup_namer/utils/gmAvatar.dart';
import 'package:startup_namer/utils/profileChangeNotifier.dart';
import 'package:startup_namer/models/index.dart';
import 'package:startup_namer/utils/gitApi.dart';
import 'package:startup_namer/widgets/repoItem.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() {
    print('createState----');
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute> {
  List<Repo> repoList;

  @override
  void initState() {
    super.initState();
    print('initState----');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(NativeLocalizations.of(context).home),
      ),
      body: _buildBody(context),
      drawer: MyDrawer(),
    );
  }

  Widget _buildBody(context) {
    UserModal userModal = Provider.of<UserModal>(context);
    RepoModal repo = Provider.of<RepoModal>(context);

    if (!userModal.isLogin) {
      // 用户未登录
      return Center(
        child: RaisedButton(
          child: Text(NativeLocalizations.of(context).login),
          onPressed: () => Navigator.of(context).pushNamed('login'),
        ),
      );
    } else {
      return new ListView.builder(
        itemCount: repo?.repoList?.length ?? 0,
        itemBuilder: (BuildContext context, int i) {
          return RepoIetm(repo.repoList[i]);
        },
      );
    }
  }
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
                        : Image.asset('lib/assets/images/avatar-default.png',
                            width: 80),
                  ),
                ),
                Text(value.isLogin
                    ? value.user.login
                    : NativeLocalizations.of(context).login),
                // style: TextStyle(
                //     fontWeight: FontWeight.bold, color: Colors.white)
              ],
            ),
          ),
          onTap: () {
            // 没登录，点击时跳转登录
            if (!value.isLogin) Navigator.of(context).pushNamed('login');
            // Navigator.of(context).pop();
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
              title: Text(NativeLocalizations.of(context).theme),
              onTap: () => Navigator.pushNamed(context, 'themes'),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(NativeLocalizations.of(context).language),
              onTap: () => Navigator.pushNamed(context, 'language'),
            ),
            if (userModal.isLogin)
              ListTile(
                leading: const Icon(Icons.power_settings_new),
                title: Text(NativeLocalizations.of(context).lougout),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          content:
                              Text(NativeLocalizations.of(context).lougout),
                          actions: <Widget>[
                            FlatButton(
                              child:
                                  Text(NativeLocalizations.of(context).cancel),
                              onPressed: () => Navigator.pop(context),
                            ),
                            FlatButton(
                              child: Text(NativeLocalizations.of(context).ok),
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
