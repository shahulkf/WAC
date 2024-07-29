import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/features/home/model/model.dart';
import 'package:task/features/home/utils/constants/constants.dart';

class ProductWidget extends StatelessWidget {
  final List<Content> products;
  final String title;
  const ProductWidget(this.products, {super.key, required this.title});

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
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
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
          height: screenFullHeight * .28,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItem(products[index]);
            },
          ),
        ),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final Content product;

  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: screenFullWidth * .360,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: .5, color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    height: 85.w,
                    imageUrl: product.productImage!,
                  ),
                ),
                kHeight10,
                if (product.discount != null && product.discount!.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        'Sales${product.discount!}',
                        style: TextStyle(fontSize: 10.sp, color: Colors.black),
                      ),
                    ),
                  ),
                kHeight10,
                Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  product.productName!,
                  style:
                      TextStyle(fontSize: 8.5.sp, fontWeight: FontWeight.w400),
                ),
                // const Spacer(),
                RatingStars(
                  value: product.productRating?.toDouble() ?? 0.0,
                  onValueChanged: (v) {},
                  starBuilder: (index, color) => Icon(
                    Icons.star,
                    color: color,
                    size: 12.sp,
                  ),
                  maxValue: 5,
                  starSpacing: .5,
                  maxValueVisibility: true,
                  valueLabelVisibility: false,
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Colors.orangeAccent,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.offerPrice!.replaceAll('â¹', "₹ "),
                      style: TextStyle(color: Colors.black, fontSize: 10.sp),
                    ),
                    kWidth10,
                    if (product.actualPrice != product.offerPrice)
                      Text(
                        product.actualPrice!.replaceAll('â¹', "₹ "),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.sp,
                          decoration: TextDecoration.lineThrough,
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
  }
}
