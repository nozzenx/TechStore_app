import 'package:flutter/material.dart';
import 'package:mini_catalog_app/models/product_model.dart';

class ProductCard extends StatelessWidget {

  final Data product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container( //ItemCards
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          offset: Offset(0, 4))
                        ],
                      color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: product.id ?? 0,
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(12), bottom: Radius.zero),
                              child: Image.network(product.image ?? "", width: double.infinity, fit: BoxFit.cover,)),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsetsGeometry.fromLTRB(8, 0, 8, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name ?? "", style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                              
                              SizedBox(height: 1,),
                                                    
                              Text(product.tagline ?? "", style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontSize: 12
                              ),),
                              
                              SizedBox(height: 1,),
                              
                              Text(product.price ?? "", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade800
                              ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
  }
}