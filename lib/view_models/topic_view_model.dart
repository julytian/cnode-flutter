import 'package:cnode_flutter2/models/topic_model.dart';
import 'package:cnode_flutter2/providers/view_state_refresh_list_model.dart';
import 'package:cnode_flutter2/services/topic_repository.dart';

class TopicViewModel extends ViewStateRefreshListModel {
  final String tab;

  TopicViewModel(this.tab);

  @override
  Future<List<TopicModel>> loadData({int pageNum}) async {
    return await TopicRepository.apiGetTopics(page: pageNum, tab: tab);
  }
}
