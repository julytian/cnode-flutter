import 'package:cnode_flutter2/providers/view_state_list_model.dart';
import 'package:cnode_flutter2/services/user_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicCollectViewModel extends ViewStateListModel {
  final String loginname;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  TopicCollectViewModel(this.loginname);
  @override
  Future<List> loadData() async {
    return await UserRepository.apiGetTopicCollect(loginname);
  }

  /// 下拉刷新
  ///
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  Future<List> refresh({bool init = false}) async {
    try {
      var data = await loadData();
      if (data.isEmpty) {
        refreshController.refreshCompleted(resetFooterState: true);
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        refreshController.refreshCompleted();
        setIdle();
      }
      return data;
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (init) list.clear();
      refreshController.refreshFailed();
      setError(e, s);
      return null;
    }
  }
}
