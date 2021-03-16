import 'package:cnode_flutter2/config/net/http.dart';
import 'package:cnode_flutter2/models/message_model.dart';
import 'package:cnode_flutter2/utils/get_access_token.dart';

class MessageRepository {
  /// 获取用户所收藏的主题
  static Future apiGetMessages() async {
    var response = await http.get(
      '/messages',
      queryParameters: {
        'mdrender': false,
        'accesstoken': getStorageAccessToken(),
      },
    );
    return MessageModel.fromJson(response.data);
  }
}