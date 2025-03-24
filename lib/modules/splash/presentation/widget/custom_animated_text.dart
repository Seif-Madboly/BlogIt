import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/modules/home/logic/home_cubit.dart';
import 'package:news_app/modules/home/logic/home_state.dart';

class CustomAnimatedText extends StatelessWidget {
  const CustomAnimatedText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final HomeCubit cubit = context.read<HomeCubit>();

        final bool isDarkMode = cubit.getCurrentTheme() == AppThemeMode.dark;

        return DefaultTextStyle(
          style: GoogleFonts.newsCycle(
            fontSize: 30.0.sp,
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText('Blog'),
              TypewriterAnimatedText('BlogIt'),
            ],
          ),
        );
      },
    );
  }
}
