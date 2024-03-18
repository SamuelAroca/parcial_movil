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
                _buildTextField(
                  controller: inputController,
                  label: 'Enter in degrees Celsius',
                  onChanged: (value) {
                    onChange(value);
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'Fahrenheit: ${fahrenheit?.toStringAsFixed(2) ?? ''}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required void Function(String) onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        errorText: _getErrorText(controller.text),
      ),
      onChanged: onChanged,
    );
  }

  void onChange(String value) {
    setState(() {
      if (value.isEmpty) {
        celsius = null;
        fahrenheit = null;
      } else {
        celsius = _parseCelsius(value);
        if (celsius != null) {
          fahrenheit = convertToFahrenheit(celsius!);
        }
      }
    });
  }

  double? _parseCelsius(String value) {
    value = value.trim();

    if (value.startsWith('-') && value.length > 1) {
      final parsedValue = num.tryParse(value.substring(1));
      return parsedValue!.toDouble() * -1;
    } else {
      return num.tryParse(value)?.toDouble();
    }
  }

  String? _getErrorText(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    double? parsedValue = _parseCelsius(value)?.toDouble();
    if (parsedValue != null) {
      if (value.contains(',') && (value.indexOf(',') < value.indexOf(parsedValue.toString()) ||
          value.indexOf(',') > value.indexOf(parsedValue.toString()) + parsedValue.toString().length)) {
        return 'Please enter a valid number';
      }
      return null;
    } else {
      return 'Please enter a valid number';
    }
  }

  num convertToFahrenheit(num celsius) {
    return (celsius * 9 / 5) + 32;
  }
}
