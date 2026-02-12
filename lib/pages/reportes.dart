import 'package:flutter/material.dart';
import '../helpers/drawer.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({super.key});

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reportes'),
        centerTitle: true,
      ),
      drawer: buildDrawer(context),
      body: Center(child: Text('Contenido de reportes')),
    );
  }
}