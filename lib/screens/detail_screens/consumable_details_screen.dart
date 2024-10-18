import 'package:flutter/material.dart';

class ConsumableDetailsScreen extends StatefulWidget {
  const ConsumableDetailsScreen({super.key});

  @override
  State<ConsumableDetailsScreen> createState() => _ConsumableDetailsScreenState();
}

class _ConsumableDetailsScreenState extends State<ConsumableDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Consumables Details"),
      ),
    );
  }
}
