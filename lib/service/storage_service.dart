import 'package:get_storage/get_storage.dart';
import 'package:threads_clone/utils/storage_key.dart';

class StorageService {
  static final session = GetStorage();

  //?? checking if user has logged in or not ->
  static dynamic userSession = session.read(StorageKey.userSession);
}
