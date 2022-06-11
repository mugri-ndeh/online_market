// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_market/auth/models/user_model.dart';
import 'package:online_market/home/product_detail.dart';
import 'package:online_market/home/widgets/product_card.dart';
import 'package:online_market/home/widgets/sidebar.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/services/common/common_api.dart';
import 'package:online_market/services/customer/customer_api.dart';
import 'package:online_market/shop/details.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> imgList = [
    'https://m.media-amazon.com/images/I/71vvXGmdKWL._AC_SL1500_.jpg',
    'https://m.media-amazon.com/images/I/71Ps25MnkNL._AC_UY575_.jpg',
    'https://m.media-amazon.com/images/I/817aOXLoNpL._AC_SL1500_.jpg',
    'https://m.media-amazon.com/images/I/71rXSVqET9L._AC_SL1257_.jpg'
  ];

  List<Product> promo = [];
  List<Product> products = [];

  getProducts() async {
    products = (await UserApi.getProducts())!;
    setState(() {});
  }

  getPromo() async {
    promo = (await UserApi.getPromo())!;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
    getPromo();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showCustomSearch(context, size);
              },
              icon: Icon(
                Icons.search,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Palette.white
                    : Palette.black,
              ))
        ],
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            getPromo();
          },
          child: Text(
            'eMarket',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Theme.of(context).brightness == Brightness.dark
                ? Palette.white
                : Palette.black,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
            print("TAOPPED");
          },
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.bodyHorizontalpadding / 1.5),
        child: SingleChildScrollView(
            child: Column(
          children: [
            _jumbotron(context),
            _heading(context, heading: 'Sale', caption: 'Super promotion sale'),
            const SizedBox(height: 10),
            _imageCardSlider(url: imgList[2], prods: promo),
            const SizedBox(height: 20),
            _heading(context,
                heading: 'New ', caption: 'you\'ve never seen it before'),
            const SizedBox(height: 10),
            _imageCardSlider(url: imgList[1], prods: products),
          ],
        )),
      ),
    );
  }

  Widget _imageCardSlider({
    String? url,
    required List<Product> prods,
  }) {
    return SizedBox(
        // color: Colors.red,
        height: 282,
        child: ListView.builder(
          itemCount: prods.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                    onTap: () {
                      push(context, ProductDetail(product: prods[index]));
                    },
                    child: ProductCard(product: prods[index])),
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
