import 'dart:math'; // Import the random package
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class JoystickExample extends StatefulWidget {
  const JoystickExample({super.key});

  @override
  State<JoystickExample> createState() => _JoystickExampleState();
}

class _JoystickExampleState extends State<JoystickExample> {
  double _x = 100.0;
  double _y = 100.0;
  JoystickMode joystickMode = JoystickMode.all;

  // Random dot position
  double _randomX = 0.0;
  double _randomY = 0.0;

  // Flag to track if the dialog is already shown
  bool _isDialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    setState(() {
      _x = screenWidth / 2 - 10.0; // Centering ball
      _y = screenHeight / 2 - 10.0;

      // Generate random dot coordinates
      _randomX =
          Random().nextDouble() * (screenWidth - 20.0); // random X position
      _randomY =
          Random().nextDouble() * (screenHeight - 100.0); // random Y position
    });
  }

  // Function to check if ball collides with the random dot
  bool _checkCollision() {
    const ballSize = 20.0;
    const dotSize = 10.0;

    // Check if the distance between the center of the ball and the dot is less than the sum of their radii
    double dx = _x + ballSize / 2 - (_randomX + dotSize / 2);
    double dy = _y + ballSize / 2 - (_randomY + dotSize / 2);
    double distance = sqrt(dx * dx + dy * dy);

    return distance < (ballSize / 2 + dotSize / 2);
  }

  // Function to restart the game
  void _restartGame() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    setState(() {
      _x = screenWidth / 2 - 10.0; // Reset ball to the center
      _y = screenHeight / 2 - 10.0;

      // Generate new random dot coordinates
      _randomX =
          Random().nextDouble() * (screenWidth - 20.0); // random X position
      _randomY =
          Random().nextDouble() * (screenHeight - 100.0); // random Y position

      // Reset the dialog flag
      _isDialogShown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const speed = 10.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text('Hit The Dot', style: TextStyle(color: Colors.white)),
        actions: [
          // Restart button
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _restartGame,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Ball that moves with joystick
          Ball(x: _x, y: _y),

          // Random dot point circle
          Positioned(
            left: _randomX,
            top: _randomY,
            child: Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Joystick at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Opacity(
                opacity: 0.5, // ปรับค่าความโปร่งแสงของจอยสติก
                child: Joystick(
                  mode: joystickMode,
                  key: const Key('joystick'),
                  listener: (details) {
                    setState(() {
                      double newX = _x + details.x * speed;
                      double newY = _y + details.y * speed;
                      _x = newX.clamp(0.0, screenWidth - 20.0);
                      if (_y < (screenHeight - 100.0)) {
                        _y = newY.clamp(0.0, screenHeight - 20.0);
                      } else {
                        if (details.y > 0) {
                          _y = screenHeight - 100.0;
                        } else {
                          _y = newY.clamp(0.0, screenHeight - 20.0);
                        }
                      }
                      if (_checkCollision() && !_isDialogShown) {
                        _isDialogShown = true;
                        _showDialog();
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the alert dialog
  void _showDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Done!'),
            content: const Text('You hit the dot!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  _restartGame(); // Restart the game
                },
                child: const Text('Play Again'),
              ),
            ],
          ),
    );
  }
}

class Ball extends StatelessWidget {
  final double x;
  final double y;
  const Ball({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    const ballSize = 20.0;
    return Positioned(
      left: x,
      top: y,
      child: Container(
        width: ballSize,
        height: ballSize,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
