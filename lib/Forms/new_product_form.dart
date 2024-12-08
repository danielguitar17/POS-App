import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:gym_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

Future<Object?> newProductForm(BuildContext context) {
  final formProvider = Provider.of<FormProvider>(context, listen: false);
  final productPovider = Provider.of<ProductsProvider>(context, listen: false);

  Size size = MediaQuery.of(context).size;
  return showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: Column(
            children: [
              Row(
                children: [
                  const Icon(FluentIcons.contact),
                  const SizedBox(width: 10),
                  const Text('Nuevo Producto'),
                  const Spacer(),
                  IconButton(
                      icon: const Icon(FluentIcons.back, size: 20),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
              Divider()
            ],
          ),
          actions: [
            FilledButton(
                child: const Text(
                  'Guardar',
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
          content: SingleChildScrollView(
            child: Form(
                child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
                //NOMBRE DEL PRODUCTO
                InfoLabel(label: 'Nombre', child: TextFormBox()),
                InfoLabel(label: 'Codigo', child: TextFormBox()),
                InfoLabel(
                    label: 'Cantidad a ingresar',
                    child: TextFormBox(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9.]')) // Para números y punto decimal
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InfoLabel(
                      label: 'Unidad de compra',
                      child: SizedBox(
                        width: 100,
                        child: DropDownButton(title: Text("Unidades"), items: [
                          MenuFlyoutItem(
                              text: Text("Unidades"), onPressed: () {})
                        ]),
                      ),
                    ),
                    InfoLabel(
                      label: 'Unidad de venta',
                      child: SizedBox(
                        width: 100,
                        child: DropDownButton(
                            title: const Text("Unidades"),
                            items: [
                              MenuFlyoutItem(
                                  text: const Text("Unidades"),
                                  onPressed: () {})
                            ]),
                      ),
                    )
                  ],
                ),
                InfoLabel(
                  label: 'Precio de compra',
                  child: TextBoxMoney(
                      funcion: (value) {},
                      etiqueta: 'Precio de Compra',
                      icono: FluentIcons.money),
                ),
                InfoLabel(
                  label: 'Precio de Venta',
                  child: TextBoxMoney(
                      funcion: (value) {},
                      etiqueta: 'Precio de venta',
                      icono: FluentIcons.money),
                ),
                Consumer<ProductsProvider>(
                  builder: (context, value, child) {
                    return ToggleSwitch(
                      checked: productPovider.isHigher,
                      onChanged: (value) {
                        productPovider.toggleActive();
                        print(productPovider.isHigher);
                      },
                      content: const Text('Vender este producto al mayor'),
                    );
                  },
                )
              ],
            )),
          ),
        );
      });
}
