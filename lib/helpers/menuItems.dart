import 'package:flutter/material.dart';

Widget menuItems(
  BuildContext context,
  IconData icon,
  String title,
  String route,
) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    borderRadius: BorderRadius.circular(16),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.red),
          SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

int getCrossAxisCount(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width < 500 ? 1 : 2;
}
