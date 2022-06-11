import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_market/api/api.dart';
import 'package:online_market/auth/models/user_model.dart';
import 'package:online_market/auth/providers/auth_provider.dart';
import 'package:online_market/model/shop.dart';
import 'package:online_market/services/seller/seller_api.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddShoppage extends StatefulWidget {
  AddShoppage({Key? key}) : super(key: key);

  @override
  State<AddShoppage> createState() => _AddShoppageState();
}

class _AddShoppageState extends State<AddShoppage> {
  String imageUrl = '';
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late UserModel user;

  File? _image;
  final picker = ImagePicker();

  // Future chooseImage() async {
  //   var pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = File(pickedImage!.path);
  //   });
  // }

  Future uploadImage() async {
    final uri = Uri.parse(SellerApi.uploadImage);
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = _nameController.text;

    var pic = await http.MultipartFile.fromPath("image", _image!.path);
    request.files.add(pic);

    // var response = await request.send();

    http.Response response =
        await http.Response.fromStream(await request.send());
    print("Result: ${response.body}");
    // return response.body;

    // final response = await http.

    if (response.statusCode == 200) {
      // print(response)
      print('File sent');
    } else {
      print('an error was encountered');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = Provider.of<Authentication>(context, listen: false).loggedUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        title: Text(
          'Add a shop',
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                validator: (val) => val!.isEmpty ? 'Please input a name' : null,
                decoration: getInputDecoration(
                    hint: 'Shop name',
                    darkMode: Theme.of(context).brightness == Brightness.dark,
                    errorColor: Palette.error),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Text(
                'Add an image',
                style: Theme.of(context).textTheme.headline4,
              ),
              _image == null
                  ? GestureDetector(
                      onTap: () async {
                        _image = await chooseImage();
                        setState(() {});
                      },
                      child:
                          imgplace(context: context, height: 100, width: 100))
                  : Image.file(_image!),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomOutlinedButton(
                  child: Text('Create Shop'),
                  onTap: () async {
                    // uploadImage();
                    if (_formKey.currentState!.validate()) {
                      if (_image == null) {
                        showSnackBar(context, 'Please select an image');
                      } else {
                        Shop shop = Shop(
                          name: _nameController.text,
                          shopImg: imageUrl,
                          sellerName: user.uid.toString(),
                        );
                        print('OK');
                        showProgress(
                            context, 'Creating shop please wait', true);
                        await SellApi.addShop(shop, _image!);
                        hideProgress();
                      }
                    }
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
