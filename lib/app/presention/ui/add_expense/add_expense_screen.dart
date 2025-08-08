import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/core/utils/color_manager.dart';
import 'package:tracker_lite/app/core/utils/constant_manager.dart';
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
  late AddExpenseBloc bloc;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
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
                buildCategory(),
                buildAmount(),
                buildDate(context),
                buildAttach(),
                buildListOfCategory(),
                buildSaveBtn(context),
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox buildSaveBtn(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: () async {
          if (conAmount.text.isEmpty ||
              conDate.text.isEmpty ||
              conFile.text.isEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("please fill all data")));
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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Added Successfully")));
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
    );
  }

  Column buildListOfCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }

  Column buildAttach() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Attach Receipt",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        8.verticalSpace,
        TextField(
          controller: conFile,
          keyboardType: TextInputType.number,
          onTap: () async {
            bloc.file = await openFile();

            if (bloc.file != null) {
              if (bloc.file != null) {
                conFile.text = bloc.file!.name;
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
            contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Column buildDate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
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
              bloc.picked = picked2;
              conDate.text = bloc.picked!.toIso8601String().split("T").first;
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
            contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Column buildAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Amount",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
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
                child: bloc.selectedCurrency == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
                          value: bloc.selectedCurrency,
                          isExpanded: true,
                          onChanged: (value) {
                            bloc.add(SelectCurrencyEvent(value));
                          },
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Colors.black),
                          items: bloc.currencies.map((curr) {
                            return DropdownMenuItem(
                              value: curr,
                              child: Text(curr.code,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                      color: Colors.grey.withOpacity(.7))),
                            );
                          }).toList(),
                        ),
                      ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Column buildCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        8.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: ColorManager.GRAY),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: bloc.selectedCategory,
              isExpanded: true,
              onChanged: (value) {
                bloc.add(SelectCategoryEvent(value!));
              },
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
              items: ConstantManager.categories.map((cat) {
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
      ],
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

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        "Add Expense",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  void init() {
    bloc = AddExpenseBloc();
    bloc.add(FetchCurrencyEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
