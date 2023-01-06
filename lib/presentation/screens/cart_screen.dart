import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nickys_designs/widgets/bottom_nav_button.dart';
import 'package:nickys_designs/providers/cart_provider.dart';
import 'package:nickys_designs/utilities/constants.dart';
import 'package:nickys_designs/widgets/design_appbar.dart';
import 'package:nickys_designs/presentation/resources/asset_manager.dart';
import 'package:nickys_designs/presentation/resources/route_manager.dart';
import 'package:nickys_designs/presentation/resources/string_manager.dart';
import 'package:nickys_designs/presentation/resources/value_manager.dart';
import 'package:nickys_designs/presentation/resources/font_manager.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    CartProvider cart = Provider.of<CartProvider>(context);

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(
          PaddingManager.p_8,
        ),
        child: SizedBox(
          height: size.height * SizeManager.s_19,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    StringManager.collection,
                  ),
                  Switch(
                    value: cart.getSwitchValue,
                    onChanged: (_) {
                      cart.changeSwitchValue();
                    },
                  ),
                  const Text(
                    StringManager.delivery,
                  ),
                ],
              ),
              kCartDivider,
              Text(
                '${StringManager.total}${cart.sumPrice().toStringAsFixed(ValueManager.v_2)}',
                style: TextStyle(
                  fontSize:
                      mediaQueryData.textScaleFactor * FontSizeManager.f_20,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              kCartDivider,
              BottomNavButton(
                label: StringManager.proceedToCheckout,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.checkout,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      appBar: const DesignAppBar(
        label: StringManager.cart,
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: cart.getCartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: (cart.getCartItems[index].image == '')
                ? Image.asset(
                    AssetManager.logo,
                    fit: BoxFit.cover,
                  )
                : Image.memory(
                    cart.getCartItems[index].image.bytes,
                    fit: BoxFit.cover,
                  ),
            title: Text(
              cart.getCartItems[index].name,
            ),
            subtitle: Text(
              'N\$${cart.getCartItems[index].price}',
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete_outline_outlined,
              ),
              onPressed: () {
                cart.removeFromCart(index);
                cart.removePrice(index);
              },
            ),
          );
        },
      ),
    );
  }
}
