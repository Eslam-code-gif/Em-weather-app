import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TextStyles {
 static TextStyle temperatureStyle(BuildContext context) =>TextStyle(
    color: Theme.of(context).colorScheme.primary,
    fontSize: 50.sp,
    fontWeight: FontWeight.w900,
    fontStyle: FontStyle.italic
  );

  static TextStyle cityNameStyle(BuildContext context)=>TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontSize: 28.sp,
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic
  );

}
class AppColors {
  static Color backgroundLight = Color(0xffffffff);
  static Color primaryLight = Color(0xff000000);

  static Color backgroundDark = Color(0xff000000);
  static Color primaryDark = Color(0xffffffff);

  static Color secondaryDark = Colors.grey.shade700;
  static Color secondaryLight = Colors.grey.shade200;







}