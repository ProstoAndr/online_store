import 'package:flutter/material.dart';

class CustomAppBarDesktop {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageSelected;

  CustomAppBarDesktop({required this.selectedLanguage, required this.onLanguageSelected});

  AppBar build(BuildContext context) {
    return AppBar(
      elevation: 1,
      toolbarHeight: 60,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.grey),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Подборки', style: TextStyle(color: Colors.black, fontSize: 12)),
          const SizedBox(width: 8),
          const Text('Каталог', style: TextStyle(color: Colors.black, fontSize: 12)),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Введите название товара',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => onLanguageSelected('RU'),
          child: Text(
            'RU',
            style: TextStyle(
              color: selectedLanguage == 'RU' ? Colors.black : Colors.grey,
              fontWeight: selectedLanguage == 'RU' ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
        const Text('|', style: TextStyle(color: Colors.black)),
        TextButton(
          onPressed: () => onLanguageSelected('EN'),
          child: Text(
            'EN',
            style: TextStyle(
              color: selectedLanguage == 'EN' ? Colors.black : Colors.grey,
              fontWeight: selectedLanguage == 'EN' ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.grey),
          onPressed: () {
            // Handle cart button pressed
          },
        ),
        const Text('0', style: TextStyle(color: Colors.black)),
        const SizedBox(width: 16),
        TextButton(
          onPressed: () {
            // Handle login button pressed
          },
          child: const Text('Войти', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}