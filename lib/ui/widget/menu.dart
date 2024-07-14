import 'package:flutter/material.dart';

class CustomMenu extends StatelessWidget {
  const CustomMenu({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[200], // Adjust this color for a darker white (light gray)
            ),
            child: const Text(
              'Онлайн магазин',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Профиль'),
            onTap: () {
              // Handle drawer item tap
            },
          ),
        ],
      ),
    );
  }
}