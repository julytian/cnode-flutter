import 'package:cnode_flutter2/config/net/http.dart';
import 'package:cnode_flutter2/models/topic_detail_model.dart';
import 'package:cnode_flutter2/models/topic_model.dart';
import 'package:cnode_flutter2/utils/get_access_token.dart';

class TopicRepository {
  /// 获取主题列表
  static Future<List<TopicModel>> apiGetTopics({
    int page,
    String tab,
  }) async {
    var response = await http.get(
      '/topics',
      queryParameters: {
        'page': page,
        'tab': tab,
        'limit': 20,
        'mdrender': false,
      },
    );
    return response.data
        .map<TopicModel>((item) => TopicModel.fromJson(item))
        .toList();
  }

  /// 获取主题详情
  static Future<TopicDetailModel> apiGetTopicDetail(
    String id, {
    bool mdrender = false,
  }) async {
    var response = await http.get(
      '/topic/$id',
      queryParameters: {
        'mdrender': mdrender,
        'accesstoken': getStorageAccessToken(),
      },
    );
    return TopicDetailModel.fromJson(response.data);
  }

  /// 收藏|取消收藏话题
  static Future apiHandleTopicCollect(
    String id,
    bool isCollect,
  ) async {
    String url =
        isCollect ? '/topic_collect/de_collect' : '/topic_collect/collect';
    var response = await http.post(
      url,
      data: {
        'accesstoken': getStorageAccessToken(),
        'topic_id': id,
      },
    );
    return response.data;
  }

  /// 为评论点赞
  static Future apiHandleReplyUps(String id) async {
    var response = await http.post(
      '/reply/$id/ups',
      data: {
        'accesstoken': getStorageAccessToken(),
      },
    );
    return response.data;
  }
}
