// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';

import '../../main.dart';
import 'cubit/home_cubit.dart';
import 'screens/all_products/index.dart';
import 'screens/product_detail/product_detail.dart';
import 'widgets/product_card.dart';
import 'widgets/sidebar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    // products = (await UserApi.getProducts())!;
    setState(() {});
  }

  getPromo() async {
    // promo = (await UserApi.getPromo())!;
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
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
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
                      ? AppColors.white
                      : AppColors.black,
                ))
          ],
          centerTitle: true,
          title: Text(
            'eMarket',
            style: Theme.of(context).textTheme.headline6,
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeLoading) {
              return LoadingScreen();
            }
            if (state is HomeLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.bodyHorizontalpadding / 1.5),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    _jumbotron(context),
                    _heading(context,
                        heading: 'Clothing', caption: 'Best clothing products'),
                    const SizedBox(height: 10),
                    _imageCardSlider(
                      url: imgList[2],
                      prods: state.products
                          .where((element) => element.category == 'clothing')
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    _heading(context,
                        heading: 'Phones ',
                        caption:
                            'Get thhe mor rescent and up tp date equipment',
                        destination: AllProductsPage()),
                    const SizedBox(height: 10),
                    _imageCardSlider(
                      url: imgList[1],
                      prods: state.products
                          .where((element) => element.category == 'phones')
                          .toList(),
                    ),
                  ],
                )),
              );
            }
            return Center();
          },
        ),
      ),
    );
  }

  Widget _imageCardSlider({
    String? url,
    required List<Product> prods,
  }) {
    return Container(
        height: 282,
        child: ListView.builder(
          itemCount: prods.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                    onTap: () {
                      push(context, ProductDetailPage(product: prods[index]));
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
        TextButton(
            onPressed: () {
              push(context, AllProductsPage());
            },
            child: Text('View all'))
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
                  color: AppColors.buttonColor.withOpacity(0.2),
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
                                ? AppColors.primaryColor
                                : AppColors.primaryColor)
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
