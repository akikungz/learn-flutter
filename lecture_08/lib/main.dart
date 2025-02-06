import 'package:flutter/material.dart';
import 'package:lecture_08/database/main.dart';
import 'package:lecture_08/model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initDb();
  // await DatabaseHelper().initializeUsers();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: UserList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  void resetControllers() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _weightController.clear();
    _heightController.clear();
  }

  bool incorrectPassword(String inputPassword, String password) {
    if (inputPassword != password) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Password is incorrect.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

  void _addUser() async {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Add User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              TextField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetControllers();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_nameController.text.isNotEmpty &&
                    _emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _confirmPasswordController.text.isNotEmpty &&
                    _weightController.text.isNotEmpty &&
                    _heightController.text.isNotEmpty) {
                  if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Passwords do not match.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                  await DatabaseHelper().insert({
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'password': _passwordController.text,
                    'weight': double.parse(_weightController.text),
                    'height': double.parse(_heightController.text),
                  });
                  setState(() {
                    resetControllers();
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                          'Name, email, password, weight and height are required.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(User user) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Delete User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Please enter your password to confirm.'),
              TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: _passwordController,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (!incorrectPassword(
                  _passwordController.text,
                  user.password,
                )) {
                  return;
                }

                await DatabaseHelper().delete(user.id!);
                setState(() {
                  resetControllers();
                });
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _editUser(User user) async {
    _nameController.text = user.name;
    _emailController.text = user.email;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Old Password'),
                obscureText: true,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                resetControllers();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (_nameController.text.isNotEmpty &&
                    _emailController.text.isNotEmpty) {
                  if (!incorrectPassword(
                    _passwordController.text,
                    user.password,
                  )) {
                    return;
                  }

                  await DatabaseHelper().update({
                    'id': user.id,
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'password': _confirmPasswordController.text,
                  });
                  setState(() {
                    resetControllers();
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Name and email are required.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Edit'),
            ),
          ],
        );
      },
    );
  }

  double calculateBmi(double weight, double height) {
    double heightMeter = height / 100;
    return weight / (heightMeter * heightMeter);
  }

  String getBmiCategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              await DatabaseHelper().deleteAll();
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: DatabaseHelper().queryAll(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot,
        ) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                double bmi = calculateBmi(
                  snapshot.data![index]['weight'],
                  snapshot.data![index]['height'],
                );

                return ListTile(
                  title: Text(snapshot.data![index]['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data![index]['email']),
                      Text(snapshot.data![index]['password']),
                      Text(snapshot.data![index]['created_at'].toString()),
                      Text(snapshot.data![index]['weight'].toString()),
                      Text(snapshot.data![index]['height'].toString()),
                      Text('BMI: ${bmi.toStringAsFixed(2)}'),
                      Text('Category: ${getBmiCategory(bmi)}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _editUser(User.fromMap(snapshot.data![index]));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteUser(User.fromMap(snapshot.data![index]));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ),
    );
  }
}
