
import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';

class ShopDetails extends StatelessWidget {
  const ShopDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.edit_location, size: 24, color: kPrimaryColor),
        Text('flower shop', style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
