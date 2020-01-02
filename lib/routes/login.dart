import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:startup_namer/utils/gitApi.dart';
import 'package:startup_namer/utils/globalVariables.dart';
import 'package:startup_namer/models/index.dart';

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
        title: Text('登录'),
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
                  return v.trim().isNotEmpty ? null : '用户名称不能为空';
                },
                decoration: InputDecoration(
                    labelText: '用户名称',
                    hintText: '名称或邮箱',
                    prefixIcon: Icon(Icons.person)),
              ),
              TextFormField(
                autofocus: !_nameAutoFocus,
                controller: _pwdController,
                obscureText: !pwdShow,
                validator: (v) {
                  return v.trim().isNotEmpty ? null : '用户密码不能为空';
                },
                decoration: InputDecoration(
                  labelText: '用户密码',
                  hintText: '用户密码',
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
                    child: Text('登录'),
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
      // showLoading(context);
      User user;

      try {
        user = await Git(context)
            .login(_unameController.text, _pwdController.text);

        Provider.of(context, listen: false).user = user;
      } catch (e) {}
    }
  }
}
