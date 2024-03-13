import 'package:flutter/material.dart';

class Degrees extends StatefulWidget {
  const Degrees({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Degrees();
  }
}

class _Degrees extends State<Degrees> {
  TextEditingController inputController = TextEditingController();
  num? celsius;
  num? fahrenheit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Degrees Celsius',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Enter in degrees Celsius',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value.contains(',') || value.contains('-')) {
                          _showInvalidInputAlert();
                        } else {
                          celsius = num.tryParse(value);
                          fahrenheit = null;
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (celsius != null) {
                      setState(() {
                        fahrenheit = convertToFahrenheit(celsius!);
                      });
                    } else {
                      _showEmptyInputAlert();
                    }
                  },
                  child: const Text('Convert to Fahrenheit'),
                ),
                if (fahrenheit != null)
                  Text(
                    'Fahrenheit: ${fahrenheit!.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  num convertToFahrenheit(num celsius) {
    return (celsius * 9 / 5) + 32;
  }

  void _showInvalidInputAlert() {
    inputController.text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please enter a valid Celsius value without commas or negative signs.'),
          actions: [
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

  void _showEmptyInputAlert() {
    inputController.text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Empty Input'),
          content:
              const Text('Please enter a Celsius value before converting.'),
          actions: [
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
}
