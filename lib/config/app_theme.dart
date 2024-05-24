import 'package:flutter/material.dart';
import 'package:vritapp/config/app_colors.dart';
import 'package:vritapp/config/config.dart';

ThemeData lightThemeData() {
  return ThemeData(
      datePickerTheme: DatePickerThemeData(
          yearOverlayColor: MaterialStatePropertyAll(AppColors.whiteColor),
          surfaceTintColor: AppColors.whiteColor,
          yearBackgroundColor: MaterialStatePropertyAll(AppColors.whiteColor),
          dayOverlayColor: MaterialStatePropertyAll(AppColors.whiteColor),
          headerHelpStyle: TextStyle(color: AppColors.whiteColor),
          rangePickerSurfaceTintColor: AppColors.whiteColor,
          inputDecorationTheme: InputDecorationTheme(
              fillColor: AppColors.whiteColor,
              filled: true,
              labelStyle: TextStyle(color: AppColors.whiteColor),
              hintStyle: TextStyle(
                color: AppColors.whiteColor,
              )),
          headerForegroundColor: AppColors.whiteColor,
          shadowColor: AppColors.whiteColor,
          rangeSelectionBackgroundColor: Colors.white,
          rangePickerShadowColor: AppColors.whiteColor,
          rangeSelectionOverlayColor:
              MaterialStatePropertyAll(AppColors.whiteColor),
          rangePickerHeaderBackgroundColor: AppColors.whiteColor,
          rangePickerBackgroundColor: AppColors.whiteColor,
          todayForegroundColor: MaterialStatePropertyAll(AppColors.whiteColor),
          yearStyle: TextStyle(color: AppColors.whiteColor),
          yearForegroundColor: MaterialStatePropertyAll(AppColors.whiteColor),
          rangePickerHeaderForegroundColor: AppColors.whiteColor,
          rangePickerHeaderHeadlineStyle:
              TextStyle(color: AppColors.whiteColor),
          rangePickerHeaderHelpStyle: TextStyle(color: AppColors.whiteColor),
          headerHeadlineStyle: TextStyle(color: AppColors.whiteColor),
          weekdayStyle: TextStyle(color: AppColors.whiteColor),
          dayForegroundColor: MaterialStatePropertyAll(AppColors.whiteColor),
          dayStyle: TextStyle(color: AppColors.whiteColor),
          backgroundColor: AppColors.scaffoldBackGroundColor,
          todayBackgroundColor: const MaterialStatePropertyAll(Colors.teal)),
      dialogTheme:
          DialogTheme(backgroundColor: AppColors.scaffoldBackGroundColor ),
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
