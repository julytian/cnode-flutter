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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteName.detail,
            arguments: {'id': message.topic.id, 'title': message.topic.title});
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(
        //       width: 0.3,
        //       color: Theme.of(context).dividerColor,
        //     ),
        //   ),
        // ),
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
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '${Utils.getTimeInfo(message.createAt)}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.caption.color,
                        fontSize: 12,
                      ),
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
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).textTheme.caption.color.withOpacity(0.08),
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
