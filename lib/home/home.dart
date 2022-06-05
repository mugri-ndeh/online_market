// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.bodyHorizontalpadding / 1.5),
        child: SingleChildScrollView(
            child: Column(
          children: [
            _jumbotron(context),
            _heading(context, heading: 'Sale', caption: 'Super promotion sale'),
            const SizedBox(height: 10),
            _imageCardSlider(url: imgList[2]),
            const SizedBox(height: 20),
            _heading(context,
                heading: 'New ', caption: 'you\'ve never seen it before'),
            const SizedBox(height: 10),
            _imageCardSlider(url: imgList[1]),
          ],
        )),
      ),
    );
  }

  Widget _imageCardSlider({String? url}) {
    return SizedBox(
        // color: Colors.red,
        height: 282,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 2.0,
                            spreadRadius: 1)
                      ]),
                  child: Stack(
                    // alignment: Alignment.centerRight,
                    children: [
                      SizedBox(
                        height: 180,
                        width: 175,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: url!,
                              fit: BoxFit.fill,
                            )),
                      ),
                      Positioned(
                        top: 180,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          color: Theme.of(context).backgroundColor,
                          height: 100,
                          width: 175,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shop owner',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              Text(
                                'Evening dress',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                '10000XAF',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          left: 130,
                          top: 160,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 2.0,
                                      spreadRadius: 1)
                                ]),
                            child: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                child: Icon(FontAwesomeIcons.heart)),
                          )),
                    ],
                  ),
                ),
              )),
        ));
  }

  Widget _heading(BuildContext context,
      {required String heading, required String caption, Widget? destination}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              caption,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
        TextButton(onPressed: () {}, child: Text('View all'))
      ],
    );
  }

  Widget _jumbotron(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        alignment: Alignment.bottomCenter,
        children: [
          CarouselSlider(
            items: imgList
                .map((item) => Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(imageUrl: item)),
                    ))
                .toList(),
            carouselController: _controller,
            options: CarouselOptions(
                enableInfiniteScroll: false,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 4 / 3,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Positioned(
            top: 150,
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                  color: Palette.buttonColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  'HOT SALE',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Palette.primaryColor
                                : Palette.primaryColor)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
