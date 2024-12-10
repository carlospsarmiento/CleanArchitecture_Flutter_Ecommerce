import 'package:flutter/material.dart';

class AddressMapScreen extends StatelessWidget {
  const AddressMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Elija su dirección en el mapa"),
      ),
    );
  }
}
