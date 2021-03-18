import 'package:cnode_flutter2/pages/tab/message/message_item.dart';
import 'package:cnode_flutter2/providers/provider_widget.dart';
import 'package:cnode_flutter2/providers/view_state_widget.dart';
import 'package:cnode_flutter2/view_models/message_view_model.dart';
import 'package:cnode_flutter2/widgets/skeleton.dart';
import 'package:cnode_flutter2/widgets/topic_item_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController controller;
  List<Tab> tabs = [
    Tab(
      text: '未读消息',
    ),
    Tab(
      text: '已读消息',
    ),
  ];
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          color: Theme.of(context).primaryColor.withOpacity(1),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: tabs,
            controller: controller,
          ),
        ),
      ),
      body: messagesBody(),
    );
  }

  Widget messagesBody() {
    return ProviderWidget<MessageViewModel>(
      model: MessageViewModel(),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return SingleChildScrollView(
            child: SkeletonList(
              length: 20,
              builder: (context, index) => TopicItemSkeleton(),
            ),
          );
        } else if (model.isEmpty) {
          return ViewStateEmptyWidget(onPressed: model.initData);
        }
        return TabBarView(
          controller: controller,
          children: [
            messageItem(model, model.messages.hasNotReadMessages),
            messageItem(model, model.messages.hasReadMessages),
          ],
        );
      },
    );
  }

  Widget messageItem(MessageViewModel model, List messages) {
    int count = messages.length;
    return count > 0
        ? SmartRefresher(
            controller: model.refreshController,
            header: WaterDropHeader(),
            onRefresh: model.refresh,
            enablePullUp: false,
            enablePullDown: true,
            child: ListView.separated(
              itemBuilder: (context, index) => MessageItem(messages[index]),
              separatorBuilder: (context, int) => Divider(
                height: 0.7,
              ),
              itemCount: count,
            ),
          )
        : Center(
            child: Text('暂无消息'),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
