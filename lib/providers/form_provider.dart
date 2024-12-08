import 'package:fluent_ui/fluent_ui.dart';

class FormProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>(); // Controla el estado del formulario

  // Método para validar el formulario
  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    }
    notifyListeners();
    return false;
  }
}
