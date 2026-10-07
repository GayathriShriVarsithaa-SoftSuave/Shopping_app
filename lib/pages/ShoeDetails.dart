import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/CartProvider.dart';

import '../utils/global_variables.dart';

class ShoeDetails extends StatefulWidget {
  final int id;

  const ShoeDetails({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    return _ShoeDetails();
  }
}

class _ShoeDetails extends State<ShoeDetails> {
  String selectedSize = '';
  @override
  Widget build(BuildContext context) {
    final sizes = products[widget.id]['sizes'] as List;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Details',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Text(
            products[widget.id]['title'].toString(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Spacer(),
          Image(image: AssetImage(products[widget.id]['imageUrl'].toString())),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    '\$${products[widget.id]['price'].toString()}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sizes.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = sizes[index].toString();
                              });
                            },
                            child: (Chip(
                              backgroundColor:
                                  selectedSize == sizes[index].toString()
                                  ? Color.fromRGBO(254, 206, 1, 1)
                                  : Color.fromRGBO(245, 247, 249, 1),
                              label: Text(sizes[index].toString()),
                            )),
                          ),
                        );
                      }),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(254, 206, 1, 1),
                      ),
                      onPressed: selectedSize.isEmpty
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Please select a size")),
                              );
                            }
                          : () {
                              Provider.of<CartProvider>(
                                context,
                                listen: false,
                              ).addProduct(products[widget.id], selectedSize);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Product added!!")),
                              );
                            },
                      child: Text('Add to Cart',style: TextStyle(color: Colors.black),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
