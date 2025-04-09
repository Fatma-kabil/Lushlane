import 'package:flutter/material.dart';
import 'package:lushlane_app/constants.dart';

class ProductDetailsViewBody extends StatefulWidget {
  ProductDetailsViewBody({super.key});

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
              child: Image.asset(
                'assets/images/test.png',
                height: 300,
                //     width: 20,
              ),
            ),
            SizedBox(height: 11),
            Text(
              '\$105',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 11),
            Row(
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
                Row(
                  children: [
                    Icon(Icons.edit_location, size: 24, color: kPrimaryColor),
                    Text('flower shop', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),

            SizedBox(height: 11),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Details :', style: TextStyle(fontSize: 22))),
            SizedBox(height: 11),
            Text(
              'A flower, also known as a bloom or blossom,[1] is the reproductive structure found in flowering plants (plants of the division Angiospermae). Flowers consist of a combination of vegetative organs – sepals that enclose and protect the developing flower. Petals attract pollinators, and reproductive organs that produce gametophytes, which in flowering plants produce gametes. The male gametophytes, which produce sperm, are enclosed within pollen grains produced in the anthers. The female gametophytes are contained within the ovules produced in the ovary.[2][3] In some plants, multiple flowers occur singly on a pedicel (flower stalk), and some are arranged in a group (inflorescence) on a peduncle (inflorescence stalk)',
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
