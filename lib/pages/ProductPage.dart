import 'package:flutter/material.dart';
import 'package:shopping_app/pages/ShoeDetails.dart';

import '../utils/global_variables.dart';
import '../widgets/ShoeCard.dart';
import 'CartPage.dart';

class ProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductPage();
  }
}

class _ProductPage extends State<ProductPage> {
  final border = OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
    borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
  );
  final List<String> companyNames = ['All', 'Addidas', 'Nike', 'Bata'];
  late String selectedFilter;
  @override
  void initState() {
    selectedFilter = companyNames[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      return selectedFilter == 'All' ||
          product['company'].toString() == selectedFilter;
    }).toList();
    return (SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: Text(
                  'Shoes\nCollection',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: companyNames.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () => setState(() {
                      selectedFilter = companyNames[index];
                    }),
                    child: (Chip(
                      backgroundColor: selectedFilter == companyNames[index]
                          ? Color.fromRGBO(254, 206, 1, 1)
                          : Color.fromRGBO(245, 247, 249, 1),
                      label: Text(companyNames[index]),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.grey),
                      ),
                    )),
                  ),
                );
              },
            ),
          ),
          filteredProducts.length == 0
              ? Center(child: Text('No Items'))
              : Expanded(
                  child: ListView.builder(
                    itemCount: filteredProducts.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ShoeDetails(
                                      id: int.parse(
                                        filteredProducts[index]['id']
                                            .toString(),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: ShoeCard(
                              id: int.parse(
                                filteredProducts[index]['id'].toString(),
                              ),
                              shoename: filteredProducts[index]['title']
                                  .toString(),
                              shoeimg: filteredProducts[index]['imageUrl']
                                  .toString(),
                              shoeprice: filteredProducts[index]['price']
                                  .toString(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),
    ));
  }
}
