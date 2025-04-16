import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/core/utils/functions/get_location.dart';

class ShopDetails extends StatelessWidget {
  const ShopDetails({super.key, required this.pot});

  final PotsModel pot;

  // دالة تفتح جوجل مابس بالعنوان

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await OpenMap(
          location: pot.location,
        ); // هنا استخدم await لاستدعاء الدالة
      },

      child: Row(
        children: [
          Icon(Icons.edit_location, size: 24, color: kPrimaryColor),
          const SizedBox(width: 6),
          Text(pot.shopName, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
