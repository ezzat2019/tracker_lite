
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/core/utils/color_manager.dart';
import 'package:tracker_lite/app/core/widgets/category_widget.dart';
import 'package:tracker_lite/app/data/models/exchange_currency/exchange_rate_response.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_bloc.dart';

import '../../../data/models/add_expense/add_expense_item.dart';
import '../../bloc/add_expense/add_expense_bloc.dart';
import '../../bloc/add_expense/add_expense_events.dart';
import '../../bloc/add_expense/add_expense_states.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController conDate = TextEditingController();
  final TextEditingController conAmount = TextEditingController();
  final TextEditingController conFile = TextEditingController();
  XFile? file;
  late AddExpenseBloc bloc;
  DateTime? picked;
  String selectedCategory = 'Entertainment';
  List<CurrencyRate> currencies = [];
  CurrencyRate? selectedCurrency;

  final List<String> categories = [
    'Entertainment',
    'Groceries',
    'Gas',
    'Shopping',
    'Transport',
    'Rent',
  ];

  @override
  void initState() {
    super.initState();
    bloc = AddExpenseBloc();
    bloc.add(FetchCurrencyEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Expense",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<AddExpenseBloc, AddExpenseStates>(
        bloc: bloc,
        builder: (BuildContext context, AddExpenseStates state) {
          if (state is FetchExchangeCurrencyState) {
            if (state.exchangeRateResponse != null) {
              currencies = state.exchangeRateResponse!.conversionRates;
              selectedCurrency ??=
                  currencies.isNotEmpty ? currencies.first : null;
            }
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                8.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: ColorManager.GRAY),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      icon:
                          Icon(Icons.keyboard_arrow_down, color: Colors.black),
                      items: categories.map((cat) {
                        return DropdownMenuItem(
                          value: cat,
                          child: Text(
                            cat,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: Colors.grey.withOpacity(.7)),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "Amount",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: conAmount,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.grey.withOpacity(.7)),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: Colors.grey.withOpacity(.7)),
                          fillColor: ColorManager.GRAY,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 0),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: ColorManager.GRAY),
                        child: selectedCurrency == null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                        )),
                                  ),
                                ],
                              )
                            : DropdownButtonHideUnderline(
                                child: DropdownButton<CurrencyRate>(
                                  value: selectedCurrency,
                                  isExpanded: true,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCurrency = value!;
                                    });
                                  },
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      color: Colors.black),
                                  items: currencies.map((curr) {
                                    return DropdownMenuItem(
                                      value: curr,
                                      child: Text(curr.code,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                              color:
                                                  Colors.grey.withOpacity(.7))),
                                    );
                                  }).toList(),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                Text(
                  "Date",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                8.verticalSpace,
                TextField(
                  controller: conDate,
                  keyboardType: TextInputType.number,
                  onTap: () async {
                    var picked2 = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked2 != null) {
                      picked = picked2;
                      conDate.text = picked!.toIso8601String().split("T").first;
                    }
                  },
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.grey.withOpacity(.7)),
                  readOnly: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Colors.grey.withOpacity(.7)),
                    fillColor: ColorManager.GRAY,
                    filled: true,
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
                  ),
                ),
                SizedBox(height: 16.h),

                Text(
                  "Attach Receipt",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                8.verticalSpace,
                TextField(
                  controller: conFile,
                  keyboardType: TextInputType.number,
                  onTap: () async {
                    file = await openFile();

                    if (file != null) {
                      if (file != null) {
                        conFile.text = file!.name;
                      }
                    }
                  },
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.grey.withOpacity(.7)),
                  readOnly: true,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Colors.grey.withOpacity(.7)),
                    fillColor: ColorManager.GRAY,
                    filled: true,
                    suffixIcon: Icon(Icons.linked_camera_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 20.w,
                  runSpacing: 16.h,
                  children: icons,
                ),

                SizedBox(height: 50.h),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (conAmount.text.isEmpty ||
                          conDate.text.isEmpty ||
                          conFile.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("please fill all data")));
                        return;
                      }
                      AddExcpenseItem item = AddExcpenseItem(
                          id: DateTime.now().microsecondsSinceEpoch,
                          category: selectedCategory,
                          amountBefore: conAmount.text.trim(),
                          amountAfter: (num.parse(conAmount.text.trim()) /
                                  selectedCurrency!.rate)
                              .toString(),
                          code: selectedCurrency!.code,
                          dateformat: conDate.text,
                          filePath: file?.path ?? null,
                          date: picked!);

                      await bloc.addItem(item);
                      context.read<DashboardBloc>().pagingController.refresh();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Added Successfully")));
                      conDate.text = "";
                      conAmount.text = "";
                      conFile.text = "";
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
