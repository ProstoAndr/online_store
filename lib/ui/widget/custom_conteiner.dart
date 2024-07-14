import 'package:flutter/material.dart';
import 'package:online_store/domain/models/product/product_model.dart';

class CustomContainer extends StatelessWidget {
  final ProductModel item;
  final double width;
  final double height;

  const CustomContainer(
      {super.key,
        required this.width,
        required this.height,
        required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  '${item.rating}★',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Center(
                child: SizedBox(
                  height: height - 120,
                  child: Image.network(
                    item.images.first,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(item.category),
                Text(
                  '${item.price} Р',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}