

import 'package:flutter/material.dart';
   import 'package:news_app/core/utils/app_assets.dart';
import 'package:news_app/core/utils/app_colors.dart';

  import 'package:news_app/modules/home/presentation/widget/search_text_field.dart';
import 'package:news_app/modules/search/presentation/screens/search_screen.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key, required this.isDarkMode, required this.searchController, required this.onPressed});
  final bool isDarkMode;
  final TextEditingController searchController;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 60,
      pinned: true,
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      title: Row(
        children: [
          Image.asset(
            AppImageAssets.appLogo,
            height: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SearchTextField(
              controller: searchController,
              fillColor:
                  isDarkMode ? Colors.grey[800] : Colors.deepPurple.shade50,
                  textColor: isDarkMode ? Colors.white : AppColors.primaryColor,
              hintColor: isDarkMode ? Colors.grey[400] : Colors.grey,
              iconColor: isDarkMode ? Colors.grey[400] : Colors.grey,
              onEditingComplete: () {
                if (searchController.text.trim().isNotEmpty) {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                        searchQuery: searchController.text.trim(),
                      ),
                    )
                  );
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.sunny : Icons.dark_mode,
              color: Colors.grey,
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}


