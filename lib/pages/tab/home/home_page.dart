import 'package:cnode_flutter2/pages/tab/home/topic_list.dart';
import 'package:cnode_flutter2/utils/status_bar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// topic tab 列表
List<Map<String, String>> tabLists = [
  {
    'tab': 'all',
    'name': '全部',
  },
  {
    'tab': 'good',
    'name': '精华',
  },
  {
    'tab': 'share',
    'name': '分享',
  },
  {
    'tab': 'ask',
    'name': '问答',
  },
  {
    'tab': 'job',
    'name': '招聘',
  },
  {
    'tab': 'dev',
    'name': '测试',
  },
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  ValueNotifier<int> _valueNotifier;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier(0);
  }

  @override
  void dispose() {
    super.dispose();
    _valueNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: StatusBarUtils.systemUiOverlayStyle(context),
      child: ValueListenableProvider<int>.value(
        value: _valueNotifier,
        child: DefaultTabController(
          length: tabLists.length,
          initialIndex: _valueNotifier.value,
          child: Builder(builder: (context) {
            if (_tabController == null) {
              _tabController = DefaultTabController.of(context);
              _tabController.addListener(() {
                _valueNotifier.value = _tabController.index;
              });
            }
            return Scaffold(
              appBar: AppBar(
                title: homeAppBarTitle(context),
              ),
              body: TabBarView(
                controller: _tabController,
                children: List.generate(
                  tabLists.length,
                  (index) => TopicList(
                    tab: tabLists[index]['tab'],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  /// 顶部appbar title
  Widget homeAppBarTitle(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).primaryColor.withOpacity(1),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        tabs: List.generate(
          tabLists.length,
          (index) => Tab(
            text: tabLists[index]['name'],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
