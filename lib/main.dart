import 'package:flutter/material.dart';

void main() {
  runApp(OperacionesAritmeticasApp());
}

class OperacionesAritmeticasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Operaciones Aritméticas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OperacionesScreen(),
    );
  }
}

class OperacionesScreen extends StatefulWidget {
  @override
  _OperacionesScreenState createState() => _OperacionesScreenState();
}

class _OperacionesScreenState extends State<OperacionesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();
  String _operation = 'Suma';
  double? _result;

  void _calculateResult() {
    final double firstNumber = double.tryParse(_firstNumberController.text) ?? 0;
    final double secondNumber = double.tryParse(_secondNumberController.text) ?? 0;

    setState(() {
      switch (_operation) {
        case 'Suma':
          _result = firstNumber + secondNumber;
          break;
        case 'Resta':
          _result = firstNumber - secondNumber;
          break;
        case 'Multiplicacion':
          _result = firstNumber * secondNumber;
          break;
        case 'Division':
          _result = secondNumber != 0 ? firstNumber / secondNumber : null;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Operaciones Aritméticas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _firstNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Primer Valor',
                  hintText: 'Ingrese un numero',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Valor Correcto';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _secondNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Segundo Valor',
                  hintText: 'Ingrese un numero',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Valor Correcto';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _operation,
                decoration: InputDecoration(
                  labelText: 'Operación',
                  border: OutlineInputBorder(),
                ),
                items: ['Suma', 'Resta', 'Multiplicacion', 'Division']
                    .map((operation) => DropdownMenuItem(
                          value: operation,
                          child: Text(operation),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _operation = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _calculateResult();
                  }
                },
                child: Icon(Icons.play_arrow),
              ),
              SizedBox(height: 16),
              if (_result != null)
                Text(
                  'Total\n\nResultado\n$_result',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              if (_result == null && _operation == 'Division')
                Text(
                  'No se puede dividir entre 0',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNumberController.dispose();
    _secondNumberController.dispose();
    super.dispose();
  }
}