import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:online_market/model/category.dart';
import 'package:online_market/model/product.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/services/common/common_api.dart';
import 'package:online_market/services/seller/seller_api.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';

class AddProductsPage extends StatefulWidget {
  const AddProductsPage({Key? key, required this.shop}) : super(key: key);
  final Shop shop;

  @override
  State<AddProductsPage> createState() => _AddProductsPageState();
}

class _AddProductsPageState extends State<AddProductsPage> {
  int? selectedId;
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  String imageUrl = 'null actually';
  String? selectedValue;
  List<Category> categories = [];

  Future getCategories() async {
    categories = await CommonApi.getCatgories();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories().then((value) => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        title: Text(
          'Add a Product',
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: _nameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please add a name' : null,
                  decoration: getInputDecoration(
                      hint: 'Product name',
                      darkMode: Theme.of(context).brightness == Brightness.dark,
                      errorColor: Palette.error),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Please add a price' : null,
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: getInputDecoration(
                      hint: 'Price',
                      darkMode: Theme.of(context).brightness == Brightness.dark,
                      errorColor: Palette.error),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) =>
                      value!.isEmpty ? 'Please fill quantity' : null,
                  controller: _qtyController,
                  keyboardType: TextInputType.number,
                  decoration: getInputDecoration(
                      hint: 'Quantity',
                      darkMode: Theme.of(context).brightness == Brightness.dark,
                      errorColor: Palette.error),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Select category',
                              style: TextStyle(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: categories
                          .map((item) => DropdownMenuItem<String>(
                                value: item.categoryName,
                                child: Text(
                                  item.categoryName.toUpperCase(),
                                  style: Theme.of(context).textTheme.bodyText2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                          for (var item in categories) {
                            if (item.categoryName == value) {
                              selectedId = item.id;
                            }
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                      ),
                      iconSize: 14,
                      selectedItemHighlightColor: Palette.buttonColor,
                      iconEnabledColor: Theme.of(context).iconTheme.color,
                      iconDisabledColor: Colors.grey,
                      buttonHeight: 50,
                      buttonWidth: 160,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Palette.buttonColor.withOpacity(0.3),
                        ),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      buttonElevation: 0,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 300,
                      dropdownWidth: MediaQuery.of(context).size.width * 0.96,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Palette.white.withOpacity(0.9),
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 2,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(0, 0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Add an image',
                  style: Theme.of(context).textTheme.headline4,
                ),
                imgplace(context: context, height: 100, width: 100),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomOutlinedButton(
                    child: Text('Add Product'),
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        if (selectedId == null) {
                          showSnackBar(context, 'Select category');
                        } else {
                          Product product = Product(
                            name: _nameController.text,
                            price: _priceController.text,
                            qty: int.parse(_qtyController.text),
                            category: selectedId.toString(),
                            image: imageUrl,
                          );
                          showProgress(
                              context, 'Adding product please wait', true);
                          SellApi.addProduct(product, widget.shop.id)
                              .then((value) {
                            hideProgress();
                            hideProgress();
                            hideProgress();
                          });
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
