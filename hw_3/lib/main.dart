import 'package:flutter/material.dart';

void main() {
  runApp(const ATM1999());
}

class ATM1999 extends StatelessWidget {
  const ATM1999({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ATM-1999'),
          backgroundColor: Color.fromARGB(255, 54, 198, 241),
        ),
        body: const Worker(),
      ),
    );
  }
}

class Worker extends StatefulWidget {
  const Worker({super.key});

  @override
  State<Worker> createState() => _WorkerState();
}

class _WorkerState extends State<Worker> {
  int _blance = 0;
  int _money = 1000;

  int _beforeProcess = 0;

  void alert(String message) {
    setState(() {
      _beforeProcess = 0;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _updateBeforeProcess(int value) {
    setState(() {
      _beforeProcess = value;
    });
  }

  void _deposit() {
    if (_beforeProcess == 0) {
      alert('Please select the amount to deposit.');
      return;
    }

    if (_money < _beforeProcess) {
      alert('You do not have enough money.');
      return;
    }

    setState(() {
      _blance += _beforeProcess;
      _money -= _beforeProcess;
      _beforeProcess = 0;
    });
  }

  void _withdraw() {
    if (_beforeProcess == 0) {
      alert('Please select the amount to withdraw.');
      return;
    }

    if (_blance < _beforeProcess) {
      alert('You do not have enough balance.');
      return;
    }

    setState(() {
      _blance -= _beforeProcess;
      _money += _beforeProcess;
      _beforeProcess = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Bank Balance: $_blance', style: const TextStyle(fontSize: 24)),
          Text('Wallet Blance: $_money', style: const TextStyle(fontSize: 24)),
          Text(
            'Before process: $_beforeProcess',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _updateBeforeProcess(1000);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: Text("1,000"),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _updateBeforeProcess(2000);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: Text("2,000"),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _updateBeforeProcess(3000);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: Text("3,000"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _updateBeforeProcess(4000);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: Text("4,000"),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _updateBeforeProcess(5000);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: Text("5,000"),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _updateBeforeProcess(6000);
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: Text("6,000"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: _deposit,
                icon: const Icon(Icons.account_balance),
                label: const Text(
                  'Deposit',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.green,
                  iconColor: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _withdraw,
                icon: const Icon(Icons.account_balance_wallet),
                label: const Text(
                  'Withdraw',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.red,
                  iconColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
