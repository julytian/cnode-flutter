import 'package:cnode_flutter2/config/router_manager.dart';
import 'package:cnode_flutter2/models/topic_model.dart';
import 'package:cnode_flutter2/utils/util.dart';
import 'package:cnode_flutter2/widgets/common_image.dart';
import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  final TopicModel topic;

  const TopicItem({Key key, this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(RouteName.detail,
              arguments: {'id': topic.id, 'title': topic.title});
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            border: Border(
              bottom: Divider.createBorderSide(context, width: 0.7),
            ),
          ),
          child: Column(
            children: [
              topicTitle(context),
              SizedBox(
                height: 5,
              ),
              topicContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget topicContent(context) {
    TextStyle _textStyle = Theme.of(context).textTheme.caption;
    return Row(
      children: [
        ClipOval(
          child: CommonImage(
            url: topic.author.avatarUrl,
            width: 35,
            height: 35,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${topic.author.loginname}',
                    style: _textStyle,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${topic.replyCount}',
                          style: _textStyle.copyWith(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        TextSpan(
                          text: ' / ${topic.visitCount}',
                          style: _textStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Utils.getTimeInfo(topic.createAt),
                    style: _textStyle,
                  ),
                  Text(
                    Utils.getTimeInfo(topic.lastReplyAt),
                    style: _textStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget topicTitle(context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: Utils.getTabInfo(topic.tab, topic.good, topic.top, true),
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Text(
            Utils.getTabInfo(topic.tab, topic.good, topic.top, false),
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            topic.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
      ],
    );
  }
}
