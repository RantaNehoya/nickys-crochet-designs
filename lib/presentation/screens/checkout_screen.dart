import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nanoid/nanoid.dart';
import 'package:nickys_designs/utilities/palette.dart';
import 'package:nickys_designs/providers/cart_provider.dart';
import 'package:nickys_designs/widgets/bottom_nav_button.dart';
import 'package:nickys_designs/widgets/design_appbar.dart';
import 'package:nickys_designs/presentation/resources/route_manager.dart';
import 'package:nickys_designs/presentation/resources/string_manager.dart';
import 'package:nickys_designs/presentation/resources/value_manager.dart';
import 'package:nickys_designs/presentation/resources/font_manager.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _ordersCollection = FirebaseFirestore.instance.collection('orders');

  final _personalDetailsFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();

  int selectedRadio = ValueManager.v_1;
  String refID = customAlphabet(StringManager.customAlphabet, ValueManager.v_7);

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _phone.dispose();
    _address.dispose();
    super.dispose();
  }

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
        child: BottomNavButton(
          label: StringManager.order,
          onPressed: () {
            List<String> prodName = [];
            if (_personalDetailsFormKey.currentState.validate()) {
              if (cart.getCartItems.isNotEmpty) {
                for (var prod in cart.getCartItems) {
                  prodName.add(prod.name);
                }
                _ordersCollection.doc(refID).set({
                  StringManager.mapAccepted: false,
                  StringManager.mapAddress: _address.text,
                  StringManager.mapDateOrdered: DateTime.now().toString(),
                  StringManager.mapName: '${_firstName.text} ${_lastName.text}',
                  StringManager.mapPayment: StringManager.cash,
                  StringManager.mapPhone: _phone.text,
                  StringManager.mapProduct: prodName,
                  StringManager.refNum: refID,
                  StringManager.mapStatus: StringManager.pending,
                  StringManager.mapTotal: cart.sumPrice().toStringAsFixed(2),
                  StringManager.mapType: cart.getSwitchValue
                      ? StringManager.delivery
                      : StringManager.collection,
                });
              }
              cart.clearCart();
              Navigator.pushNamed(
                context,
                Routes.thankyou,
              );
            }
          },
        ),
      ),
      appBar: const DesignAppBar(
        label: StringManager.checkout,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * SizeManager.s0_01,
            ),

            //personal details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(
                PaddingManager.p_10,
              ),
              child: Form(
                key: _personalDetailsFormKey,
                child: Column(
                  children: [
                    checkoutHeader(StringManager.personalDetails),
                    checkoutTextField(StringManager.firstName, _firstName),
                    checkoutTextField(StringManager.lastName, _lastName),
                    checkoutTextField(StringManager.phone, _phone),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: size.height * SizeManager.s0_03,
            ),

            //address details
            Visibility(
              visible: cart.getSwitchValue,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  PaddingManager.p_10,
                ),
                child: Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      checkoutHeader(StringManager.myAddress),
                      checkoutTextField(StringManager.address, _address),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: size.height * SizeManager.s0_03,
            ),

            //radios
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(
                PaddingManager.p_10,
              ),
              child: checkoutHeader(StringManager.payment),
            ),

            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                paymentTile(size, ValueManager.v_1, StringManager.cash, null),
                paymentTile(
                  size,
                  ValueManager.v_2,
                  StringManager.card,
                  Text(
                    StringManager.unavailable,
                    style: TextStyle(
                      fontSize:
                          mediaQueryData.textScaleFactor * FontSizeManager.f_12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container paymentTile(Size size, int value, String label, Widget subtitle) {
    return Container(
      width: size.width * SizeManager.s0_45,
      height: size.height * SizeManager.s0_07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          RadiusManager.r_5,
        ),
        border: Border.all(
          color: (subtitle == null)
              ? ColorPalette.colorPalette.shade500
              : Colors.grey.shade300,
          width: SizeManager.s1_5,
        ),
      ),
      child: RadioListTile(
        value: value,
        title: Text(
          label,
        ),
        subtitle: subtitle,
        groupValue: selectedRadio,
        onChanged: (newVal) {
          setState(
            () {
              selectedRadio = newVal;
            },
          );
        },
      ),
    );
  }

  TextFormField checkoutTextField(
      String hintText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: const UnderlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return StringManager.validation;
        }
        return null;
      },
    );
  }

  SizedBox checkoutHeader(String label) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeightManager.regular,
          fontSize: FontSizeManager.f_20,
        ),
      ),
    );
  }
}
