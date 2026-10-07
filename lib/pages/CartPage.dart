import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/CartProvider.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPage();
  }
}

class _CartPage extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return (cart.cart.length==0 ? Center(child: Text('No products in the cart!!')) :
      ListView.builder(
      itemCount: cart.cart.length,
      itemBuilder: (context, index) {
        final product = cart.cart[index];
        return (Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(254, 206, 1, 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image(image: AssetImage(product['imageUrl'])),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        product['title'].toString(),
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text('Size : ${product['selectedSize'].toString()}'),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return (AlertDialog(
                            title: Text('Delete Product'),
                            content: Text(
                              'Are you sure you want to delete the product form the cart?',
                            ),
                            actions: [
                              TextButton(onPressed: () { Navigator.pop(context);}, child: Text('No',style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)),
                              TextButton(
                                onPressed: () {
                                  Provider.of<CartProvider>(
                                    context,
                                    listen: false,
                                  ).removeProduct(product);
                                   Navigator.pop(context);
                                },
                                child: Text('Yes',style: TextStyle(
                                  color: Colors.red,fontWeight:FontWeight.bold
                                ),),
                              ),
                            ],
                          ));
                        },
                      );
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ));
      },
    ));
  }
}
