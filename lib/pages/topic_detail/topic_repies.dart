import 'package:cnode_flutter2/config/color_manager.dart';
import 'package:cnode_flutter2/models/topic_detail_model.dart';
import 'package:cnode_flutter2/utils/util.dart';
import 'package:cnode_flutter2/widgets/common_image.dart';
import 'package:cnode_flutter2/widgets/common_markdown.dart';
import 'package:flutter/material.dart';

class TopicRepies extends StatefulWidget {
  final TopicDetailModel topic;

  const TopicRepies(this.topic, {Key key}) : super(key: key);
  @override
  _TopicRepiesState createState() => _TopicRepiesState();
}

class _TopicRepiesState extends State<TopicRepies> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        replyTitle(),
        Column(
          children: widget.topic.replies.map((i) => replyItem(i)).toList(),
        ),
      ],
    );
  }

  Widget replyItem(Reply reply) {
    var author = reply.author;
    TextStyle _textStyle = Theme.of(context).textTheme.caption.copyWith(fontSize: 14);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: Divider.createBorderSide(context, width: 0.7),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                ClipOval(
                  child: CommonImage(
                    url: author.avatarUrl,
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text: '${author.loginname}',
                        style: _textStyle,
                        children: <TextSpan>[
                          TextSpan(
                            text: ' 发布于: ${Utils.getTimeInfo(reply.createAt)}',
                            style: _textStyle,
                          ),
                        ]),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 2),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () async {},
                        color: Theme.of(context).textTheme.caption.color,
                        icon: Icon(
                          Icons.thumb_up_alt_sharp,
                          size: 16,
                        ),
                      ),
                      Text(
                        '${reply.ups.length}',
                        style: _textStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: 10,
              left: 15,
              right: 15,
            ),
            alignment: Alignment.centerLeft,
            child: CommonMarkdown(reply.content),
          ),
        ],
      ),
    );
  }

  Widget replyTitle() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border(
          top: Divider.createBorderSide(context, width: 0.7),
        ),
      ),
      child: Row(
        children: <Widget>[
          Text(
            '${widget.topic.replyCount}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).accentColor,
              fontSize: 16,
            ),
          ),
          Text(
            ' 回复',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
