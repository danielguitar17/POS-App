import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_app/screens/screens.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: _selected,
        items: [
          PaneItem(
              title: const Text('Clientes'),
              icon: const Icon(FluentIcons.user_event),
              body: const ClientsScreen()),
          PaneItem(
              title: const Text('Inventario'),
              icon: const Icon(FluentIcons.product_list),
              body: const InventoryScreen()),
          PaneItem(
              title: const Text('Asistencias'),
              icon: const Icon(FluentIcons.user_event),
              body: const SizedBox.expand())
        ],
        onChanged: (value) {
          setState(() {
            _selected = value;
          });
        },
      ),
    );
  }
}
