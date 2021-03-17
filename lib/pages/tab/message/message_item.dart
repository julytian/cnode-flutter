import 'package:cnode_flutter2/config/router_manager.dart';
import 'package:cnode_flutter2/models/message_model.dart';
import 'package:cnode_flutter2/utils/util.dart';
import 'package:cnode_flutter2/widgets/common_image.dart';
import 'package:cnode_flutter2/widgets/common_markdown.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final Message message;

  MessageItem(this.message);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteName.detail,
            arguments: {'id': message.topic.id, 'title': message.topic.title});
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: CommonImage(
                    url: message.author.avatarUrl,
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${message.author.loginname}在回复中@了您',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      '${Utils.getTimeInfo(message.createAt)}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            CommonMarkdown(message.reply.content),
            SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).textTheme.caption.color.withOpacity(0.06),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Wrap(
                children: <Widget>[
                  Text(
                    '话题: ${message.topic.title}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
