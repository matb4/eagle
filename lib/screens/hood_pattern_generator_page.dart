import 'package:flutter/material.dart';

class HoodPatternGeneratorPage extends StatefulWidget {
  const HoodPatternGeneratorPage({Key? key}) : super(key: key);

  @override
  State<HoodPatternGeneratorPage> createState() => _HoodPatternGeneratorPageState();
}

class _HoodPatternGeneratorPageState extends State<HoodPatternGeneratorPage> {
  String _selectedHoodStyle = 'Arab';
  double _height = 100.0;
  double _width = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hood Pattern Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('Select Hood Style:', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: _selectedHoodStyle,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedHoodStyle = newValue!;
                });
              },
              items: <String>['Arab', 'Dutch', 'Slijpers']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.asset(
                  'assets/images/${_selectedHoodStyle.toLowerCase()}_hood.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Image not found.\nPlace it in assets/images/',
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Customization', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Height: ${_height.toStringAsFixed(1)}'),
            Slider(
              value: _height,
              min: 50,
              max: 150,
              divisions: 100,
              label: _height.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _height = value;
                });
              },
            ),
            const SizedBox(height: 10),
            Text('Width: ${_width.toStringAsFixed(1)}'),
            Slider(
              value: _width,
              min: 50,
              max: 150,
              divisions: 100,
              label: _width.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _width = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
