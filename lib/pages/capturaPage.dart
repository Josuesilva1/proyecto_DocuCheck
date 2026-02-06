import 'package:flutter/material.dart';
import '../helpers/menuItems.dart';

class CapturaPage extends StatefulWidget {
  const CapturaPage({super.key});

  @override
  State<CapturaPage> createState() => _CapturaPageState();
}

class _CapturaPageState extends State<CapturaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarService.buildAppBar(
        title: 'Captura de Imagen',
        hamburger: true,
        context: context,
      ),
      body: Center(child: Text('Contenido de captura')),
    );
  }
}