import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/data/methods/string_to_date.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({
    super.key,
    required this.titleColor,
    required this.subtitleColor,
    required this.title,
    required this.publishedAt,
    required this.image,
    required this.onTap,
  });
  final Color titleColor;
  final Color subtitleColor;
  final String title;
  final String publishedAt;
  final String image;
  void Function()? onTap;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 6),
      child: ListTile(
          leading: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
              maxWidth: 80,
              maxHeight: 80,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      strokeWidth: 3,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.openSans(
                color: titleColor,
                fontWeight: FontWeight.w600,
                fontSize: 13.sp),
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
          subtitle: Text(
            formateDate(publishedAt),
             style: TextStyle(fontSize: 14, color: subtitleColor),
          ),
          trailing: const Icon(Icons.share_outlined),
          onTap: onTap),
    );
  }
}
