import 'package:flutter/material.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:online_market/auth/models/user_model.dart';
import 'package:online_market/auth/providers/auth_provider.dart';
import 'package:online_market/services/common/common_api.dart';
import 'package:online_market/services/customer/customer_api.dart';
import 'package:online_market/util/contstants.dart';
import 'package:online_market/util/helper.dart';
import 'package:online_market/util/palette.dart';
import 'package:online_market/util/widgets/custom_buttons.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String initialCountry = 'CM';
  String? locale;
  final TextEditingController _controller = TextEditingController();
  String number = '';
  late Authentication auth;
  late UserModel user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = Provider.of<Authentication>(context, listen: false);
    user = auth.loggedUser!;
    _usernameController.text = user.username;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email;
    _controller.text = user.phoneNumber.replaceAll('+237', '').trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Edit profile'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Palette.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/illustration-1.png',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Constants.formBox(
                  context: context,
                  child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText2,
                      controller: _usernameController,
                      decoration: Constants.inputDecoration('username')),
                ),
                const SizedBox(height: 8),
                Constants.formBox(
                  context: context,
                  child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText2,
                      controller: _firstNameController,
                      decoration: Constants.inputDecoration('firstname')),
                ),
                const SizedBox(height: 8),
                Constants.formBox(
                  context: context,
                  child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText2,
                      controller: _lastNameController,
                      decoration: Constants.inputDecoration('lastname')),
                ),
                const SizedBox(height: 8),
                Constants.formBox(
                  context: context,
                  child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText2,
                      controller: _emailController,
                      decoration: Constants.inputDecoration('email')),
                ),
                const SizedBox(height: 20),
                IntlPhoneField(
                  dropdownIcon:
                      Icon(Icons.arrow_drop_down, color: Palette.buttonColor),
                  controller: _controller,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  dropdownIconPosition: IconPosition.leading,
                  initialCountryCode: initialCountry,
                  pickerDialogStyle: PickerDialogStyle(),
                  decoration: InputDecoration(
                    // hintText: 'Phone Number',
                    labelText: 'Phone Number',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                            color: Palette.primaryColor.withOpacity(0.3),
                            width: 2.0)),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.buttonColor),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Palette.primaryColor.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(5.0),
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
                const SizedBox(height: 10),
                Center(
                  child: CustomButton(
                    child: Text('Save data'),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Customer user = auth.loggedUser!;
                        user.username = _usernameController.text;
                        user.firstName = _firstNameController.text;
                        user.lastName = _lastNameController.text;
                        user.email = _emailController.text;
                        user.phoneNumber = number;

                        showProgress(context, 'Saving info...', true);
                        CommonApi.editProfile(user).then((value) {
                          auth.returnUser(user.uid);
                          hideProgress();
                          showAlertDialog(context, 'Success',
                              'Details updated successfully');
                        });
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
