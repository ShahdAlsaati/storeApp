import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../services/api_handler.dart';
import '../widget/feeds_graid.dart';
import '../widget/feeds_widget.dart';

class FeedsScreen extends StatefulWidget {
   FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
   List<ProductsModel> productsList=[];

  @override
  void didChangeDependencies(){
    getProducts();
    super.didChangeDependencies();
  }
  Future<void> getProducts() async{
    productsList = await ApiHandler.getAllProducts();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Products"),
      ),
      body: productsList.isEmpty? Center(child: CircularProgressIndicator(),): GridView.builder(
          // shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: productsList.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 0.7
          ),
          itemBuilder: (ctx,index){
            return ChangeNotifierProvider.value(
                value: productsList[index],
                child: FeedsWidget());


          }
      )
    );
  }
}
