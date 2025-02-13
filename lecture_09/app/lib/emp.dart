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

  // Clear text editing controllers
  void clearControllers() {
    name.clear();
    age.clear();
    email.clear();
    phone.clear();
    address.clear();

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
    setLoading(true);
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
              ),
              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phone,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: address,
                decoration: const InputDecoration(labelText: 'Address'),
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
                    subtitle: Text(emp.email),
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
              ? const Center(child: CircularProgressIndicator())
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
