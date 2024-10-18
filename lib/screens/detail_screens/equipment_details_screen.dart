import 'package:flutter/material.dart';

class EquipmentDetailsScreen extends StatefulWidget {
  const EquipmentDetailsScreen({super.key});

  static const String routeName = "equipment_details_route";

  @override
  State<EquipmentDetailsScreen> createState() => _EquipmentDetailsScreenState();
}

class _EquipmentDetailsScreenState extends State<EquipmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Equipment Details"),
      ),
    );
  }
}
