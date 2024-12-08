import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_app/Forms/new_product_form.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Column(
        children: [
          PageHeader(
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(FluentIcons.contact),
                      SizedBox(width: 10),
                      Text('Inventario'),
                    ],
                  ),
                  Text('Lista de los productos que tienes disponible',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                  SizedBox(height: 10),
                ],
              ),
              commandBar: CommandBar(
                mainAxisAlignment: MainAxisAlignment.end,
                primaryItems: [
                  CommandBarButton(
                      icon: const Icon(FluentIcons.add_to),
                      label: const Text('Nuevo Producto'),
                      onPressed: () {
                        newProductForm(context);
                      }),
                  const CommandBarSeparator(),
                ],
              )),
          const Divider()
        ],
      ),
    );
  }
}
