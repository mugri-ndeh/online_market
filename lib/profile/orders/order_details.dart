import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_market/profile/widgets.dart';
import 'package:online_market/util/contstants.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Order details',
          style: Theme.of(context).textTheme.headline5,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.bodyHorizontalpadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('order number'),
                  const Text('date'),
                ],
              ),
              const Text('Status'),
              const Text('item count'),
              elevatedContainer(
                  context: context,
                  padding: 0,
                  child: SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Title'),
                              const Text('caption'),
                              const Text('detail'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('item count'),
                                  Text('Price'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
