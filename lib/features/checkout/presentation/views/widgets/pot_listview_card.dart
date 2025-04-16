import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lushlane_app/features/home/data/models/pots_model.dart';
import 'package:lushlane_app/features/home/presentation/manager/fetch_pots_cubit/cart_cubit.dart/cart_cubit.dart';

class PotListViewCard extends StatelessWidget {
  const PotListViewCard({super.key, required this.item});

  final PotsModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.image,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '\$${item.price.toStringAsFixed(2)}',
          style: TextStyle(color: Colors.green[700]),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.blueGrey),
          onPressed: () {
            BlocProvider.of<CartCubit>(context).removeFromCart(item);
          },
        ),
      ),
    );
  }
}
