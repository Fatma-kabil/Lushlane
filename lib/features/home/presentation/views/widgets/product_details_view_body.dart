import 'package:flutter/material.dart';

class ProductDetailsViewBody extends StatelessWidget {
  const ProductDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
      child: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
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
                  Icon(Icons.edit_location, size: 24),
                  Text('flower shop', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
