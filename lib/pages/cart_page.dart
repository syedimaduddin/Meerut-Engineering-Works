import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../core/store.dart';
import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.xl3.color(context.theme.buttonColor).make(),
      ),
      body: Column(
        children: [
          // Placeholder().p32().expand(),
          _CartList().p32().expand(),
          const Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatefulWidget {
  @override
  State<_CartTotal> createState() => _CartTotalState();
}

class _CartTotalState extends State<_CartTotal> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Fluttertoast.showToast(
        msg: "Success" + response.paymentId!, toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(
        msg: "Error" + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    Fluttertoast.showToast(
        msg: "External_Wallet" + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // VxConsumer(
          //     mutations: {RemoveMutation},
          //     notifications: {},
          //     builder: (context, dynamic, _) {
          //       return "₹${_cart.totalPrice}".text.xl5.color(context.accentColor).make();
          //     },
          // ),
          VxBuilder(
            mutations: const {RemoveMutation},
            builder: (context, dynamic, _) {
              return "₹${_cart.totalPrice}"
                  .text
                  .xl5
                  .color(context.accentColor)
                  .make();
            },
          ),
          30.widthBox,
          ElevatedButton(
            onPressed: () {
              // Make Payment
              var options = {
                'key': 'rzp_test_j1xcwa8e3hp8xE',
                'amount': (_cart.totalPrice * 100)
                    .toString(), //in the smallest currency sub-unit.
                'name': 'Hans Engineering Works',
                // 'order_id':
                //     'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                'description': 'Hans Trademark',
                'timeout': 300, // in seconds
                'prefill': {
                  'contact': '9917420899',
                  'email': 'imaduddinsyed06@example.com'
                },
                'external': {
                  "wallets": ["paytm"]
                }
              };

              try {
                _razorpay.open(options);
              } catch (e) {
                Fluttertoast.showToast(msg: e.toString());
              }
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(context.theme.buttonColor)),
            child: "Buy".text.color(Colors.white).make(),
          ).w32(context)
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    return _cart.items.isEmpty
        ? "Nothing to show".text.xl3.makeCentered()
        : ListView.builder(
            itemCount: _cart.items.length,
            itemBuilder: (context, index) => ListTile(
              leading: const Icon(Icons.done),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () => RemoveMutation(_cart.items[index]),
                // _cart.remove(_cart.items[index]);
                // setState(() {});
              ),
              title: _cart.items[index].name.text.make(),
            ),
          );
  }
}
