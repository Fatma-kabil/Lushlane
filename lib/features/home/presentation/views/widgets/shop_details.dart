
import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';

class ShopDetails extends StatelessWidget {
  const ShopDetails({
    super.key, required this.pot,
  });
   final PotsModel pot;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.edit_location, size: 24, color: kPrimaryColor),
        Text(pot.shopName, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
