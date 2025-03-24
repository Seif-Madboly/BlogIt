import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatelessWidget {
   const CustomTabBar({super.key, required this.isDarkMode, required this.controller, });
   final bool isDarkMode;
  final  TabController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TabBar(
        controller:controller  ,
        physics: const BouncingScrollPhysics(),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isDarkMode ? Colors.grey[800] : Colors.indigo.shade900,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: isDarkMode ? Colors.grey[400] : Colors.grey,
        labelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.normal,
        ),
        tabs: const [
          Tab(text: 'All News'),
          Tab(text: 'Business'),
          Tab(text: 'Science'),
          Tab(text: 'Sports'),
        ],
      ),
    );
  }
}
