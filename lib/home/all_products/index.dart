import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_market/api/api.dart';
import 'package:online_market/favourites/favourites_provider.dart';
import 'package:online_market/model/category.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/services/common/common_api.dart';
import 'package:online_market/services/customer/customer_api.dart';
import 'package:online_market/util/palette.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatefulWidget {
  AllProductsScreen({Key? key}) : super(key: key);

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  List<Category> categories = [];
  List<Product> products = [];
  Future getCategories() async {
    categories = await CommonApi.getCatgories();
  }

  Future getProducts() async {
    products = (await UserApi.getProducts())!;
  }

  List<Product> getListPro() {
    List<Product> prods = products
        .where((element) =>
            element.category == categories[_selectedIndex].categoryName)
        .toList();
    return prods;
  }

  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories().then((value) {
      getProducts().then((value) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        title: Text(
          'All Products',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (c, i) =>
                      _topTab(c, i, categories[i].categoryName)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: getListPro().length,
                itemBuilder: (c, i) {
                  return ProductCardExtended(
                    product: getListPro()[i],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector _topTab(BuildContext context, int index, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        decoration: _selectedIndex == index
            ? BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Palette.black
                    : Palette.scaffoldBg,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1, 2),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 3,
                    spreadRadius: 1,
                    color: const Color.fromARGB(255, 228, 222, 222)
                        .withOpacity(0.2),
                  ),
                ],
              )
            : BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Palette.scaffoldBg
                    : Palette.black,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(1, 2),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 3,
                    spreadRadius: 1,
                    color: const Color.fromARGB(255, 228, 222, 222)
                        .withOpacity(0.2),
                  ),
                ],
              ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: _selectedIndex == index
                ? TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Palette.white
                        : Palette.black,
                  )
                : TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Palette.black
                        : Palette.white,
                  ),
          ),
        ),
      ),
    );
  }
}

class ProductCardExtended extends StatelessWidget {
  const ProductCardExtended({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Consumer<FavouritesHelper>(builder: (_, fav, __) {
        return Container(
          decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 2.0,
                    spreadRadius: 0.8)
              ]),
          child: Row(
            // alignment: Alignment.centerRight,
            children: [
              Container(
                color: Palette.white,
                height: 150,
                width: 200,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: Api.rootFolder + product.image,
                      fit: BoxFit.contain,
                    )),
              ),
              Container(
                width: 1,
                height: 150,
                color: Colors.grey,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      color: Theme.of(context).backgroundColor,
                      height: 100,
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shop owner',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            product.price + 'XAF',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 1.0,
                                  spreadRadius: 1)
                            ]),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).backgroundColor,
                          child: GestureDetector(
                            onTap: () {
                              !fav.isfavourite(product)
                                  ? fav.addFavourites(product)
                                  : fav.remove(product);
                            },
                            child: Icon(
                              fav.isfavourite(product)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Palette.primaryColor,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
