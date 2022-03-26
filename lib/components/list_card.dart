import 'package:flutter/material.dart';
import 'package:shopping_list/config/colors.dart';

const double maxSize = 50;

class ListCard extends StatelessWidget {
  final String image;
  final String title;
  final String date;

  const ListCard({
    Key? key,
    required this.image,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: maxSize + 20,
      child: Card(
        color: colors["purple"],
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CardImage(),
              const SizedBox(width: 8),
              CardContent(title: title, date: date),
            ],
          ),
        ),
      ),
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: maxSize,
      height: maxSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black54,
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String title;
  final String date;

  const CardContent({
    Key? key,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colors["blue"],
          ),
        ),
        Text(
          date,
          style: TextStyle(
            fontSize: 12,
            color: colors["blue-opacity"],
          ),
        ),
      ],
    );
  }
}
