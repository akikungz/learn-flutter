class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final double? weight;
  final double? height;
  final String? createdAt;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.weight,
    required this.height,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'weight': weight,
      'height': height,
      'created_at': createdAt,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password, weight: $weight, height: $height, created_at: $createdAt}';
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      weight: map['weight'],
      height: map['height'],
      createdAt: map['created_at'],
    );
  }
}
