class Emp {
  final int? id;
  final String name;
  final int age;
  final String email;
  final String phone;
  final String address;
  final double weight;
  final double height;

  Emp({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.phone,
    required this.address,
    required this.weight,
    required this.height,
  });

  factory Emp.fromJson(Map<String, dynamic> json) {
    return Emp(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      weight:
          json['weight'] is int ? json['weight'].toDouble() : json['weight'],
      height:
          json['height'] is int ? json['height'].toDouble() : json['height'],
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
      'weight': weight,
      'height': height,
    };
  }

  @override
  String toString() {
    return 'Emp{id: $id, name: $name, age: $age, email: $email, phone: $phone, address: $address, weight: $weight, height: $height}';
  }
}
