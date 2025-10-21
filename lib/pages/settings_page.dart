import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:minimal_weather_app/theme/theme_provider.dart';
import '../const/styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final currentOption = themeProvider.themeOption;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyles.cityNameStyle(context),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 80.h),
            Text(
              "Choose Theme",
              style: TextStyles.cityNameStyle(context),
            ),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildThemeOption(
                  context,
                  icon: Icons.light_mode,
                  label: "Light",
                  selected: currentOption == ThemeOption.light,
                  activeColor: Colors.blue,
                  onTap: () => themeProvider.setTheme(ThemeOption.light),
                ),
                SizedBox(width: 15.w),
                _buildThemeOption(
                  context,
                  icon: Icons.dark_mode,
                  label: "Dark",
                  selected: currentOption == ThemeOption.dark,
                  activeColor: const Color(0xff181818),
                  onTap: () => themeProvider.setTheme(ThemeOption.dark),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            _buildThemeOption(
              context,
              icon: Icons.brightness_auto,
              label: "System",
              selected: currentOption == ThemeOption.system,
              activeColor: Colors.deepPurple,
              onTap: () => themeProvider.setTheme(ThemeOption.system),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
      BuildContext context, {
        required IconData icon,
        required String label,
        required bool selected,
        required VoidCallback onTap,
        required Color activeColor,
      }) {
    final unselectedColor = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(15.sp),
        width: 130.w,
        height: 130.h,
        decoration: BoxDecoration(
          color: selected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: selected ? activeColor : Colors.grey.shade400,
            width: 2,
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              color: activeColor.withOpacity(0.4),
              blurRadius: 12,
              spreadRadius: 2,
            )
          ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40.sp,
              color: selected ? Colors.white : unselectedColor,
            ),
            SizedBox(height: 10.h),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : unselectedColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
