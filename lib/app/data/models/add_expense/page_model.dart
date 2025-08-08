import 'add_expense_item.dart';

class PaginatedExpenseItems {
  List<AddExcpenseItem> items;
  int currentPage;
  int pageSize;
  int totalItems;

  PaginatedExpenseItems({
    required this.items,
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
  });

  factory PaginatedExpenseItems.fromJson(Map<String, dynamic> json) {
    return PaginatedExpenseItems(
      items: (json['items'] as List)
          .map((e) => AddExcpenseItem.fromJson(e))
          .toList(),
      currentPage: json['currentPage'],
      pageSize: json['pageSize'],
      totalItems: json['totalItems'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'currentPage': currentPage,
      'pageSize': pageSize,
      'totalItems': totalItems,
    };
  }

  bool get hasNextPage {
    return (currentPage * pageSize) < totalItems;
  }
}
