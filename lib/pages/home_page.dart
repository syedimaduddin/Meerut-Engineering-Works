import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_app/core/store.dart';
import 'package:first_flutter_app/models/cart.dart';
import 'package:first_flutter_app/models/catalog.dart';
import 'package:first_flutter_app/pages/login_screen.dart';
import 'package:first_flutter_app/utils/routes.dart';
import 'package:first_flutter_app/widgets/home_widgets/catalog_header.dart';
import 'package:first_flutter_app/widgets/home_widgets/catalog_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 1;

  final String name = "Imad";

  final url = "https://api.jsonbin.io/b/6232e6997caf5d67836b974b/2";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await http.get(Uri.parse(url));
    final catalogJson = response.body;
    // final catalogJson =
    //     await rootBundle.loadString("assets/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    // print(decodedData);
    final productsData = decodedData["products"];
    // print(productsData);
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    // final dummyList = List.generate(50, (index) => CatalogModel.items[0]);
    return Scaffold(
        // appBar: AppBar(
        //   title: Padding(
        //     padding: const EdgeInsets.all(16.0),
        //     child: (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
        //         ?
        //         // ListView.builder(
        //         //   itemCount: CatalogModel.items.length,
        //         //   // itemCount: dummyList.length,
        //         //   itemBuilder: (context, index) =>
        //         //     ItemWidget(
        //         //       item: CatalogModel.items[index],
        //         //       // item: dummyList[index],
        //         //     ),
        //         // )
        //         GridView.builder(
        //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                 crossAxisCount: 2,
        //                 mainAxisSpacing: 16,
        //                 crossAxisSpacing: 16,
        //                 ),
        //             itemBuilder: (context, index) {
        //               final item = CatalogModel.items[index];
        //               return Card(
        //                 clipBehavior: Clip.antiAlias,
        //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //               child: GridTile(
        //                 header: Container(
        //                   child: Text(
        //                     item.name,
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                   padding: const EdgeInsets.all(12),
        //                   decoration: BoxDecoration(
        //                     color: Colors.deepPurple,
        //                   ),
        //                 ),
        //                 child: Image.network(item.image),
        //                 footer: Container(
        //                   child: Text(
        //                     item.price.toString(),
        //                     style: TextStyle(
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                   padding: const EdgeInsets.all(12),
        //                   decoration: BoxDecoration(
        //                     color: Colors.black,
        //                   ),
        //                 ),
        //                 ),
        //               );
        //             },
        //             itemCount: CatalogModel.items.length,
        //           )
        //         : Center(
        //             child: CircularProgressIndicator(),
        //           ),
        //   ),
        // ),
        // body: Center(
        //   child: Container(
        //     child: Text("I'm $name, Welcome to my ${days}st Flutter App."),
        //   ),
        // ),
        // drawer: MyDrawer(),

        // backgroundColor: MyTheme.creamColor,
        backgroundColor: context.canvasColor,
        floatingActionButton: VxBuilder(
          mutations: const {AddMutation, RemoveMutation},
          builder: (context, dynamic, _) => FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
            backgroundColor: context.theme.buttonColor,
            child: const Icon(
              CupertinoIcons.cart,
              color: Colors.white,
            ),
          )
          .badge(
              color: Vx.gray100,
              size: 22,
              count: _cart.items.length,
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: SafeArea(
          child: Container(
            padding: Vx.mLTRB(24, 32, 24, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CatalogHeader(),
                if (CatalogModel.items.isNotEmpty)
                  const CatalogList().expand()
                else
                  const CircularProgressIndicator().centered().expand(),
                ActionChip(
                  label: const Text("Logout"),
                  onPressed: () {
                    logout(context);
                  }),
              ],
            ),
          ),
        ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
