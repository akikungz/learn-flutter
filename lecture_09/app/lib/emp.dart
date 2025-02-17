import 'package:app/db/client.dart';
import 'package:app/db/model.dart';
import 'package:flutter/material.dart';

class EmpPage extends StatefulWidget {
  const EmpPage({super.key});

  @override
  State<EmpPage> createState() => _EmpPageState();
}

class _EmpPageState extends State<EmpPage> {
  List<Emp> employees = [];
  bool isLoading = true;
  bool init = true;

  // Text editing controllers
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController height = TextEditingController();

  // Clear text editing controllers
  void clearControllers() {
    name.clear();
    age.clear();
    email.clear();
    phone.clear();
    address.clear();
    weight.clear();
    height.clear();

    // setloading(false);
    setLoading(false);
  }

  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  // RestClient instance
  RestClient client = RestClient();

  // Fetch all employees
  void fetchEmployees() async {
    // setLoading(true);
    List<Emp> employees = await client.get(null);
    setState(() {
      this.employees = employees;
      isLoading = false;
    });
  }

  // Post an employee
  void postEmployee() async {
    setLoading(true);
    Emp emp = Emp(
      name: name.text,
      age: int.parse(age.text),
      email: email.text,
      phone: phone.text,
      address: address.text,
      weight: double.parse(weight.text),
      height: double.parse(height.text),
      id: null,
    );
    Emp? employee = await client.post(emp);
    if (employee != null) {
      fetchEmployees();
    }

    // Clear the text editing controllers
    clearControllers();
  }

  // Update an employee
  void updateEmployee(Emp emp) async {
    // Update the employee
    Emp updatedEmp = Emp(
      id: emp.id,
      name: name.text,
      age: int.parse(age.text),
      email: email.text,
      phone: phone.text,
      address: address.text,
      weight: double.parse(weight.text),
      height: double.parse(height.text),
    );

    // Put the updated employee
    Emp? employee = await client.put(emp.id!, updatedEmp);
    if (employee != null) {
      fetchEmployees();
    }

    // Clear the text editing controllers
    clearControllers();
  }

  void deleteEmployee(int id) async {
    setLoading(true);
    // Delete the employee
    await client.delete(id);

    // Fetch all employees
    fetchEmployees();
  }

  // Show the dialog
  void showTheDialog(String method, Emp? emp) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        name.text = emp?.name ?? '';
        age.text = emp?.age.toString() ?? '';
        email.text = emp?.email ?? '';
        phone.text = emp?.phone ?? '';
        address.text = emp?.address ?? '';
        weight.text = emp?.weight.toString() ?? '';
        height.text = emp?.height.toString() ?? '';

        return AlertDialog(
          title: const Text('Add Employee'),
          content: Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: age,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phone,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: address,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: weight,
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: height,
                decoration: const InputDecoration(labelText: 'Height'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Post the employee
                if (method == 'post') {
                  postEmployee();
                } else {
                  updateEmployee(emp!);
                }

                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text(method == 'post' ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  // Calculate the BMI of the employee
  double calculateBMI(Emp emp) {
    // Height is centimeters
    double height = emp.height / 100;
    return emp.weight / (height * height);
  }

  // Calculate ideal weight
  double calculateIdelWeight(Emp emp) {
    // Height is centimeters
    double height = emp.height / 100;
    double bmi = emp.weight / (height * height);
    double normalBMI = 22.9;

    if (catagoryBMI(bmi) == 'Normal') {
      return 0;
    }

    if (catagoryBMI(bmi) == 'Underweight') {
      normalBMI = 18.5;
    }

    return (normalBMI * height * height) - emp.weight;
  }

  String catagoryBMI(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 22.9) {
      return 'Normal';
    } else if (bmi >= 23 && bmi < 24.9) {
      return 'Risk of Overweight';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (init) {
      fetchEmployees();
      init = false;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Employee Management')),
      body:
          employees.isNotEmpty
              ? ListView.builder(
                itemCount: employees.length,
                itemBuilder: (BuildContext context, int index) {
                  Emp emp = employees[index];
                  return ListTile(
                    title: Text(emp.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Age: ${emp.age}'),
                        Text('Email: ${emp.email}'),
                        Text('Phone: ${emp.phone}'),
                        Text('Address: ${emp.address}'),
                        Text('Weight: ${emp.weight} kg'),
                        Text('Height: ${emp.height} cm'),
                        Text('BMI: ${calculateBMI(emp).toStringAsFixed(2)}'),
                        Text('Category: ${catagoryBMI(calculateBMI(emp))}'),
                        Text(
                          'Ideal Weight: ${calculateIdelWeight(emp).toStringAsFixed(2)} kg',
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showTheDialog('put', emp);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            deleteEmployee(emp.id!);
                          },
                        ),
                      ],
                    ),
                  );
                },
              )
              : isLoading
              // ? const Center(child: CircularProgressIndicator())
              ? const Center(child: Text('Loading...'))
              : const Center(child: Text('No employees found')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showTheDialog('post', null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
