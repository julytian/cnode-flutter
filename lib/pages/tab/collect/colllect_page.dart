import 'package:cnode_flutter2/config/color_manager.dart';
import 'package:cnode_flutter2/models/topic_collect_model.dart';
import 'package:cnode_flutter2/pages/tab/collect/collect_item.dart';
import 'package:cnode_flutter2/providers/provider_widget.dart';
import 'package:cnode_flutter2/view_models/topic_collect_view_model.dart';
import 'package:cnode_flutter2/view_models/user_view_model.dart';
import 'package:cnode_flutter2/widgets/skeleton.dart';
import 'package:cnode_flutter2/widgets/topic_item_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CollectPage extends StatefulWidget {
  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收藏'),
      ),
      body: SafeArea(
        child: topicCollectBody(),
      ),
    );
  }

  Widget topicCollectBody() {
    String loginname =
        Provider.of<UserViewModel>(context, listen: true).user.loginname;
    return ProviderWidget<TopicCollectViewModel>(
      model: TopicCollectViewModel(loginname),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isBusy) {
          return SingleChildScrollView(
            child: SkeletonList(
              length: 20,
              builder: (context, index) => TopicItemSkeleton(),
            ),
          );
        }
        return SmartRefresher(
          controller: model.refreshController,
          header: WaterDropHeader(),
          onRefresh: model.refresh,
          enablePullUp: false,
          child: ListView.separated(
            itemCount: model.list.length,
            itemBuilder: (context, index) {
              TopicCollectModel collectItem = model.list[index];
              return CollectItem(collectItem);
            },
            //分割器构造器
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: ColorManager.colordb,
                height: 0.3,
              );
            },
          ),
        );
      },
    );
  }
}
