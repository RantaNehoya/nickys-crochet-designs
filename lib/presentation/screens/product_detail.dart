import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nickys_designs/presentation/resources/asset_manager.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nickys_designs/models/product_model.dart';
import 'package:nickys_designs/utilities/palette.dart';
import 'package:nickys_designs/providers/cart_provider.dart';
import 'package:nickys_designs/utilities/constants.dart';
import 'package:nickys_designs/widgets/design_appbar.dart';
import 'package:nickys_designs/presentation/resources/string_manager.dart';
import 'package:nickys_designs/presentation/resources/value_manager.dart';
import 'package:nickys_designs/presentation/resources/font_manager.dart';

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final dynamic image;

  ProductDetailScreen({Key key, @required this.name, @required this.image})
      : super(key: key);

  final _productsCollection =
      FirebaseFirestore.instance.collection(StringManager.stockCollection);
  String prodSize = StringManager.zero;
  String price = StringManager.priceZero;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CartProvider cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: DesignAppBar(
        label: name,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return kProgressIndicator;
          }

          if (snapshot.hasError) {
            return kErrorMessage;
          }

          for (var doc in snapshot.data.docs) {
            if (doc[StringManager.prodName] == name) {
              prodSize = doc[StringManager.size];
              price = doc[StringManager.price];
            }
          }
          return Column(
            children: <Widget>[
              //image
              SizedBox(
                height: size.height * SizeManager.s0_75,
                width: double.infinity,
                child: (image == '')
                    ? Image.asset(
                        AssetManager.logo,
                        fit: BoxFit.cover,
                      )
                    : Image.memory(
                        image.bytes,
                        fit: BoxFit.cover,
                      ),
              ),

              //bottom
              SizedBox(
                height: size.height * SizeManager.s0_1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        cart.addToCart(
                          ProductModel(
                            name: name,
                            price: price,
                            size: prodSize,
                            image: image,
                          ),
                        );
                        cart.addPrice(
                          double.parse(price),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPalette.colorPalette.shade200,
                        elevation: ElevationManager.e_0,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * SizeManager.s0_1,
                          vertical: size.height * SizeManager.s0_015,
                        ),
                      ),
                      child: const Text(
                        StringManager.addToCart,
                      ),
                    ),
                    Text(
                      'N\$$price',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeightManager.bold,
                        fontSize: FontSizeManager.f_16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
