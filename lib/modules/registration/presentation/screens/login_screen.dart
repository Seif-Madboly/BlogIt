import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/config/router/app_router.dart';
import 'package:news_app/core/utils/app_assets.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/modules/home/logic/home_cubit.dart';
import 'package:news_app/modules/home/logic/home_state.dart';
import 'package:news_app/modules/registration/presentation/widget/custom_Button.dart';
import 'package:news_app/modules/registration/presentation/widget/custom_text_form_field.dart';
import 'package:news_app/modules/registration/presentation/widget/login_password_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final isDarkMode = cubit.getCurrentTheme() == AppThemeMode.dark;
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset(
                      AppImageAssets.appLogo,
                      height: 100.h,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "Sign In",
                      style: GoogleFonts.openSans(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                        fillColor: isDarkMode
                            ? Colors.grey.shade700
                            : Colors.deepPurple.shade50,
                        controller: emailController,
                        hintText: "Email",
                        type: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          } else if (!value.contains("@gmail.com")) {
                            return 'Incorrect email format';
                          }
                          return null;
                        },
                        focusNode: FocusNode(),
                        textInputAction: TextInputAction.next),
                    const SizedBox(height: 20),
                    LoginPasswordWidget(
                      fillColor: isDarkMode
                          ? Colors.grey.shade700
                          : Colors.deepPurple.shade50,
                      controller: passwordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Add forgot password logic here
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.white
                                : AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            letterSpacing: 1.sp,
                          ),
                        ),
                      ),
                    ),
                    CustomButton(
                      text: 'Sign In',
                      backgroundColor: isDarkMode
                          ? Colors.grey.shade800
                          : AppColors.primaryColor,
                      onPress: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.homeRoute,
                          (route) => false,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            letterSpacing: 1.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.signUpRoute);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: isDarkMode ? Colors.grey : AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              letterSpacing: 1.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
