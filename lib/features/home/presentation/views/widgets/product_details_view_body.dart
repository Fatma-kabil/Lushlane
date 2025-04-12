import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/features/home/presentation/views/widgets/rating_and_shop_info.dart';

class ProductDetailsViewBody extends StatefulWidget {
  ProductDetailsViewBody({super.key, required this.pot});
  final PotsModel pot;

  @override
  State<ProductDetailsViewBody> createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody> {
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
      child: SingleChildScrollView(
        child: Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey[100],
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget.pot.image,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 300,
                //     width: 20,
              ),
            ),
            SizedBox(height: 11),
            Text(
              '\$${widget.pot.price}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 11),
            RatingAndShopInfo(pot: widget.pot),

            SizedBox(height: 11),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Details :', style: TextStyle(fontSize: 22)),
            ),
            SizedBox(height: 11),
            Text(
              widget.pot.description,
              style: TextStyle(fontSize: 17),
              maxLines: isShowMore ? 5 : null,
              overflow: TextOverflow.fade,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isShowMore = !isShowMore;
                });
              },
              child: Text(isShowMore ? "Show more" : "Show less"),
            ),
          ],
        ),
      ),
    );
  }
}
