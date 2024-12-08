class Customer {
  int? id;
  String idCard;
  String name;
  String secondName;
  String email;
  String phone;
  String city;
  String? image;
  DateTime registrationDate;
  String? notes;
  // Cedula (ID card or identification number)

  Customer({
    this.id,
    required this.name,
    required this.secondName,
    required this.email,
    required this.phone,
    required this.city,
    this.image,
    required this.registrationDate,
    this.notes,
    required this.idCard, // Cedula
  });

  // Convert Customer instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id_card': idCard,
      'name': name,
      'second_name': secondName,
      'email': email,
      'phone': phone,
      'city': city,
      'image': image,
      'register_date': registrationDate.toIso8601String(),
      'notes': notes,
    };
  }

  // Create a Customer instance from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      idCard: json['id_card'], // Parsing idCard from JSON
      name: json['name'],
      secondName: json['second_name'],
      email: json['email'],
      phone: json['phone'],
      city: json['city'],
      image: json['image'],
      registrationDate: DateTime.parse(json['register_date']),
      notes: json['notes'],
    );
  }
}
