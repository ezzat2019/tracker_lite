import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracker_lite/app/core/utils/color_manager.dart';

class AttachReceiptWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(XFile?) onFilePicked;

  const AttachReceiptWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.onFilePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        8.verticalSpace,
        TextField(
          controller: controller,
          onTap: () async {
            const XTypeGroup typeGroup = XTypeGroup(
              label: 'images',
              extensions: <String>['jpg', 'png', 'jpeg'],
            );
            final XFile? file =
                await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
            onFilePicked(file);
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
            suffixIcon: const Icon(Icons.linked_camera_outlined),
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
}
