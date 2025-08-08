import 'dart:convert';
import 'dart:developer';


import '../../../data/models/add_expense/add_expense_item.dart';
import '../../../data/models/add_expense/page_model.dart';
import '../../../data/source/local/shared_pref_manager.dart';

class CacheUseCase {
  late SharedPrefManager sharedPrefManager;
  CacheUseCase(this.sharedPrefManager);

  Future<void> addExpenseItem(AddExcpenseItem newItem) async {
    final prefs = sharedPrefManager.preferences;

    String? jsonString = prefs.getString('expense_items_paginated');

    List<AddExcpenseItem> allItems = [];
    int pageSize = 10;
    int currentPage = 1;

    if (jsonString != null) {
      final paginated = PaginatedExpenseItems.fromJson(jsonDecode(jsonString));
      allItems = paginated.items;
      pageSize = paginated.pageSize;
      currentPage = paginated.currentPage;
    }

    allItems.add(newItem);

    final updatedPagination = PaginatedExpenseItems(
      items: allItems,
      currentPage: currentPage,
      pageSize: pageSize,
      totalItems: allItems.length,
    );

    await savePaginatedItems(updatedPagination);
  }

  Future<void> savePaginatedItems(PaginatedExpenseItems page) async {
    final prefs = sharedPrefManager.preferences;
    final jsonString = jsonEncode(page.toJson());
    await prefs.setString('expense_items_paginated', jsonString);
  }

  Future<PaginatedExpenseItems> getPaginatedItems(
      {int page = 1, int pageSize = 10}) async {
    final prefs = sharedPrefManager.preferences;
    String? jsonString = prefs.getString('expense_items_paginated');

    if (jsonString == null) {
      return PaginatedExpenseItems(
          items: [], currentPage: page, pageSize: pageSize, totalItems: 0);
    }

    final paginated = PaginatedExpenseItems.fromJson(jsonDecode(jsonString));

    int startIndex = (page - 1) * pageSize;
    int endIndex = startIndex + pageSize;
    endIndex =
        endIndex > paginated.items.length ? paginated.items.length : endIndex;

    final pageItems = paginated.items.sublist(startIndex, endIndex);
    log(paginated.toJson().toString());
    return PaginatedExpenseItems(
      items: pageItems,
      currentPage: page,
      pageSize: pageSize,
      totalItems: paginated.totalItems,
    );
  }

  Future<double> getTotalBalance() async {
    final prefs = sharedPrefManager.preferences;
    String? jsonString = prefs.getString('expense_items_paginated');

    if (jsonString == null) {
      return 0.0;
    }
    final paginated = PaginatedExpenseItems.fromJson(jsonDecode(jsonString));

    double total = 0.0;
    for (var item in paginated.items) {
      total += double.tryParse(item.amountAfter) ?? 0.0;
    }

    return total;
  }
}
