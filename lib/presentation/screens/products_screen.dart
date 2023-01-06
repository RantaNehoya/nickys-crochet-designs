import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:nickys_designs/utilities/palette.dart';
import 'package:nickys_designs/providers/product_provider.dart';
import 'package:nickys_designs/utilities/constants.dart';
import 'package:nickys_designs/widgets/design_appbar.dart';
import 'package:nickys_designs/widgets/product_item.dart';
import 'package:nickys_designs/providers/cart_provider.dart';
import 'package:nickys_designs/presentation/resources/string_manager.dart';
import 'package:nickys_designs/presentation/resources/value_manager.dart';
import 'package:nickys_designs/presentation/resources/asset_manager.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key key}) : super(key: key);

  final _productsCollection =
      FirebaseFirestore.instance.collection(StringManager.stockCollection);

  @override
  Widget build(BuildContext context) {
    ProductProvider prod = Provider.of<ProductProvider>(context);
    CartProvider cart = Provider.of<CartProvider>(context);

    return Scaffold(
      floatingActionButton: cart.showCart(context),
      appBar: DesignAppBar(
        label: StringManager.products,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: PaddingManager.p_8,
              right: PaddingManager.p_11,
            ),
            child: PopupMenuButton(
              itemBuilder: ((context) {
                return [
                  PopupMenuItem(
                    child: const Text(
                      StringManager.alphabetically,
                    ),
                    onTap: () {
                      prod.changeFilterAlphabetically();
                    },
                  ),
                  PopupMenuItem(
                    child: const Text(
                      StringManager.mostRecent,
                    ),
                    onTap: () {
                      prod.changeFilterMostRecent();
                    },
                  ),
                ];
              }),
              child: const Icon(
                Icons.filter_list,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsCollection.orderBy(prod.getFilter).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return kProgressIndicator;
          }

          if (snapshot.hasError) {
            return kErrorMessage;
          }

          var doc = snapshot.data.docs;

          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetManager.logo,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: GridView.builder(
              itemCount: doc.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ValueManager.v_2,
                childAspectRatio: ValueManager.v_3 / ValueManager.v_4,
              ),
              itemBuilder: (context, index) {
                bool isOutOfStock =
                    (doc[index]['stock'] == ValueManager.v_0) ? true : false;
                return Badge(
                  showBadge: isOutOfStock,
                  badgeColor: ColorPalette.colorPalette.shade800,
                  shape: BadgeShape.square,
                  borderRadius: BorderRadius.circular(
                    RadiusManager.r_5,
                  ),
                  position: BadgePosition.bottomEnd(
                    end: ValueManager.v_0.toDouble(),
                    bottom: ValueManager.v_neg2.toDouble(),
                  ),
                  badgeContent: const Text(
                    StringManager.outOfStock,
                  ),
                  child: ProductItem(
                    image: doc[index][StringManager.image],
                    name: doc[index][StringManager.prodName],
                    isOutOfStock: isOutOfStock,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
