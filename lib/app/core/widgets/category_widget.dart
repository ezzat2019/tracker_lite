import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget categoryIcon2(IconData icon, Color color) {
  return Column(
    children: [
      CircleAvatar(
        radius: 22,
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
    ],
  );
}

Widget categoryIcon(IconData icon, String title, Color color) {
  return Column(
    children: [
      CircleAvatar(
        radius: 22,
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
      SizedBox(height: 4.h),
      Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    ],
  );
}

final List<Widget> icons = [
  categoryIcon(Icons.shopping_cart, 'Groceries', Colors.blue),
  categoryIcon(Icons.movie, 'Entertainment', Colors.red),
  categoryIcon(Icons.local_gas_station, 'Gas', Colors.orange),
  categoryIcon(Icons.shopping_bag, 'Shopping', Colors.amber),
  categoryIcon(Icons.directions_bus, 'Transport', Colors.green),
  categoryIcon(Icons.home, 'Rent', Colors.purple),
  categoryIcon(Icons.add, 'Add', Colors.grey),
];
Widget getCategoryWidget(String name) {
  final Map<String, Map<String, dynamic>> categories = {
    'Groceries': {
      'icon': Icons.shopping_cart,
      'color': Colors.blue,
    },
    'Entertainment': {
      'icon': Icons.movie,
      'color': Colors.red,
    },
    'Gas': {
      'icon': Icons.local_gas_station,
      'color': Colors.orange,
    },
    'Shopping': {
      'icon': Icons.shopping_bag,
      'color': Colors.amber,
    },
    'Transport': {
      'icon': Icons.directions_bus,
      'color': Colors.green,
    },
    'Rent': {
      'icon': Icons.home,
      'color': Colors.purple,
    },
    'Add': {
      'icon': Icons.add,
      'color': Colors.grey,
    },
  };

  final category = categories[name] ??
      {
        'icon': Icons.help_outline,
        'color': Colors.black,
      };

  return categoryIcon2(
    category['icon'] as IconData,
    category['color'] as Color,
  );
}
