import 'package:fluent_ui/fluent_ui.dart';

class Product {
  int? id;
  String code;
  String name;
  String? image;
  double? minHigher;
  String purchasingUnit;
  String salesUnit;
  double stock;
  DateTime registerDate;
  double purchasePrice;
  double salePrice;
  String category;
  double? higherPrice;

  Product(
      {this.id,
      this.image,
      this.higherPrice,
      required this.code,
      required this.name,
      required this.purchasingUnit,
      required this.salesUnit,
      required this.stock,
      required this.registerDate,
      required this.purchasePrice,
      required this.salePrice,
      required this.category});

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $salePrice, higherPrice: $higherPrice, stock: $stock, purchasePrice: $purchasePrice, category: $category}';
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      name: json["name"],
      code: json["code"],
      purchasingUnit: json["purchasing_unit"],
      salesUnit: json["sales_unit"],
      stock: json["stock"],
      registerDate: DateTime.parse(json["register_date"]),
      purchasePrice: json["purchase_price"],
      salePrice: json["sale_price"],
      higherPrice: json["higher_price"],
      category: json["category"],
      image: json["image"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "name": name.toLowerCase().uppercaseFirst(),
        "code": code,
        "purchasing_unit": purchasingUnit,
        "sales_unit": salesUnit,
        "stock": stock,
        "register_date": registerDate.toIso8601String(),
        "purchase_price": purchasePrice,
        "sale_price": salePrice,
        "higher_price": higherPrice,
        "category": category,
        "image": image
      };
}
