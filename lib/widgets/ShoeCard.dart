import 'package:flutter/material.dart';

class ShoeCard extends StatefulWidget {
  final int id;
  final String shoename;
  final String shoeprice;
  final String shoeimg;

  const ShoeCard({
    super.key,
    required this.id,
    required this.shoename,
    required this.shoeimg,
    required this.shoeprice,
  });
  @override
  State<StatefulWidget> createState() {
    return _ShoeCard();
  }
}

class _ShoeCard extends State<ShoeCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.id%2==0 ?Color.fromRGBO(216, 240, 253, 1) : Color.fromRGBO(245, 247, 249, 1),
          borderRadius: BorderRadius.circular(30)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.shoename,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('\$${widget.shoeprice}', style: Theme.of(context).textTheme.bodySmall,),
              Center(child: Image(image: AssetImage(widget.shoeimg), height: 175)),
            ],
          ),
        ),
      ),
    );
  }
}
