import 'package:flutter/material.dart';
import 'package:mini_catalog_app/components/product_card.dart';
import 'package:mini_catalog_app/models/product_model.dart';
import 'package:mini_catalog_app/services/api_service.dart';
import 'package:mini_catalog_app/views/card_screen.dart';
import 'package:mini_catalog_app/views/product_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Data> allProducts = [];
  bool isLoading = false;
  String errorMessage = "";

  ApiService apiService = ApiService();

  Set<int> cartIds = { };

  Future<void> loadData() async
  {
    try 
    {
      setState(() {isLoading = true;});
      final data = await apiService.fecthProducts();

      setState(() 
      {
        allProducts = data.data ?? [];
        isLoading = false;
      });
    } 
    catch (e) 
    {
      setState(() 
      {
        errorMessage = "Failed to load products";
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discover", style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, letterSpacing: 0.3),),
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CardScreen(cardIds: cartIds, products: allProducts)));
                }, 
                icon: Icon(Icons.shopping_cart), iconSize: 32)
              ],
            ),
            
            SizedBox(height: 8,),

            Text("Find your perfect device.", style: TextStyle(fontSize: 16, color: Colors.grey),),

            SizedBox(height: 14,),

            Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f5f7),
                borderRadius: BorderRadius.circular(12)
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search_sharp, color: Colors.grey,),
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  border: InputBorder.none 
                ),
              ),
            ),

            SizedBox(height: 16,),

            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage("https://www.wantapi.com/assets/banner.png"),
                  fit: BoxFit.fitWidth)

              ),
            ),

            SizedBox(height: 16,),

            if(isLoading)
              Center(child: CircularProgressIndicator(),)

            else if(errorMessage.isNotEmpty)
              Center(child: Text(errorMessage),)

            else
              Expanded(
                child: GridView.builder(
                  itemCount: allProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.7), 
                  itemBuilder: (context, index){
                    final product = allProducts[index];
                
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product: product, cartIds: cartIds)));
                        },
                      child: ProductCard(product: product));
                    }
                  ),
              )
  
          ],
        ),
      )),
    );
  }
}