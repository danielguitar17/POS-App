import 'package:fluent_ui/fluent_ui.dart';
import 'package:gym_app/models/customer.dart';
import 'package:gym_app/providers/db_provider.dart';

class CustomerProvider extends ChangeNotifier {
  bool _isloading = false;
  List<Customer> _filteredCustomers = [];
  bool get isloading => _isloading;
  List<Customer> _customers = [];

  set filteredCustomers(List<Customer> value) {
    _filteredCustomers = value;
    notifyListeners();
  }

  List<Customer> get filteredCustomers => _filteredCustomers;

  CustomerProvider() {
    fetchCustomers();
  }

  set isloading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  Customer customer = Customer(
      name: '',
      secondName: '',
      email: '',
      phone: '',
      city: 'Santa Ana',
      registrationDate: DateTime.now(),
      idCard: '');

  List<Customer> get customers => _customers;

  set customers(List<Customer> list) {
    _customers = list;
    notifyListeners();
  }

  void updateNewCustomer(Customer value) {
    customer = value;
    notifyListeners();
  }

  Future<void> addCustomer() async {
    await DBProvider.db.insertCustomer(customer);
    await fetchCustomers(); // Refresca la lista después de guardar
  }

  Future<void> fetchCustomers() async {
    _isloading = true;
    _customers = await DBProvider.db.getCustomers();
    Future.delayed(const Duration(seconds: 2));
    _filteredCustomers = _customers;
    _isloading = false;
    notifyListeners();
  }

  /// Elimina un cliente por ID y actualiza la lista
  Future<void> deleteCustomer(int id) async {
    try {
      await DBProvider.db.deleteCustomer(id);
      await fetchCustomers(); // Refresca la lista
    } catch (e) {
      debugPrint('Error deleting customer: $e');
    }
  }

  /// Actualiza los datos de un cliente existente
  Future<void> updateCustomer(Customer updatedCustomer) async {
    try {
      await DBProvider.db.updateCustomer(updatedCustomer);
      await fetchCustomers(); // Refresca la lista
    } catch (e) {
      debugPrint('Error updating customer: $e');
    }
  }

  //Busca clientes por nombre
  void searchCustomers(String query) {
    if (query.isEmpty) {
      filteredCustomers = _customers;
    } else {
      filteredCustomers = _customers
          .where((customer) =>
              customer.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
