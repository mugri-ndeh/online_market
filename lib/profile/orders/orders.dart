import 'package:flutter/material.dart';
import 'package:online_market/profile/orders/order_details.dart';
import 'package:online_market/profile/widgets.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
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
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
              const SizedBox(height: 16),
              Text(
                'My Orders',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _topTab(context, 0, 'Pending'),
                  _topTab(context, 1, 'Completed'),
                  _topTab(context, 2, 'Cancelled'),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: IndexedStack(
                index: _selectedIndex,
                children: [_pending(), _completed(), _cancelled()],
              ))
            ],
          ),
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
                    color: const Color.fromARGB(255, 228, 222, 222).withOpacity(0.2),
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
                    color: const Color.fromARGB(255, 228, 222, 222).withOpacity(0.2),
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

  Widget _pending() {
    return SingleChildScrollView(
        child: Column(
      children: [_orderCard(state: 'Pending', color: Palette.grey)],
    ));
  }

  Widget _orderCard({required String state, required Color color}) {
    return elevatedContainer(
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
                  onPressed: () {
                    push(context, const OrderDetails());
                  },
                  style: OutlinedButton.styleFrom(
                    primary: Theme.of(context).iconTheme.color,
                    side: BorderSide(color: Theme.of(context).iconTheme.color!),
                  ),
                  child: const Text('Details'),
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
                  state,
                  style: TextStyle(color: color),
                ),
              ],
            )
          ],
        ));
  }

  Widget _completed() {
    return Column(
      children: [_orderCard(state: 'Completed', color: Palette.success)],
    );
  }

  Widget _cancelled() {
    return Column(
      children: [_orderCard(state: 'Cancelled', color: Palette.error)],
    );
  }
}
