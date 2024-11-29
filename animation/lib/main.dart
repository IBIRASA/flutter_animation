import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Welcome to Kstore',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: CatalogPage(),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final double price;

  Product({required this.name, required this.imageUrl, required this.price});
}

class CatalogPage extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Laptop', imageUrl: 'assets/laptop.jpg', price: 999.99),
    Product(name: 'Phone', imageUrl: 'assets/phone.jpg', price: 799.99),
    Product(
        name: 'Headphones', imageUrl: 'assets/headphone.jpg', price: 199.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Kstore'),
        actions: [
          IconButton(
            icon: Obx(() => Icon(
                  Get.isDarkMode ? Icons.brightness_7 : Icons.brightness_4,
                  color: Colors.white,
                )),
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeThemeMode(ThemeMode.light);
              } else {
                Get.changeThemeMode(ThemeMode.dark);
              }
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Product'),
                  content: Text(product.name),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(product.name, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 4),
                  Text('\$${product.price}', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}