import 'package:cnode_flutter2/config/storage_manager.dart';
import 'package:cnode_flutter2/providers/view_state_model.dart';
import 'package:cnode_flutter2/services/user_repository.dart';
import 'package:cnode_flutter2/view_models/user_view_model.dart';

const String kLoginName = 'kLoginName';
const String kAccessToken = 'kAccessToken';

class LoginViewModel extends ViewStateModel {
  final UserViewModel userViewModel;

  LoginViewModel(this.userViewModel) : assert(userViewModel != null);
  String getLoginName() {
    return StorageManager.sharedPreferences.getString(kLoginName);
  }

  Future<bool> login(String accessToken) async {
    setBusy();
    try {
      var user = await UserRepository.apiGetAccessToken(accessToken);
      userViewModel.saveUser(user);
      await StorageManager.sharedPreferences
          .setString(kLoginName, userViewModel.user.loginname);
      await StorageManager.sharedPreferences
          .setString(kAccessToken, userViewModel.user.accesstoken);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> logout() async {
    //防止递归
    if (!userViewModel.hasUser) {
      return false;
    }
    setBusy();
    try {
      userViewModel.clearUser();
      await StorageManager.sharedPreferences.remove(kAccessToken);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}
