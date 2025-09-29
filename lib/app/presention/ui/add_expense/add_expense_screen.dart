import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/core/utils/constant_manager.dart';
import 'package:tracker_lite/app/core/widgets/category_widget.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_bloc.dart';

import '../../../data/models/add_expense/add_expense_item.dart';
import '../../bloc/add_expense/add_expense_bloc.dart';
import '../../bloc/add_expense/add_expense_events.dart';
import '../../bloc/add_expense/add_expense_states.dart';
import 'widgets/date_field_widget.dart';
import 'widgets/attach_receipt_widget.dart';
import 'widgets/amount_field_widget.dart';
import 'widgets/category_dropdown_widget.dart';
import 'widgets/save_expense_button_widget.dart';
import 'widgets/add_expense_app_bar.dart';
import 'widgets/list_of_category_widget.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController conDate = TextEditingController();
  final TextEditingController conAmount = TextEditingController();
  final TextEditingController conFile = TextEditingController();
  late AddExpenseBloc bloc;
  List<Widget> icons = [];

  @override
  void initState() {
    super.initState();
    bloc = AddExpenseBloc();
    bloc.add(FetchCurrencyEvent());

    icons = ConstantManager.categories.map((categoryName) {
      return CategoryWidget(
        iconPath:
            "assets/icons/${categoryName.toLowerCase().replaceAll(' ', '_')}.png",
        label: categoryName,
        onTap: () {
          bloc.add(SelectCategoryEvent(categoryName));
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AddExpenseAppBar(),
      backgroundColor: Colors.white,
      body: BlocBuilder<AddExpenseBloc, AddExpenseStates>(
        bloc: bloc,
        builder: (BuildContext context, AddExpenseStates state) {
          stateHandleing(state);

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryDropdownWidget(
                  selectedCategory: bloc.selectedCategory,
                  onCategoryChanged: (value) {
                    bloc.add(SelectCategoryEvent(value!));
                  },
                ),
                AmountFieldWidget(
                  amountController: conAmount,
                  selectedCurrency: bloc.selectedCurrency,
                  currencies: bloc.currencies,
                  onCurrencyChanged: (value) {
                    bloc.add(SelectCurrencyEvent(value));
                  },
                ),
                DateFieldWidget(
                  controller: conDate,
                  label: "Date",
                  initialDate: bloc.picked ?? DateTime.now(),
                  onDatePicked: (pickedDate) {
                    bloc.picked = pickedDate;
                    conDate.text =
                        bloc.picked!.toIso8601String().split("T").first;
                  },
                ),
                AttachReceiptWidget(
                  controller: conFile,
                  label: "Attach Receipt",
                  onFilePicked: (file) {
                    bloc.file = file;
                    if (bloc.file != null) {
                      conFile.text = bloc.file!.name;
                    } else {
                      conFile.text = "";
                    }
                  },
                ),
                ListOfCategoryWidget(icons: icons), // Corrected call
                SaveExpenseButtonWidget(
                  onPressed: () async {
                    if (conAmount.text.isEmpty ||
                        conDate.text.isEmpty ||
                        conFile.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("please fill all data")));
                      return;
                    }

                    AddExcpenseItem item = AddExcpenseItem(
                        id: DateTime.now().microsecondsSinceEpoch,
                        category: bloc.selectedCategory,
                        amountBefore: conAmount.text.trim(),
                        amountAfter: bloc.calculateCurrency(
                            conAmount.text.trim(), bloc.selectedCurrency!.rate),
                        code: bloc.selectedCurrency!.code,
                        dateformat: conDate.text,
                        filePath: bloc.file?.path ?? null,
                        date: bloc.picked!);

                    await bloc.addItem(item);
                    context.read<DashboardBloc>().pagingController.refresh();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added Successfully")));
                    conDate.text = "";
                    conAmount.text = "";
                    conFile.text = "";
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void stateHandleing(AddExpenseStates state) {
    if (state is FetchExchangeCurrencyState) {
      if (state.exchangeRateResponse != null) {
        bloc.currencies = state.exchangeRateResponse!.conversionRates;
        bloc.selectedCurrency ??=
            bloc.currencies.isNotEmpty ? bloc.currencies.first : null;
      }
    } else if (state is SelectCategoryState) {
      bloc.selectedCategory = state.selectedCategory;
    } else if (state is SelectCurrencyState) {
      bloc.selectedCurrency = state.selectedCurrency;
    }
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
