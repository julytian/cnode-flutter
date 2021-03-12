import 'package:cnode_flutter2/models/topic_model.dart';
import 'package:cnode_flutter2/pages/tab/home/topic_item.dart';
import 'package:cnode_flutter2/providers/provider_widget.dart';
import 'package:cnode_flutter2/view_models/topic_view_model.dart';
import 'package:cnode_flutter2/widgets/skeleton.dart';
import 'package:cnode_flutter2/widgets/topic_item_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicList extends StatefulWidget {
  final String tab;

  const TopicList({Key key, this.tab}) : super(key: key);
  @override
  _TopicListState createState() => _TopicListState();
}

class _TopicListState extends State<TopicList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<TopicViewModel>(
      model: TopicViewModel(widget.tab),
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
          onLoading: model.loadMore,
          enablePullUp: true,
          child: ListView.builder(
            itemCount: model.list.length,
            itemBuilder: (context, index) {
              TopicModel topic = model.list[index];
              return TopicItem(topic: topic);
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
