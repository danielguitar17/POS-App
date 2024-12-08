import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';

class TouchLikeScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return BouncingScrollPhysics(); // Permite rebote
  }

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    // Elimina decoraciones predeterminadas como barras de desplazamiento
    return child;
  }

  @override
  Set<PointerDeviceKind> get dragDevices {
    // Habilita el desplazamiento para dispositivos táctiles y de mouse
    return {
      PointerDeviceKind.trackpad,
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse, // Simula gestos táctiles con el mouse
    };
  }
}
