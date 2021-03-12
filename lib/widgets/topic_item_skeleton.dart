import 'package:cnode_flutter2/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class TopicItemSkeleton extends StatelessWidget {
  final int index;

  const TopicItemSkeleton({
    Key key,
    this.index = 0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BottomBorderDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 20,
                width: 30,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 20,
                  width: 100,
                  decoration: SkeletonDecoration(isDark: isDark),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 30,
                    width: 30,
                    decoration:
                        SkeletonDecoration(isCircle: true, isDark: isDark),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 100,
                              decoration: SkeletonDecoration(isDark: isDark),
                            ),
                            Spacer(),
                            Container(
                              height: 10,
                              width: 50,
                              decoration: SkeletonDecoration(isDark: isDark),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 100,
                              decoration: SkeletonDecoration(isDark: isDark),
                            ),
                            Spacer(),
                            Container(
                              height: 10,
                              width: 50,
                              decoration: SkeletonDecoration(isDark: isDark),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
