import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:online_market/shop/item_model.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/shop/additem.dart';

class ShopIndex extends StatefulWidget {
  const ShopIndex({Key? key}) : super(key: key);

  @override
  State<ShopIndex> createState() => _ShopIndexState();
}

class _ShopIndexState extends State<ShopIndex> {
   final List<Widget> _children = [
    AddItem(),
  ];
  int _chosen = 0;
  bool _isFavorited = false;
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
            vertical: Constants.bodyHorizontalpadding / 1.5),
        child: SingleChildScrollView(
            child: Column(
          children: [
            _heading(context, heading: 'Sale', caption: 'Super promotion sale'),
            const SizedBox(height: 10),
            _imageCardSlider(url: imgList[1]),
            const SizedBox(height: 20),
            _heading(context,
                heading: 'New ', caption: 'you\'ve never seen it before'),
            const SizedBox(height: 20),
            _imageCardSlider(url: imgList[2]),
          ],
        )),
        
      ),
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            setState(() {
              _chosen = 0;
            });
      },
      backgroundColor: Colors.deepOrangeAccent,
      child: const Icon(Icons.add),
      
       ) ,
    );
  }

  Widget _imageCardSlider({String? url}) {
    return SizedBox(
        // color: Colors.red,
        height: 282,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) => Padding(
                padding: const EdgeInsets.only(left:12.0),
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
                            spreadRadius: 1.0)
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
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          color: Theme.of(context).backgroundColor,
                          height: 130,
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
                          left: 140,
                          top: 160,
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
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                child: IconButton(
                                  icon: Icon(_isFavorited ? Icons.favorite: Icons.favorite_border),
                                  iconSize: 30,
                                  
                                  color: Colors.red[400],
                                  onPressed: (){
                                    setState(() {
                                      _isFavorited = !_isFavorited;
                                    });
                                  }
                                )),
                          )),
                    ],
                  ),
                ),
              )),
        ));
  }

  // Widget buildGridView({String? url})=> GridView.builder(
    
  //   gridDelegate: SilverGridDelegateWithFixedCrossAxisCount(
  //     crossAxisCount:2,
  //     childAspectRatio:1,
  //     mainAxisSpacing: 8,
  //     crossAxisSpacing: 8,
  //   ),
  //   itemBuilder: ((context, index) => Padding(
  //               padding: const EdgeInsets.only(top: 12.0, left: 12.0),
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                     borderRadius: const BorderRadius.only(
  //                       topLeft: Radius.circular(10),
  //                       topRight: Radius.circular(10),
  //                     ),
  //                     boxShadow: [
  //                       BoxShadow(
  //                           color: Colors.grey.withOpacity(0.5),
  //                           blurRadius: 2.0,
  //                           spreadRadius: 0.8)
  //                     ]),
  //                 child: Stack(
  //                   // alignment: Alignment.centerRight,
  //                   children: [
  //                     SizedBox(
  //                       height: 180,
  //                       width: 175,
  //                       child: ClipRRect(
  //                           borderRadius: const BorderRadius.only(
  //                             topLeft: Radius.circular(8),
  //                             topRight: Radius.circular(8),
  //                           ),
  //                           child: CachedNetworkImage(
  //                             imageUrl: url!,
  //                             fit: BoxFit.fill,
  //                           )),
  //                     ),
  //                     Positioned(
  //                       top: 180,
  //                       child: Container(
  //                         padding: const EdgeInsets.symmetric(vertical: 4),
  //                         color: Theme.of(context).backgroundColor,
  //                         height: 100,
  //                         width: 175,
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               'Shop owner',
  //                               style: Theme.of(context).textTheme.caption,
  //                             ),
  //                             Text(
  //                               'Evening dress',
  //                               style: Theme.of(context).textTheme.headline6,
  //                             ),
  //                             Text(
  //                               '10000XAF',
  //                               style: Theme.of(context).textTheme.bodyText1,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     Positioned(
  //                         left: 130,
  //                         top: 160,
  //                         child: Container(
  //                            decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(100),
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                     color: Colors.grey.withOpacity(0.5),
  //                                     blurRadius: 1.0,
  //                                     spreadRadius: 1)
  //                               ]), 
  //                           child: CircleAvatar(
  //                               backgroundColor:
  //                                   Theme.of(context).backgroundColor,
  //                               child: IconButton(
  //                                 icon: Icon(_isFavorited ? Icons.favorite: Icons.favorite_border),
  //                                 iconSize: 30,
                                  
  //                                 color: Colors.red[400],
  //                                 onPressed: (){
  //                                   setState(() {
  //                                     _isFavorited = !_isFavorited;
  //                                   });
  //                                 }
  //                               )),
  //                         )),
  //                   ],
  //                 ),
  //               ),
  //             )),
  //       );

  Widget _heading(BuildContext context,
      {required String heading,
       required String caption,
        Widget? destination}) {
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
        TextButton(onPressed: () {}, child: const Text('View all'))
      ],
    );
  }
}

// class SilverGridDelegateWithFixedCrossAxisCount {
//   CrossAxisAlignment;
// }
