// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter/widgets.dart';
import 'package:gym_app/Forms/new_client_form.dart';
import 'package:gym_app/providers/customer_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadCustomers() async {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: false);
    await customerProvider.fetchCustomers();
  }

  @override
  Widget build(BuildContext context) {
    final customerProvider =
        Provider.of<CustomerProvider>(context, listen: true);
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
                      Text('Clientes'),
                    ],
                  ),
                  Text('Lista de tus clientes',
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
                      label: const Text('Nuevo Cliente'),
                      onPressed: () {
                        newClient(context);
                      }),
                  const CommandBarSeparator(),
                ],
              )),
          const Divider()
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: TextBox(
                    onChanged: (value) {
                      customerProvider.searchCustomers(value);
                    },
                    placeholder: 'Buscar',
                    suffix: Icon(FluentIcons.search, size: 10),
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre los TextBox
                const SizedBox(
                  width: 150,
                  child: TextBox(
                    placeholder: 'Buscar',
                  ),
                ),
                const SizedBox(width: 10),
                FilledButton(child: const Text('Reset'), onPressed: () {})
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Table(
                // Borde de la tabla
                columnWidths: const {
                  0: FixedColumnWidth(
                      100), // Ancho fijo para la primera columna
                  1: FixedColumnWidth(
                      200.0), // Ancho fijo para la segunda columna
                  2: FixedColumnWidth(200),
                  3: FixedColumnWidth(200),

                  4: FixedColumnWidth(100),
                },
                children: [
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('id',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.withOpacity(0.4))),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nombre',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Dirección',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('info',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Inicio',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  // Aquí puedes agregar más filas dinámicas con otro widget
                ],
              ),
            ),
            Expanded(
                child: SizedBox.expand(
              child: customerProvider.isloading
                  ? Center(child: ProgressBar())
                  : ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15),
                      itemCount: customerProvider.filteredCustomers.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomerCard(
                            customer:
                                customerProvider.filteredCustomers[index]);
                      }),
            ))
          ],
        ),
      ),
    );
  }
}
