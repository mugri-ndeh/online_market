import 'package:flutter/material.dart';
import 'package:online_market/model/order.dart';
import 'package:online_market/services/customer/customer_api.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:provider/provider.dart';

import '../../../../model/user_model.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../widgets.dart';
import 'order_details.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int _selectedIndex = 0;

  late UserModel user;
  List<Order> orders = [];
  List<Order> pending = [];
  List<Order> completed = [];
  List<Order> cancelled = [];

  Future getOrders() async {
    orders = await UserApi.getOrders(user);
    print('HEHEHEHHE');
    print(orders.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<Authentication>(context, listen: false).loggedUser!;
    getOrders().then((value) {
      for (var order in orders) {
        switch (order.state) {
          case 'pending':
            pending.add(order);

            break;
          case 'completed':
            completed.add(order);

            break;
          case 'cancelled':
            cancelled.add(order);

            break;
          default:
        }
      }
      setState(() {});
    });
  }

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
                children: [
                  _pending(orders: pending),
                  _completed(orders: completed),
                  _cancelled(orders: cancelled)
                ],
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
                    ? AppColors.black
                    : AppColors.scaffoldBg,
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
                    ? AppColors.scaffoldBg
                    : AppColors.black,
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
                        ? AppColors.white
                        : AppColors.black,
                  )
                : TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.black
                        : AppColors.white,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _pending({required List<Order> orders}) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: orders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return orders.isEmpty
                    ? Center(
                        child: Text('No orderes here'),
                      )
                    : _orderCard(
                        state: orders[index].state,
                        color: AppColors.grey,
                        order: orders[index]);
              }),
        )
      ],
    );
  }

  Widget _orderCard(
      {required String state, required Color color, Order? order}) {
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
                  'Quantity: ' + order!.quantity.toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                OutlinedButton(
                  onPressed: () {
                    push(
                        context,
                        OrderDetails(
                          order: order,
                        ));
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
                  order.date,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  'Total Amount: ${order.priceTotal}XAF',
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

  Widget _completed({required List<Order> orders}) {
    return ListView.builder(
        itemCount: orders.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return orders.isEmpty
              ? Center(
                  child: Text('No orderes here'),
                )
              : _orderCard(
                  state: orders[index].state,
                  color: AppColors.success,
                  order: orders[index]);
        });
  }

  Widget _cancelled({required List<Order> orders}) {
    return ListView.builder(
        itemCount: orders.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return orders.isEmpty
              ? Center(
                  child: Text('No orderes here'),
                )
              : _orderCard(
                  state: orders[index].state,
                  color: AppColors.error,
                  order: orders[index]);
        });
  }
}
