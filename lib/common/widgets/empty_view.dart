import 'package:flutter/material.dart';
import 'package:car_reception_flutter/common/config/app_colors.dart';
import 'package:car_reception_flutter/common/config/app_fonts.dart';

class EmptyView extends StatelessWidget {
  final String errorMsg;

  const EmptyView({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16.0),
      alignment: Alignment.center,
      child: Text(
        errorMsg,
        style: AppFont.Caption1_Body(color: AppColors.grey),
      ),
    );
  }
}
