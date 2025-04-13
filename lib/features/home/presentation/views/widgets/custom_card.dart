import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/features/home/presentation/manager/fetch_pots_cubit/cart_cubit.dart/cart_cubit.dart';

class CustomCard extends StatelessWidget {
  CustomCard({super.key, required this.pot});
  final PotsModel pot;

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
                      Text(
                        '\$${pot.price}',
                        style: const TextStyle(fontSize: 15),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          size: 20,
                          color:
                              Colors
                                  .grey[500], // Red if favorited, white if not
                        ),
                        onPressed: () {
                          // إضافة العنصر مع البيانات إلى السلة
                          BlocProvider.of<CartCubit>(context).addToCart(pot);
                        },
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
          bottom: 60,
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: pot.image,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }
}
