import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_app/providers/customer_provider.dart';
import 'package:gym_app/screens/navigation_screen.dart';
import 'package:gym_app/theme/theme.dart';
import 'package:gym_app/utils/scroll_config.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:provider/provider.dart';
import 'providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await windowManager.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
  }
  await DBProvider.db.initDB();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductsProvider()),
    ChangeNotifierProvider(create: (_) => CustomerProvider()),
    ChangeNotifierProvider(create: (_) => FormProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      scrollBehavior: TouchLikeScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Gym App',
      theme: darkTheme,
      home: const NavigationScreen(),
    );
  }
}



//  FluentThemeData(
//         scaffoldBackgroundColor: Color.fromARGB(255, 223, 229, 235),
//         accentColor: AccentColor.swatch(
//           const {
//             'normal': Color(0xFF0078D7), // Color principal (azul)
//             'darker': Color(0xFF005A9E), // Más oscuro
//             'lighter': Color(0xFF8AC9FF), // Más claro
//             'lightest': Color(0xFFD6EBFF), // Muy claro
//             'darkest': Color(0xFF00335A), // Muy oscuro
//           },
//         ),
//         brightness: Brightness.light,
//       ),