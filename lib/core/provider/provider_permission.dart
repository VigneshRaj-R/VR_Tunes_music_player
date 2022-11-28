import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionProvider extends ChangeNotifier {
  void requestPermission() async {
    await Permission.storage.request();
    notifyListeners();
  }
  
}
