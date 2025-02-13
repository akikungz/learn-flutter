class Emp {
  final int? id;
  final String name;
  final int age;
  final String email;
  final String phone;
  final String address;

  Emp({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory Emp.fromJson(Map<String, dynamic> json) {
    return Emp(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'Emp{id: $id, name: $name, age: $age, email: $email, phone: $phone, address: $address}';
  }
}
