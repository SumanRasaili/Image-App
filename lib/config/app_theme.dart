import 'package:flutter/material.dart';
import 'package:vritapp/config/app_colors.dart';
import 'package:vritapp/config/config.dart';

ThemeData lightThemeData() {
  return ThemeData(
      iconTheme: IconThemeData(size: 25, color: AppColors.whiteColor),
      listTileTheme: ListTileThemeData(
          iconColor: AppColors.whiteColor,
          titleTextStyle: TextStyle(fontSize: 14, color: AppColors.whiteColor)),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.scaffoldBackGroundColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: const MaterialStatePropertyAll(TextStyle(
            fontSize: 17,
          )),
          backgroundColor: const MaterialStatePropertyAll(Colors.deepPurple),
          foregroundColor: MaterialStatePropertyAll(AppColors.whiteColor),
        ),
      ),
      useMaterial3: true,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          unselectedIconTheme:
              IconThemeData(color: AppColors.whiteColor.withOpacity(0.5)),
          unselectedItemColor: AppColors.whiteColor,
          unselectedLabelStyle:
              TextStyle(color: AppColors.whiteColor.withOpacity(0.5)),
          backgroundColor: AppColors.scaffoldBackGroundColor),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            color: AppColors.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.w600),
        titleMedium: TextStyle(
            color: AppColors.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        titleSmall: TextStyle(
            color: AppColors.blackColor,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(
            color: AppColors.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: AppColors.blackColor, fontSize: 14),
        bodySmall: TextStyle(color: AppColors.blackColor, fontSize: 12),
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.scaffoldBackGroundColor,
      ),
      primaryColor: AppColors.primaryColor,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      scaffoldBackgroundColor: AppColors.scaffoldBackGroundColor);
}
