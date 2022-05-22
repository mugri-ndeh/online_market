import 'package:flutter/material.dart';
import 'package:online_market/profile/widgets.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.bodyHorizontalpadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Orders',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Palette.black
                          : Palette.scaffoldBg,
                      borderRadius: BorderRadius.circular(80),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 2),
                          blurStyle: BlurStyle.outer,
                          blurRadius: 3,
                          spreadRadius: 1,
                          color: Color.fromARGB(255, 228, 222, 222)
                              .withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Pending',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Palette.white
                                    : Palette.black,
                          )),
                    ),
                  ),
                  Text(
                    'Completed',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    'Cancelled',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: IndexedStack(
                children: [_pending(), _completed(), _cancelled()],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _pending() {
    return SingleChildScrollView(
        child: Column(
      children: [
        elevatedContainer(
            context: context,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order number',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Quantity: 3',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text('Details'),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      'Total Amount: 10000XAF',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      'Pending',
                      style: TextStyle(color: Palette.primaryColor),
                    ),
                  ],
                )
              ],
            ))
      ],
    ));
  }

  Widget _completed() {
    return Column();
  }

  Widget _cancelled() {
    return Column();
  }
}
