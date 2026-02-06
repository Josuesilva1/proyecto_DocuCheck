import 'package:flutter/material.dart';
import '../helpers/menuItems.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({super.key});

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarService.buildAppBar(
        title: 'Reportes',
        hamburger: true,
        context: context,
      ),
      body: Center(child: Text('Contenido de reportes')),
    );
  }
}