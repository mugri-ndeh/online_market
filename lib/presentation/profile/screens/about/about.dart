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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              children: [
                // Image.asset(
                //   'assets/icons/agricma.png'),
                 Text('Agricma Limited is a company founded in 2023 by Nkwelle Eugene Mejame.\n\nIt consists of AG Market ,AG Farm ,AG Estate and AG Coin. Our aim is to constantly ensure quality and reliability to our customers and partners,this is through the offering of quality products at affordable prices and trustworthy after-sale services.',
                  style:GoogleFonts.lato(
                    fontSize: 17,
                  )),
                
                const SizedBox(height: 10),
                Text('AG Market', 
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
                const SizedBox(height: 3),
                 Text(
                    'AG Market is an e-commerce platform which enables farmers involved in livestocks, food crops and cash crops farming to sell their produce directly to restaurants and the public without having to go to the market or having to sell to middlemen.\nWe also allow the sale of agricultural machines and medications through our AG Tools and AG Pharmacy.\nRestaurants trade with us, so with just a click you can order from your favorite restaurants.',
                    style: GoogleFonts.lato(
                      fontSize: 17,
                    ),
                    ),
                    const SizedBox(height: 5),
                    Text('\nAG Market Business Store creation:\n70,000 cfa \n5% commission \n\nUser requirements \n1)Name \n2)Date of birth \n3)Email/Phone number \n4)Location \n\nProduct requirements \n1)Price\n2)Quantity',
                    style: GoogleFonts.lato(
                      fontSize:17,
                    ),),
                
              ],
              ),
            ),
          ),))
    );
  }
}
