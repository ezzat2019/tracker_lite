import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_bloc.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_events.dart';
import 'package:tracker_lite/app/presention/bloc/dashboard/dashboard_states.dart';

class FilterDropdown extends StatefulWidget {
  const FilterDropdown({super.key});

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {


  final List<String> options = [
    'This Month',
    'Last 7 Days',
  ];

  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc,DashboardStates>(
      builder: (BuildContext context, DashboardStates state) {
        String selectedValue ;
        if(state is DashboardFilterState)
          {
            selectedValue=state.filter;
          }else{
          selectedValue=options.first;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: 105.w,
          height: 35.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Colors.black,
              ),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(6),
              onChanged: (String? newValue) {
                if (newValue != null) {
                 context.read<DashboardBloc>().add(ChangeHomeFilterEvent(newValue));
                }
              },
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
