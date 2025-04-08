
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.grey.withOpacity(.10),
                offset: const Offset(1, 3),
                spreadRadius: 1,
              ),
              //   BoxShadow(
              //     blurRadius: 0,
              //   color: Colors.white,
              // offset: Offset(-3, -3),
              //  spreadRadius: 0),
            ],
          ),
          child: Card(
            elevation: 3,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$105', style: const TextStyle(fontSize: 16)),
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color:
                              Colors
                                  .grey[500], // Red if favorited, white if not
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 32,
          bottom: 85,
          child: Image.asset(
            'assets/images/test.png',
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }
}
