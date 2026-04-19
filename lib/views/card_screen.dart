import 'package:flutter/material.dart';
import 'package:mini_catalog_app/models/product_model.dart';

class CardScreen extends StatefulWidget {

  final List<Data> products;
  final Set<int> cardIds;

  const CardScreen({super.key, required this.cardIds, required this.products});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {

    final cardProducts = widget.products.where((product) => widget.cardIds.contains(product.id)).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Back"), backgroundColor: Colors.white,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              
              Expanded(
                child: cardProducts.isEmpty ?
        
                Center(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_cart, size: 84, color: Colors.grey.shade700,),
                    SizedBox(height: 16,),
                    Text("Your Cart Is Empty", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade700, fontSize: 20),)
                  ],
                ),)
                : 
                ListView.builder(
                  itemCount: cardProducts.length,
                  itemBuilder: (context, index){
                    final product = cardProducts[index];
                
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            child: Image.network(product.image ?? "", width: 72, height: 72,)),
                      
                          SizedBox(width: 16,),
                      
                          Expanded(
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
                      
                              IconButton(onPressed: (){
                                setState(() {
                                  widget.cardIds.remove(product.id);
                                });
                              }, icon: Icon(Icons.delete_outlined), iconSize: 32,)
                        ],
                      ),
                    );
                  }),
              ),
        
              ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade800,
                        minimumSize: Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(20)
                        )
                      ),
                      onPressed: (){ },
                      child: Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),)
                      )
        
            ],
          ),
        ),
      ),
    );
  }
}