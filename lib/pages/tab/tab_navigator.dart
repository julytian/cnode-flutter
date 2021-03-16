import 'package:cnode_flutter2/config/router_manager.dart';
import 'package:cnode_flutter2/generated/l10n.dart';
import 'package:cnode_flutter2/pages/tab/collect/colllect_page.dart';
import 'package:cnode_flutter2/pages/tab/home/home_page.dart';
import 'package:cnode_flutter2/pages/tab/message/message_page.dart';
import 'package:cnode_flutter2/pages/tab/user/user_page.dart';
import 'package:cnode_flutter2/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<Widget> tabPages = [
  HomePage(),
  CollectPage(),
  MessagePage(),
  UserPage(),
];

class TabNavigatorPage extends StatefulWidget {
  @override
  _TabNavigatorPageState createState() => _TabNavigatorPageState();
}

class _TabNavigatorPageState extends State<TabNavigatorPage> {
  PageController _pageController = PageController();
  int _currentIndex = 0;
  DateTime _lastPressedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_lastPressedTime == null ||
              DateTime.now().difference(_lastPressedTime) >
                  Duration(seconds: 1)) {
            _lastPressedTime = DateTime.now();
            return false;
          }
          return true;
        },
        child: PageView.builder(
          itemBuilder: (ctx, index) => tabPages[index],
          itemCount: tabPages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  /// 底部导航栏
  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: S.of(context).tabHome,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: S.of(context).tabCollect,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: S.of(context).tabMessage,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: S.of(context).tabUser,
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (index) async {
        if (index == 1 || index == 2) {
          var hasUser = Provider.of<UserViewModel>(context).hasUser;
          if (!hasUser) {
            final isLogin =
                await Navigator.of(context).pushNamed(RouteName.login);
            if (isLogin != null) {
              _pageController.jumpToPage(index);
            }
          } else {
            _pageController.jumpToPage(index);
          }
        } else {
          _pageController.jumpToPage(index);
        }
      },
    );
  }
}
