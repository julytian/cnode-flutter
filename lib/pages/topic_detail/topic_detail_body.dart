import 'package:cnode_flutter2/config/color_manager.dart';
import 'package:cnode_flutter2/models/topic_detail_model.dart';
import 'package:cnode_flutter2/pages/topic_detail/topic_repies.dart';
import 'package:cnode_flutter2/providers/view_state_widget.dart';
import 'package:cnode_flutter2/utils/util.dart';
import 'package:cnode_flutter2/view_models/topic_detail_view_model.dart';
import 'package:cnode_flutter2/widgets/common_image.dart';
import 'package:cnode_flutter2/widgets/common_markdown.dart';
import 'package:flutter/material.dart';

class TopicDetailBody extends StatelessWidget {
  final TopicDetailViewModel model;
  final ScrollController controller;

  const TopicDetailBody({Key key, this.model, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.isBusy) {
      return ViewStateBusyWidget();
    }
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                topicTitle(context, model.topicDetail),
                topicInfo(context, model.topicDetail),
                Container(
                  alignment: Alignment.centerLeft,
                  child: CommonMarkdown(model.topicDetail.content),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: TopicRepies(model.topicDetail),
          ),
        ],
      ),
    );
  }

  /// 主题详情信息
  Widget topicInfo(BuildContext context, TopicDetailModel topic) {
    TextStyle _textStyle = Theme.of(context).textTheme.caption;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          ClipOval(
            child: CommonImage(
              url: topic.author.avatarUrl,
              width: 40,
              height: 40,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  topic.author.loginname,
                  style: _textStyle.copyWith(fontSize: 14),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '发布于: ${Utils.getTimeInfo(topic.createAt)}',
                  style: _textStyle,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  decoration: BoxDecoration(
                    color: Utils.getTabInfo(
                        topic.tab, topic.good, topic.top, true),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    Utils.getTabInfo(topic.tab, topic.good, topic.top, false),
                    style: _textStyle.copyWith(color: ColorManager.colorff),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '${topic.visitCount}次浏览',
                  style: _textStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 主题标题
  Widget topicTitle(BuildContext context, TopicDetailModel topic) {
    return Container(
      alignment: Alignment.centerLeft, // 有alignment就会自动撑满
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.caption.color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        topic.title,
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 18),
      ),
    );
  }
}
