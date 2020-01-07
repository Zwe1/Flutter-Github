import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:startup_namer/utils/gitApi.dart';
import 'package:startup_namer/utils/globalVariables.dart';
import 'package:startup_namer/models/index.dart';
import 'package:startup_namer/widgets/loading.dart';
import 'package:startup_namer/utils/profileChangeNotifier.dart';
import 'package:startup_namer/i10n/index.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    _unameController.text = Global.profile.lastLogin;
    if (_unameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var i18n = Localizations.of(context, null);

    return Scaffold(
      appBar: AppBar(
        title: Text(NativeLocalizations.of(context).login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _unameController,
                validator: (v) {
                  return v.trim().isNotEmpty
                      ? null
                      : NativeLocalizations.of(context).usernameEmpty;
                },
                decoration: InputDecoration(
                    labelText: NativeLocalizations.of(context).username,
                    hintText:
                        NativeLocalizations.of(context).usernamePlaceholder,
                    prefixIcon: Icon(Icons.person)),
              ),
              TextFormField(
                autofocus: !_nameAutoFocus,
                controller: _pwdController,
                obscureText: !pwdShow,
                validator: (v) {
                  return v.trim().isNotEmpty
                      ? null
                      : NativeLocalizations.of(context).pwdEmpty;
                },
                decoration: InputDecoration(
                  labelText: NativeLocalizations.of(context).password,
                  hintText: NativeLocalizations.of(context).password,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon:
                        Icon(pwdShow ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _onLogin,
                    textColor: Colors.white,
                    child: Text(NativeLocalizations.of(context).login),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    if ((_formKey.currentState).validate()) {
      // 显示Loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new Loading("账号登录中…");
        },
      );

      User user;
      List<Repo> repoList;
      try {
        user = await Git(context)
            .login(_unameController.text.trim(), _pwdController.text.trim());

        Provider.of<UserModal>(context, listen: false).user = user;

        repoList = await Git(context)
            .getRepos(url: user.repos_url ?? '', refresh: true, params: {
          'page': 1,
          'page_size': 20,
        });

        Provider.of<RepoModal>(context, listen: false).repoList = repoList;
      } catch (e) {
        final bool pwdError = false;

        // Fluttertoast.showToast(
        //     msg: pwdError ? "用户名或密码错误" : e.toString(),
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIos: 1,
        //     backgroundColor: Color(0xe74c3c),
        //     textColor: Colors.white);
      } finally {
        Navigator.of(context).pop();
      }

      if (user != null) {
        Navigator.of(context).pop();
      }
    }
  }
}
