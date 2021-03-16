
import 'package:cnode_flutter2/config/color_manager.dart';
import 'package:cnode_flutter2/config/router_manager.dart';
import 'package:cnode_flutter2/models/topic_collect_model.dart';
import 'package:cnode_flutter2/utils/util.dart';
import 'package:cnode_flutter2/widgets/common_image.dart';
import 'package:flutter/material.dart';

class CollectItem extends StatelessWidget {
  final TopicCollectModel collectItem;

  const CollectItem(this.collectItem, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteName.detail,
            arguments: {'id': collectItem.id, 'title': collectItem.title});
      },
      child: Padding(
        padding: EdgeInsets.all(15),
        child: IntrinsicHeight(
          child: Row(
            children: [
              ClipOval(
                child: CommonImage(
                  url: collectItem.author.avatarUrl,
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      collectItem.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ColorManager.color31,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          collectItem.author.loginname,
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorManager.color31,
                          ),
                        ),
                        Text(
                          Utils.getTimeInfo(collectItem.createAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorManager.color01,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
