import 'package:cnode_flutter2/models/topic_detail_model.dart';
import 'package:cnode_flutter2/providers/view_state_model.dart';
import 'package:cnode_flutter2/services/topic_repository.dart';
import 'package:oktoast/oktoast.dart';

class TopicDetailViewModel extends ViewStateModel {
  TopicDetailModel topicDetail;

  /// 第一次进入页面loading skeleton
  initData(id, {bool mdrender = false, bool isInit = true}) async {
    if (isInit) {
      setBusy();
    }
    try {
      topicDetail = await TopicRepository.apiGetTopicDetail(
        id,
        mdrender: mdrender,
      );
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  /// 收藏|取消收藏话题
  handleTopicCollect(String id, bool isCollect) async {
    var res = await TopicRepository.apiHandleTopicCollect(id, isCollect);
    if (res['success']) {
      showToast(isCollect ? '取消收藏成功' : '收藏成功');
      initData(id, isInit: false);
    }
  }

  /// 评论点赞
  handleReplyUps(String id, String topicId) async {
    var res = await TopicRepository.apiHandleReplyUps(id);
    if (res['success']) {
      showToast(res['action'] == 'down' ? '取消点赞成功' : '点赞成功');
      initData(topicId, isInit: false);
    } else {
      showToast('点赞失败');
    }
  }
}
