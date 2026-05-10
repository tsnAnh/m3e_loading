import 'package:flutter/material.dart';
import 'package:m3e_loading/m3e_loading.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M3E Loading Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M3E Loading Indicator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Size Variants',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              _buildRow('XS (28px)', M3ELoadingSize.xs),
              const SizedBox(height: 32),
              _buildRow('SM (32px)', M3ELoadingSize.sm),
              const SizedBox(height: 32),
              _buildRow('MD (40px)', M3ELoadingSize.md),
              const SizedBox(height: 32),
              _buildRow('LG (48px)', M3ELoadingSize.lg),
              const SizedBox(height: 32),
              _buildRow('XL (56px)', M3ELoadingSize.xl),
              const SizedBox(height: 48),
              const Divider(),
              const SizedBox(height: 48),
              const Text(
                'Custom Colors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _buildColoredIndicator(Colors.red, 'Red'),
                  _buildColoredIndicator(Colors.green, 'Green'),
                  _buildColoredIndicator(Colors.orange, 'Orange'),
                  _buildColoredIndicator(Colors.blue, 'Blue'),
                  _buildColoredIndicator(Colors.purple, 'Purple'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, M3ELoadingSize size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          child: Text(label, textAlign: TextAlign.right),
        ),
        const SizedBox(width: 32),
        M3ELoadingIndicator(size: size),
      ],
    );
  }

  Widget _buildColoredIndicator(Color color, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        M3ELoadingIndicator(
          size: M3ELoadingSize.md,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
