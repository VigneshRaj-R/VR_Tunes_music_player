import 'package:flutter/cupertino.dart';
import 'package:music_player_app/ui/widgets/songstorage.dart';

class ProviderNowplaying extends ChangeNotifier {
  int currentindex = 0;

  mountedfunc() {
    Songstorage.player.currentIndexStream.listen((index) {
      if (index != null) {
        notifyListeners();
        currentindex = index;
        Songstorage.currentIndexx = index;
      }
      notifyListeners();
    });
    notifyListeners();
  }


}
