import 'package:cnode_flutter2/config/resource_manager.dart';
import 'package:cnode_flutter2/config/router_manager.dart';
import 'package:cnode_flutter2/view_models/login_view_model.dart';
import 'package:cnode_flutter2/widgets/bottom_clipper.dart';
import 'package:cnode_flutter2/providers/provider_widget.dart';
import 'package:cnode_flutter2/view_models/user_view_model.dart';
import 'package:cnode_flutter2/widgets/common_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          sliverAppBar(),
        ],
      ),
    );
  }

  Widget sliverAppBar() {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      pinned: false,
      expandedHeight: 200 + MediaQuery.of(context).padding.top,
      flexibleSpace: headerSpace(),
      actions: [
        ProviderWidget<LoginViewModel>(
          model: LoginViewModel(Provider.of<UserViewModel>(context)),
          builder: (context, model, child) {
            if (model.userViewModel.hasUser) {
              return IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  model.logout();
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget headerSpace() {
    return ClipPath(
      clipper: BottomClipper(),
      child: Expanded(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Consumer<UserViewModel>(
            builder: (context, model, child) {
              return InkWell(
                onTap: model.hasUser
                    ? null
                    : () {
                        Navigator.of(context).pushNamed(RouteName.login);
                      },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'loginLogo',
                      child: ClipOval(
                        child: model.hasUser
                            ? CommonImage(
                                url: model.user.avatarUrl,
                                width: 80,
                                height: 80,
                              )
                            : Image.asset(
                                ImageHelper.wrapAssets('user_avatar.png'),
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                                color: model.hasUser
                                    ? Theme.of(context).accentColor.withAlpha(200)
                                    : Theme.of(context).accentColor.withAlpha(10),
                                // https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
                                colorBlendMode: BlendMode.colorDodge,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Text(
                          model.hasUser ? model.user.loginname : '登录',
                          style: Theme.of(context).textTheme.subtitle1.apply(
                                color: Colors.white.withAlpha(200),
                              ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        if (model.hasUser)
                          Center(
                            child: Text(
                              '积分: ${model.user.score}',
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
