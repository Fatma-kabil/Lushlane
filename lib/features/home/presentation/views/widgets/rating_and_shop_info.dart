import 'package:flutter/material.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/shop_details.dart';

class RatingAndShopInfo extends StatelessWidget {
  const RatingAndShopInfo({
    super.key, required this.pot,
  });
  final PotsModel pot;

  @override
  Widget build(BuildContext context) {
    double rating = pot.rating; // التقييم من 0 إلى 10
    int fullStars = (rating / 2).floor(); // عدد النجوم المملوءة (من 0 إلى 5)
    double fractionalStar = (rating / 2) - fullStars; // الجزء العشري (إذا كان موجودًا)

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          child: Text('New', style: TextStyle(fontSize: 15)),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 4),
        // عرض النجوم المملوءة
        ...List.generate(
          fullStars,
          (index) => Icon(
            Icons.star,
            color: Colors.amber,
            size: 24,
          ),
        ),
        // عرض نصف النجمة إذا كانت موجودة
        if (fractionalStar >= 0.5)
          Icon(
            Icons.star_half,
            color: Colors.amber,
            size: 24,
          ),
        // عرض النجوم الفارغة
        ...List.generate(
          5 - fullStars - (fractionalStar >= 0.5 ? 1 : 0),
          (index) => Icon(
            Icons.star_border,
            color: Colors.grey,
            size: 24,
          ),
        ),
        Spacer(),
        ShopDetails(pot: pot),
      ],
    );
  }
}
