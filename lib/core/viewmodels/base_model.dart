import 'package:artificial_lung/core/enums/enums.dart';
import 'package:flutter/foundation.dart';

class BaseModel extends ChangeNotifier {
  
  ViewState _viewState = ViewState.Idle;
  ViewState get viewState => _viewState;

  void setState(viewState) {
    _viewState = viewState;
    notifyListeners();
  }
}