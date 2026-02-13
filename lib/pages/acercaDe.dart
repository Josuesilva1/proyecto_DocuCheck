import 'package:flutter/material.dart';
import '../helpers/drawer.dart';
import '../helpers/menuItems.dart';

class Acercade extends StatelessWidget {
  const Acercade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Acerca De'), centerTitle: true),
      drawer: buildDrawer(context),
      body: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(11),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('images/logo.png', height: 120)),
            SizedBox(height: 20),
            Center(
              child: Text(
                'DocuCheck',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Proyecto de Clase',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 1.5, color: Colors.black),
            SizedBox(height: 30),
            bulletItem('Profesor: Alejandro Cruz'),
            bulletItem('Clase: Programación Movil'),
            bulletItem('Sección: 157'),
            bulletItem('Integrantes:'),
            bulletSubItem('Carlos Ernesto Galindo Galvez 30821253'),
            bulletSubItem('Josue Martin Silva Rodriguez'),
            bulletSubItem('Andrea Michell Quintanilla León'),
            Spacer(),
            Text(
              'Tegucigalpa, Honduras Q1 2026',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
