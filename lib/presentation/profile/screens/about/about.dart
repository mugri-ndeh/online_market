import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        iconTheme: Theme.of(context).iconTheme,
        titleTextStyle: Theme.of(context).textTheme.headline6,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: const Text('Agricma Limited (AG Ltd)'),
      ),
      //Setting text for about page
      body: SafeArea(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // AssetImage(
            //   'assets/icons/agricma.png',
            //   size: 100,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Agricma Limited is a company founded in 2023 by Nkwelle Eugene Mejame.\n \nIt  consists of AG Market,AG Farm,AG Estate and AG Coin. Our aim is to constantly ensure quality and reliability to our customers and partners,this is through the offering of quality products at affordable prices and trustworthy after-sale services.',
              style:GoogleFonts.lato(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
            ),
            const SizedBox(height: 10),
            Text('')
          ],
          ),))
    );
  }
}
