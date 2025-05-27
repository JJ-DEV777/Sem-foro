import 'package:flutter/material.dart';

void main() => runApp(const Range());

class Range extends StatelessWidget {
  const Range({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RangeSlider Sample'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/inicio'),
            ),
          ],
        ),
        body: const RangeSliderExample(),
      ),
    );
  }
}

class RangeSliderExample extends StatefulWidget {
  const RangeSliderExample({super.key});

  @override
  State<RangeSliderExample> createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<RangeSliderExample> {
  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      max: 100,
      divisions: 5,
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
        });
      },
    );
  }
}