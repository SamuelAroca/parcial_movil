import 'package:flutter/material.dart';

class PressureConverter extends StatefulWidget {
  const PressureConverter({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PressureConverterState();
  }
}

class _PressureConverterState extends State<PressureConverter> {
  final TextEditingController pascalsController = TextEditingController();
  final TextEditingController atmospheresController = TextEditingController();
  final TextEditingController mmHgController = TextEditingController();

  @override
  void dispose() {
    pascalsController.dispose();
    atmospheresController.dispose();
    mmHgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pressure Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: pascalsController,
              label: 'Pascals (Pa)',
              onChanged: (value) {
                _updateAtmospheresAndMmHg(value, 'Pa');
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: atmospheresController,
              label: 'Atmospheres (atm)',
              onChanged: (value) {
                _updatePascalsAndMmHg(value, 'atm');
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: mmHgController,
              label: 'Millimeters of Mercury (mmHg)',
              onChanged: (value) {
                _updatePascalsAndAtmospheres(value, 'mmHg');
              },
            ),
          ],
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

  String? _getErrorText(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.contains(',') || value.contains('-')) {
      return 'Please enter a valid number';
    }
    return null;
  }

  void _updateAtmospheresAndMmHg(String value, String unit) {
    if (value.isEmpty) {
      atmospheresController.text = '';
      mmHgController.text = '';
      return;
    }
    final double pascals = double.tryParse(value) ?? 0;
    if (unit == 'Pa') {
      final double atmospheres = pascals / 101325;
      final double mmHg = pascals / 133.322;
      atmospheresController.text =
          atmospheres.toStringAsFixed(9); // Mostrar más decimales
      mmHgController.text = mmHg.toStringAsFixed(9);
    }
    setState(
        () {}); // Actualizar el estado para que se muestre el mensaje de advertencia
  }

  void _updatePascalsAndMmHg(String value, String unit) {
    if (value.isEmpty) {
      pascalsController.text = '';
      mmHgController.text = '';
      return;
    }
    final double atmospheres = double.tryParse(value) ?? 0;
    if (unit == 'atm') {
      final double pascals = atmospheres * 101325;
      final double mmHg = atmospheres * 760;
      pascalsController.text = pascals.toStringAsFixed(9);
      mmHgController.text = mmHg.toStringAsFixed(9);
    }
    setState(
        () {}); // Actualizar el estado para que se muestre el mensaje de advertencia
  }

  void _updatePascalsAndAtmospheres(String value, String unit) {
    if (value.isEmpty) {
      pascalsController.text = '';
      atmospheresController.text = '';
      return;
    }
    final double mmHg = double.tryParse(value) ?? 0;
    if (unit == 'mmHg') {
      final double pascals = mmHg * 133.322;
      final double atmospheres = mmHg / 760;
      pascalsController.text = pascals.toStringAsFixed(9);
      atmospheresController.text =
          atmospheres.toStringAsFixed(9); // Mostrar más decimales
    }
    setState(
        () {}); // Actualizar el estado para que se muestre el mensaje de advertencia
  }
}
