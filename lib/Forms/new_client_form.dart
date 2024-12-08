import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:gym_app/providers/customer_provider.dart';
import 'package:gym_app/providers/providers.dart';
import 'package:gym_app/widgets/notifications_widget.dart';
import 'package:provider/provider.dart';

Future<Object?> newClient(BuildContext context) {
  final formProvider = Provider.of<FormProvider>(context, listen: false);
  final customerProvider =
      Provider.of<CustomerProvider>(context, listen: false);

  Size size = MediaQuery.of(context).size;
  return showDialog(
      context: context,
      builder: (context) {
        return ContentDialog(
          //constraints: BoxConstraints(maxWidth: size.width * 0.6),
          title: Column(
            children: [
              Row(
                children: [
                  const Icon(FluentIcons.contact),
                  const SizedBox(width: 10),
                  const Text('Nuevo Cliente'),
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
          content: FormClient(size: size),
          actions: [
            FilledButton(
                child: const Text(
                  'Guardar',
                ),
                onPressed: () {
                  if (formProvider.validateForm()) {
                    customerProvider.addCustomer();
                    displaySucces(context, 'Guardado correctamente');
                    Navigator.pop(context);
                  }
                }),
          ],
        );
      });
}

class FormClient extends StatefulWidget {
  FormClient({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<FormClient> createState() => _FormClientState();
}

class _FormClientState extends State<FormClient> {
  List<String> sites = ['Santa Ana', 'Veracruz', 'Quebradita', 'San Joaquin'];

  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<CustomerProvider>(context).customer;
    final formProvider = Provider.of<FormProvider>(context);
    return SizedBox(
        child: SingleChildScrollView(
      child: Form(
        key: formProvider.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                child: Icon(FluentIcons.contact, size: 50),
              ),
            ),
            const Divider(),
            //CEDULA DE IDENTIDAD
            Row(
              children: [
                SizedBox(
                  width: widget.size.width * 0.1,
                  child: InfoLabel(
                      label: 'Cédula',
                      child: TextFormBox(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == "") {
                            return 'Ingresa este dato';
                          }
                        },
                        onChanged: (value) {
                          customer.idCard = value;
                        },
                      )),
                ),
                const Spacer(),
                SizedBox(
                    width: widget.size.width * 0.1,
                    child: InfoLabel(
                      label: 'Dirección',
                      child: DropDownButton(
                          title: Text(customer.city),
                          items: List.generate(
                              sites.length,
                              (index) => MenuFlyoutItem(
                                  text: Text(sites[index]),
                                  onPressed: () {
                                    customer.city = sites[index];
                                    setState(() {});
                                  }))),
                    )),
              ],
            ),

            Row(
              children: [
                SizedBox(
                    width: widget.size.width * 0.1,
                    child: InfoLabel(
                        label: 'Nombre',
                        child: TextFormBox(
                          onChanged: (value) {
                            if (value != "") {
                              customer.name = value.uppercaseFirst();
                            }
                          },
                          validator: (value) {
                            if (value == "") {
                              return 'Ingresa este dato';
                            }
                          },
                        ))),
                const Spacer(),
                SizedBox(
                    width: widget.size.width * 0.1,
                    child: InfoLabel(
                        label: 'Apellido',
                        child: TextFormBox(
                          onChanged: (value) {
                            if (value != "") {
                              customer.secondName = value.uppercaseFirst();
                            }
                          },
                          validator: (value) {
                            if (value == "") {
                              return 'Ingresa este dato';
                            }
                          },
                        ))),
              ],
            ),
            Row(
              children: [
                SizedBox(
                    width: widget.size.width * 0.13,
                    child: InfoLabel(
                        label: 'Correo',
                        child: TextFormBox(
                          onChanged: (value) {
                            customer.email = value;
                          },
                          validator: (value) {
                            if (value == "") {
                              return 'Ingresa este dato';
                            }
                          },
                        ))),
                const Spacer(),
                SizedBox(
                    width: widget.size.width * 0.1,
                    child: InfoLabel(
                        label: 'Teléfono',
                        child: TextFormBox(
                          maxLength: 11,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            customer.phone = value;
                          },
                          validator: (value) {
                            if (value == "") {
                              return 'Ingresa este dato';
                            }
                          },
                        ))),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
