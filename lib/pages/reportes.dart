import 'package:flutter/material.dart';
import '../helpers/drawer.dart';
import '../helpers/document.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({super.key});

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reportes'), centerTitle: true),
      drawer: buildDrawer(context),
      body: ListView.builder(
        itemCount: documentos.length,
        itemBuilder: (context, index) {
          final doc = documentos[index];
          return ListTile(
            title: Text(doc.texto),
            subtitle: Text(doc.fecha.toString()),
          );
        },
      ),
    );
  }
}
