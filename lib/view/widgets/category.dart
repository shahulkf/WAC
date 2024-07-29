

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/model/model.dart';
import 'package:task/utils/constants/constants.dart';

class CategoryWidget extends StatelessWidget {
  final List<Content> categories;

  const CategoryWidget(this.categories, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Categories',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
              Text(
                'View all',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: screenFullHeight * .12,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryItem(categories[index]);
            },
          ),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Content category;

  const CategoryItem(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenFullWidth * .212,
            height: screenFullHeight * .1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: .5, color: Colors.grey),
            ),
            // child:   const SizedBox(height: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: screenFullHeight * .06,
                    width: screenFullWidth * .12,
                    child: CachedNetworkImage(
                      imageUrl: category.imageUrl!,
                    )),
                Text(category.title!, style: TextStyle(fontSize: 10.sp)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}