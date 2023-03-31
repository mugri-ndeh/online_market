import 'package:flutter/material.dart';

class SellerRating extends StatefulWidget {
  const SellerRating({Key? key}) : super(key: key);

  @override
  State<SellerRating> createState() => _SellerRatingState();
}

class _SellerRatingState extends State<SellerRating> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        title: const Text(
          'My Reviews',
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: const [],
      ),
    );
  }
}
