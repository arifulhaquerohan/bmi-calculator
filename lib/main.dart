import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// We'll make MyApp a StatefulWidget to manage the theme mode
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Default to light mode
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      // Apply the selected theme mode
      themeMode: _themeMode,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Light mode specific configurations
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.blue.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2.5),
          ),
          labelStyle: const TextStyle(color: Colors.blueGrey),
          hintStyle: TextStyle(color: Colors.blueGrey.shade400),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white, // Card color in light mode
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black87), // Default text color
          bodyLarge: TextStyle(color: Colors.black),
          titleMedium: TextStyle(
            color: Colors.blueGrey,
          ), // Used for 'Calculate Your Body Mass Index'
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        // Dark mode specific configurations
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor:
              Colors.blueGrey, // A slightly darker app bar for dark mode
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey.shade900, // Dark background
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.blueGrey.shade800, // Darker fill for inputs
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blueGrey.shade600, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.redAccent, width: 2.5),
          ),
          labelStyle: const TextStyle(color: Colors.white70),
          hintStyle: TextStyle(color: Colors.blueGrey.shade400),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Colors.blue.shade700, // Darker button for dark mode
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.grey.shade800, // Card color in dark mode
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          bodyLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: BMICalculatorHomePage(
        toggleTheme: _toggleTheme,
        currentThemeMode: _themeMode,
      ),
    );
  }
}

class BMICalculatorHomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final ThemeMode currentThemeMode;

  const BMICalculatorHomePage({
    super.key,
    required this.toggleTheme,
    required this.currentThemeMode,
  });

  @override
  _BMICalculatorHomePageState createState() => _BMICalculatorHomePageState();
}

class _BMICalculatorHomePageState extends State<BMICalculatorHomePage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double _bmiResult = 0.0;
  String _bmiCategory = 'Enter your details above';
  Color _bmiCategoryColor = Colors.grey;

  final _formKey = GlobalKey<FormState>();

  void _calculateBMI() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        double weight = double.parse(_weightController.text);
        double height = double.parse(_heightController.text);

        _bmiResult = weight / (height * height);

        if (_bmiResult < 18.5) {
          _bmiCategory = 'Underweight';
          _bmiCategoryColor = Colors.orange;
        } else if (_bmiResult >= 18.5 && _bmiResult < 24.9) {
          _bmiCategory = 'Normal weight';
          _bmiCategoryColor = Colors.green;
        } else if (_bmiResult >= 25 && _bmiResult < 29.9) {
          _bmiCategory = 'Overweight';
          _bmiCategoryColor = Colors.redAccent;
        } else {
          _bmiCategory = 'Obesity';
          _bmiCategoryColor = Colors.red.shade900;
        }
      });
    } else {
      setState(() {
        _bmiResult = 0.0;
        _bmiCategory = 'Please fix input errors.';
        _bmiCategoryColor = Colors.red;
      });
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        actions: [
          IconButton(
            icon: Icon(
              widget.currentThemeMode == ThemeMode.light
                  ? Icons
                      .dark_mode // Moon icon for light mode (to switch to dark)
                  : Icons
                      .light_mode, // Sun icon for dark mode (to switch to light)
            ),
            onPressed:
                widget
                    .toggleTheme, // Call the toggleTheme function passed from MyApp
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Calculate Your Body Mass Index',
                style:
                    Theme.of(
                      context,
                    ).textTheme.titleMedium, // Use theme text style
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Weight',
                  hintText: 'e.g., 70.5',
                  prefixIcon: Icon(Icons.fitness_center),
                  suffixText: 'kg',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight.';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Please enter a valid positive number for weight.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Height',
                  hintText: 'e.g., 1.75',
                  prefixIcon: Icon(Icons.accessibility_new),
                  suffixText: 'm',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height.';
                  }
                  if (double.tryParse(value) == null ||
                      double.parse(value) <= 0) {
                    return 'Please enter a valid positive number for height.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _calculateBMI,
                icon: const Icon(Icons.calculate),
                label: const Text('Calculate BMI'),
              ),
              const SizedBox(height: 50),
              Card(
                // Card background color adapts based on theme defined in ThemeData
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Your BMI is:',
                        style:
                            Theme.of(
                              context,
                            ).textTheme.bodyMedium, // Use theme text style
                      ),
                      const SizedBox(height: 10),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (
                          Widget child,
                          Animation<double> animation,
                        ) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Text(
                          _bmiResult.toStringAsFixed(2),
                          key: ValueKey<double>(_bmiResult),
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.blue
                                    : Colors
                                        .blueAccent, // Color changes with theme
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _bmiCategory,
                        style: TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color:
                              _bmiCategoryColor, // This color remains specific to BMI category
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
