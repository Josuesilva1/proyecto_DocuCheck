import 'package:flutter/material.dart';

Widget menuItems(BuildContext context, IconData icon, String title, String route) {
  return InkWell(
    onTap: () {Navigator.pushNamed(context, route);},
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
          Icon(
            icon, 
            size: 48,
            color: Colors.red,
            ),
          SizedBox(width: 12),
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

class AppBarService{
  static AppBar buildAppBar({
    required String title,
    bool hamburger = false,
    BuildContext? context,
  }){
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        if(hamburger)
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){
              if(context != null){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Menú pendiente de implementar')),
                );
              }
            },
          )
      ]
    );
  }
}