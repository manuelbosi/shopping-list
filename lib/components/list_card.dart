import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/config/colors.dart';
import 'package:shopping_list/models/list.dart';

const double maxSize = 50;

class ListCard extends StatelessWidget {
  final ListModel list;

  const ListCard({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: maxSize + 20,
      child: Card(
        color: ColorPalette.purple,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardImage(image: list.market!.imageUrl),
              const SizedBox(width: 8),
              CardContent(title: list.name, date: list.createdAt),
            ],
          ),
        ),
      ),
    );
  }
}

class CardImage extends StatelessWidget {
  final String image;
  const CardImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      imageUrl: image,
      width: maxSize,
      errorWidget: (context, url, error) => const Icon(Icons.error),
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
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorPalette.blue,
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 12,
            color: ColorPalette.blueOpacity,
          ),
        ),
      ],
    );
  }
}
