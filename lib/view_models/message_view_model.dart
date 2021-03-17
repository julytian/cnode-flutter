import 'package:cnode_flutter2/models/message_model.dart';
import 'package:cnode_flutter2/providers/view_state_model.dart';
import 'package:cnode_flutter2/services/message_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageViewModel extends ViewStateModel {
  MessageModel messages;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;

  initData({bool init = true}) async {
    if (init) {
      setBusy();
    }
    try {
      MessageModel data = await MessageRepository.apiGetMessages();
      if (data == null) {
        refreshController.refreshCompleted(resetFooterState: true);
        setEmpty();
      } else {
        messages = data;
        refreshController.refreshCompleted();
        setIdle();
      }
      setIdle();
    } catch (e, s) {
      refreshController.refreshFailed();
      setError(e, s);
    }
  }

  refresh() {
    return initData(init: false);
  }
}
