import 'package:fluent_ui/fluent_ui.dart';

class ProductsProvider extends ChangeNotifier {
  bool _isHigher = false;

  void toggleActive() {
    _isHigher = !_isHigher;

    notifyListeners();
  }

  bool get isHigher => _isHigher;
}
