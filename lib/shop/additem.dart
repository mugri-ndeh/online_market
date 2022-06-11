// import 'package:online_market/auth/models/location.dart';
// import 'package:online_market/auth/providers/auth_provider.dart';
// import 'package:online_market/util/contstants.dart';
// import 'package:online_market/util/helper.dart';
// import 'package:online_market/util/palette.dart';
// import 'package:online_market/util/widgets/custom_buttons.dart';
// import 'package:provider/provider.dart';

// import 'item_model.dart';

// import 'package:flutter/material.dart';
// import 'package:online_market/auth/providers/auth_provider.dart';
// import 'package:online_market/util/contstants.dart';
// import 'package:online_market/util/helper.dart';
// import 'package:online_market/util/palette.dart';
// import 'package:online_market/util/widgets/custom_buttons.dart';
// import 'package:provider/provider.dart';

// class AddItem extends StatefulWidget {
//   AddItem({Key? key}) : super(key: key);

//   @override
//   State<AddItem> createState() => _AddItemState();
// }

// class _AddItemState extends State<AddItem> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();
//   late Authentication auth;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     auth = Provider.of<Authentication>(context, listen: false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: Constants.bodyHorizontalpadding),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Add Product',
//                     style: Theme.of(context).textTheme.headline1,
//                   ),
//                   const SizedBox(height: Constants.bigAuthSpace),
//                   Constants.formBox(
//                     context: context,
//                     child: TextFormField(
//                         style: Theme.of(context).textTheme.bodyText2,
//                         controller: _usernameController,
//                         decoration: Constants.inputDecoration('productname')),
//                   ),
//                   const SizedBox(height: 10),
//                   Constants.formBox(
//                     context: context,
//                     child: TextFormField(
//                         style: Theme.of(context).textTheme.bodyText2,
//                         controller: _emailController,
//                         decoration: Constants.inputDecoration('email')),
//                   ),
//                   const SizedBox(height: 10),
//                   Constants.formBox(
//                     context: context,
//                     child: TextFormField(
//                         style: Theme.of(context).textTheme.bodyText2,
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: Constants.inputDecoration('password')),
//                   ),
//                   const SizedBox(height: 10),
//                   Constants.formBox(
//                     context: context,
//                     child: TextFormField(
//                         style: Theme.of(context).textTheme.bodyText2,
//                         //controller: _confirmPasswordController,
//                         obscureText: true,
//                         decoration:
//                             Constants.inputDecoration('confirm password')),
//                   ),
//                   const SizedBox(height: 10),
                  
//                   const SizedBox(height: 10),
//                   CustomButton(
//                       child: const Text('Add Product'),
//                       onTap: () {
//                         var emailGood = validateEmail(_emailController.text);
//                         var passwordGood =
//                             validatePassword(_passwordController.text);
//                         var goodUsername =
//                             validateName(_usernameController.text);
//                         // var goodConfirmPassword = validateConfirmPassword(
//                         //     _passwordController.text,
//                         //     );
//                         // auth.setAuthState(AuthState.loggedIn);
//                         if (goodUsername != null) {
//                           showSnackBar(context, goodUsername);
//                         } else if (emailGood != null) {
//                           showSnackBar(context, emailGood);
//                         } else if (passwordGood != null) {
//                           showSnackBar(context, passwordGood);
//                          } else {
//                           showSnackBar(context, 'Done');
//                           showProgress(context, 'Adding product to list.....', true);
//                           auth
//                               .register(
//                                   _emailController.text,
//                                   _usernameController.text,
//                                   _passwordController.text)
//                               .then((value) => hideProgress());
//                         }
//                       }),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
