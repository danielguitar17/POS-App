import 'package:animate_do/animate_do.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_app/Forms/new_client_form_edit.dart';
import 'package:gym_app/models/customer.dart';
import 'package:gym_app/models/models.dart';
import 'package:gym_app/providers/customer_provider.dart';
import 'package:gym_app/theme/colors.dart';
import 'package:gym_app/widgets/delete_confirmation.dart';
import 'package:gym_app/widgets/notifications_widget.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CustomerCard extends StatelessWidget {
  Customer customer;
  CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    final customerProvider = Provider.of<CustomerProvider>(context);
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            SizedBox(width: 100, child: Text('000${customer.id}')),
            SizedBox(
                width: 200,
                child: Row(children: [
                  const CircleAvatar(
                    child: Icon(FluentIcons.contact),
                  ),
                  const SizedBox(width: 10),
                  Text('${customer.name} ${customer.secondName}')
                ])),
            SizedBox(
                width: 200,
                child: Text(
                  customer.city,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                )),
            SizedBox(
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(FluentIcons.mail, size: 12),
                        SizedBox(width: 10),
                        Expanded(
                            child: Text(
                          customer.email,
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(FluentIcons.phone, size: 12),
                        const SizedBox(width: 10),
                        Text(
                          customer.phone,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                )),
            SizedBox(
                width: 100,
                child: Text(
                  DateFormat('dd/MM/yyyy').format(customer.registrationDate),
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                )),
            Spacer(),
            SizedBox(
                child: Row(
              children: [
                IconButton(
                    icon: Icon(FluentIcons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteConfirmationDialog(
                              content:
                                  "Seguro que quieres eliminar este elemento",
                              title: 'Confirmacion',
                              onConfirm: () {
                                customerProvider.deleteCustomer(customer.id!);
                                displaySucces(context, 'Elemento eliminado');
                                Navigator.pop(context);
                              },
                              onCancel: () {
                                Navigator.pop(context);
                              },
                            );
                          });
                    }),
                const SizedBox(width: 10),
                IconButton(
                    icon: Icon(FluentIcons.edit_contact),
                    onPressed: () {
                      newClientEdit(context, customer);
                    })
              ],
            ))
          ],
        ),
      ),
    );
  }
}
