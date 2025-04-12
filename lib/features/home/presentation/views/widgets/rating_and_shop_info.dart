
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
        ...List.generate(
          5,
          (index) => Icon(Icons.star, color: Colors.amber, size: 24),
        ),
        Spacer(),
        ShopDetails(pot: pot,),
      ],
    );
  }
}
