// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:online_market/auth/models/location.dart';
import 'package:online_market/auth/providers/auth_provider.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class CompleteProfile extends StatefulWidget {
  CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _quarterController = TextEditingController();

  AccountType accountType = AccountType.customer;
  bool customerCheck = true;
  bool sellerCheck = false;
  bool bothCheck = false;

  String initialCountry = 'CM';
  String? locale;
  String number = '';

  final _formKey = GlobalKey<FormState>();
  late Authentication auth;
  late UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = Provider.of<Authentication>(context, listen: false);
    userModel = auth.loggedUser!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.bodyHorizontalpadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Complete Profile',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      IconButton(
                          onPressed: () {
                            auth.returnUser(userModel.uid).then((value) =>
                                value!.completedProfile
                                    ? auth.setAuthState(AuthState.loggedIn)
                                    : auth.setAuthState(AuthState.incomplete));
                          },
                          icon: Icon(Icons.refresh))
                    ],
                  ),
                  const SizedBox(height: Constants.bigAuthSpace / 2),
                  Constants.formBox(
                    context: context,
                    child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _firstNameController,
                        decoration: Constants.inputDecoration('first name')),
                  ),
                  const SizedBox(height: 10),
                  Constants.formBox(
                    context: context,
                    child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _lastNameController,
                        decoration: Constants.inputDecoration('last name')),
                  ),
                  const SizedBox(height: 10),
                  Constants.formBox(
                    context: context,
                    child: IntlPhoneField(
                      style: Theme.of(context).textTheme.bodyText2,
                      controller: _phoneNumberController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      dropdownIconPosition: IconPosition.leading,
                      initialCountryCode: initialCountry,
                      pickerDialogStyle: PickerDialogStyle(),
                      decoration: const InputDecoration(
                        // hintText: 'Phone Number',
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (phone) {
                        print(phone.completeNumber);
                        setState(() {
                          number = phone.completeNumber;
                        });
                      },
                      onCountryChanged: (country) {
                        print('Country changed to: ' + country.name);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      //mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.05,
                          height: 2,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Palette.primaryColor),
                          ),
                        ),
                        const Text(
                          'Choose account type',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.05,
                          height: 2,
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Palette.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Customer', style: TextStyle(fontSize: 20)),
                      Checkbox(
                        activeColor: Palette.primaryColor,
                        value: customerCheck,
                        onChanged: (val) {
                          setState(() {
                            customerCheck = true;
                            bothCheck = false;
                            sellerCheck = false;
                            accountType = AccountType.customer;
                          });
                        },
                      ),
                      const Text('Seller', style: TextStyle(fontSize: 20)),
                      Checkbox(
                        activeColor: Palette.primaryColor,
                        value: sellerCheck,
                        onChanged: (val) {
                          setState(() {
                            sellerCheck = true;
                            bothCheck = false;
                            customerCheck = false;
                            accountType = AccountType.seller;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Constants.formBox(
                    context: context,
                    child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _regionController,
                        decoration: Constants.inputDecoration('region')),
                  ),
                  const SizedBox(height: 10),
                  Constants.formBox(
                    context: context,
                    child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _townController,
                        decoration: Constants.inputDecoration('town')),
                  ),
                  const SizedBox(height: 10),
                  Constants.formBox(
                    context: context,
                    child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText2,
                        controller: _quarterController,
                        decoration: Constants.inputDecoration('quarter')),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                      child: const Text('Finish'),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          var firstNameGood = validateGivenNames(
                              _firstNameController.text, true);
                          var lastNameGood = validateGivenNames(
                              _firstNameController.text, false);
                          var regionGood = validateLocation(
                              _regionController.text, 'region');

                          var townGood =
                              validateLocation(_townController.text, 'town');

                          var quarterGood = validateLocation(
                              _quarterController.text, 'quarter');

                          if (firstNameGood != null) {
                            showSnackBar(context, firstNameGood);
                          } else if (lastNameGood != null) {
                            showSnackBar(context, lastNameGood);
                          } else if (regionGood != null) {
                            showSnackBar(context, regionGood);
                          } else if (townGood != null) {
                            showSnackBar(context, townGood);
                          } else if (quarterGood != null) {
                            showSnackBar(context, quarterGood);
                          } else {
                            UserLocation location = UserLocation(
                                id: userModel.uid.toString(),
                                region: _regionController.text,
                                town: _townController.text,
                                quarter: _quarterController.text);
                            userModel.firstName = _firstNameController.text;
                            userModel.lastName = _lastNameController.text;
                            userModel.phoneNumber = _phoneNumberController.text;
                            userModel.completedProfile = true;
                            userModel.location = location.toJson();
                            userModel.accountType = accountType.toString();
                            showProgress(context, 'Saving data.. ', true);
                            auth
                                .completeProfile(userModel)
                                .then((value) => hideProgress());
                            showSnackBar(context, 'OK');
                          }
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
