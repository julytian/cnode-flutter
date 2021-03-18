import 'package:cnode_flutter2/config/resource_manager.dart';
import 'package:cnode_flutter2/pages/login/login_text_field.dart';
import 'package:cnode_flutter2/providers/provider_widget.dart';
import 'package:cnode_flutter2/view_models/login_view_model.dart';
import 'package:cnode_flutter2/view_models/user_view_model.dart';
import 'package:cnode_flutter2/widgets/bottom_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _accessTokenController = TextEditingController();
  FocusNode _tokenFocus = FocusNode();

  @override
  void dispose() {
    _accessTokenController.dispose();
    _tokenFocus.unfocus();
    _tokenFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Positioned(
                  top: -20,
                  left: 0,
                  right: 0,
                  height: 220 + MediaQuery.of(context).padding.top,
                  child: loginTopPanel(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      loginLogo(),
                      loginFormContainer(
                        child: ProviderWidget<LoginViewModel>(
                          model: LoginViewModel(
                            Provider.of<UserViewModel>(context),
                          ),
                          builder: (context, model, child) {
                            return Form(
                              onWillPop: () async {
                                return !model.isBusy;
                              },
                              child: child,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              LoginTextField(
                                controller: _accessTokenController,
                                label: 'accesstoken',
                                icon: Icons.lock_outline,
                                obscureText: true,
                                focusNode: _tokenFocus,
                                textInputAction: TextInputAction.done,
                              ),
                              LoginButton(_accessTokenController),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loginFormContainer({Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(),
          color: Theme.of(context).cardColor,
          shadows: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withAlpha(20),
              offset: Offset(1.0, 1.0),
              blurRadius: 10.0,
              spreadRadius: 3.0,
            ),
          ]),
      child: child,
    );
  }

  Widget loginLogo() {
    var theme = Theme.of(context);
    return Hero(
      tag: 'loginLogo',
      child: Image.asset(
        ImageHelper.wrapAssets('login_logo.png'),
        width: 130,
        height: 100,
        fit: BoxFit.fitWidth,
        color: theme.brightness == Brightness.dark
            ? theme.accentColor
            : Colors.white,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }

  Widget loginTopPanel() {
    return ClipPath(
      clipper: BottomClipper(),
      child: Container(
        height: 200 + MediaQuery.of(context).padding.top,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final accessTokenController;

  LoginButton(this.accessTokenController);
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor.withAlpha(180);
    return ProviderWidget<LoginViewModel>(
      model: LoginViewModel(Provider.of<UserViewModel>(context)),
      builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 15, 20),
          child: CupertinoButton(
            padding: EdgeInsets.all(0),
            color: color,
            disabledColor: color,
            borderRadius: BorderRadius.circular(110),
            pressedOpacity: 0.5,
            child: model.isBusy
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(color),
                    ),
                  )
                : Text(
                    '登录',
                    style: Theme.of(context)
                        .accentTextTheme
                        .subtitle1
                        .copyWith(wordSpacing: 6),
                  ),
            onPressed: model.isBusy
                ? null
                : () {
                    var formState = Form.of(context);
                    if (formState.validate()) {
                      model.login(accessTokenController.text).then((value) {
                        if (value) {
                          Navigator.of(context).pop(true);
                        } else {
                          model.showErrorMessage(context);
                        }
                      });
                    }
                  },
          ),
        );
      },
    );
  }
}
