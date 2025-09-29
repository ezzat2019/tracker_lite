import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/core/utils/color_manager.dart';
import 'package:tracker_lite/app/data/models/exchange_currency/exchange_rate_response.dart';

class AmountFieldWidget extends StatelessWidget {
  final TextEditingController amountController;
  final CurrencyRate? selectedCurrency;
  final List<CurrencyRate> currencies;
  final Function(CurrencyRate?) onCurrencyChanged;

  const AmountFieldWidget({
    super.key,
    required this.amountController,
    required this.selectedCurrency,
    required this.currencies,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
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
                controller: amountController,
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
                child: selectedCurrency == null && currencies.isEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ))),
                        ],
                      )
                    : DropdownButtonHideUnderline(
                        child: DropdownButton<CurrencyRate>(
                          value: selectedCurrency,
                          isExpanded: true,
                          onChanged: onCurrencyChanged,
                          icon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.black),
                          items: currencies.map((curr) {
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
}
