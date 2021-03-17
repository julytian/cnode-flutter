import 'package:cnode_flutter2/config/color_manager.dart';
import 'package:cnode_flutter2/config/router_manager.dart';
import 'package:cnode_flutter2/pages/topic_detail/topic_detail_body.dart';
import 'package:cnode_flutter2/providers/provider_widget.dart';
import 'package:cnode_flutter2/utils/status_bar_utils.dart';
import 'package:cnode_flutter2/view_models/topic_detail_view_model.dart';
import 'package:cnode_flutter2/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class TopicDetailPage extends StatefulWidget {
  final String id;
  final String title;

  const TopicDetailPage(this.id, {Key key, this.title}) : super(key: key);

  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {
  ScrollController _scrollController = ScrollController();
  bool _showBacktop = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      if (offset < 200 && _showBacktop) {
        setState(() {
          _showBacktop = false;
        });
      } else if (offset >= 200 && _showBacktop == false) {
        setState(() {
          _showBacktop = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: StatusBarUtils.systemUiOverlayStyle(context),
      child: ProviderWidget<TopicDetailViewModel>(
        model: TopicDetailViewModel(),
        onModelReady: (model) => model.initData(widget.id),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: appBarTitle(),
              actions: [
                collectIcon(model),
              ],
            ),
            body: SafeArea(
              child: TopicDetailBody(
                model: model,
                controller: _scrollController,
              ),
            ),
            floatingActionButton: backtopButton(),
          );
        },
      ),
    );
  }

  Widget collectIcon(TopicDetailViewModel topicDetailModel) {
    return ProviderWidget<UserViewModel>(
      model: UserViewModel(),
      builder: (context,model,child) {
        var isCollect = topicDetailModel.topicDetail?.isCollect ?? false;
        var id = topicDetailModel.topicDetail?.id;
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: isCollect ? ColorManager.color01 : Colors.black,
          ),
          onPressed: () async {
            if (model.hasUser) {
              await topicDetailModel.handleTopicCollect(id, isCollect);
            } else {
              final isLogin =
                  await Navigator.of(context).pushNamed(RouteName.login);
              if (isLogin != null) {
                await topicDetailModel.initData(id, isInit: false);
              }
            }
          },
        );
      },
    );
  }

  /// 返回顶部按钮
  Widget backtopButton() {
    return _showBacktop
        ? FloatingActionButton(
            child: Icon(Icons.arrow_upward),
            onPressed: () {
              _scrollController.animateTo(
                0,
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              );
            },
          )
        : null;
  }

  /// 导航栏标题
  Widget appBarTitle() {
    return Text(
      widget.title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
