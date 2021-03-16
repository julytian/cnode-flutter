import 'package:cnode_flutter2/config/net/http.dart';
import 'package:cnode_flutter2/models/topic_collect_model.dart';
import 'package:cnode_flutter2/models/user_model.dart';

class UserRepository {
  /// 获取用户accesstoken
  static Future<UserModel> apiGetAccessToken(String accesstoken) async {
    var response = await http.post(
      '/accesstoken',
      data: {
        'accesstoken': accesstoken,
      },
    );
    var user = await apiGetUserInfo(response.data['loginname']);
    user['id'] = response.data['id'];
    user['accesstoken'] = accesstoken;
    return UserModel.fromJson(user);
  }

  /// 获取用户信息
  static Future apiGetUserInfo(String loginname) async {
    var response = await http.get('/user/$loginname');
    return response.data;
  }

  /// 获取用户所收藏的主题
  static Future apiGetTopicCollect(String loginname) async {
    var response = await http.get('/topic_collect/$loginname');
    return response.data
        .map<TopicCollectModel>((item) => TopicCollectModel.fromJson(item))
        .toList();
  }
}
