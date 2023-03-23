import 'package:flutter/material.dart';

class AdminConfigCandy extends StatelessWidget {
  const AdminConfigCandy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Configuración de contenedores',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),
              
            ],
          )
        ),
      ),
    );
  }
}