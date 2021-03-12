import 'package:cnode_flutter2/config/storage_manager.dart';
const String kAccessToken = 'kAccessToken';

getStorageAccessToken() {
  return StorageManager.sharedPreferences.getString(kAccessToken);
}