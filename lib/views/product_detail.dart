

import 'package:flutter/material.dart';
import 'package:mini_catalog_app/models/product_model.dart';

class ProductDetail extends StatefulWidget {

  final Data product;
  final Set<int> cartIds;

  const ProductDetail({super.key, required this.product, required this.cartIds});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Back"), backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Hero(
              tag: widget.product.id ?? 0,
              child: Image.network(widget.product.image ?? "", 
                height: 350, 
                width: double.infinity, 
                fit: BoxFit.cover,
                ),
            ),
        
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                  
                  SizedBox(height: 4,),
        
                  Text(widget.product.tagline ?? "", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.grey.shade700),),
                  
                  SizedBox(height: 16,),
        
                  Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                  
                  SizedBox(height: 4,),
        
        
                  Text(widget.product.description ?? "", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.grey.shade700),),
        
                  SizedBox(height: 24,),
        
                  Text(widget.product.price ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.orange.shade800),),
        
                  SizedBox(height: 24,),
        
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade800,
                      minimumSize: Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20)
                      )
                    ),
                    onPressed: (){
                      setState(() {
                        widget.cartIds.add(widget.product.id ?? 0);
                      });
        
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Added to card"))
                      );
                    },
                    child: Text("Add To Card", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),)
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}