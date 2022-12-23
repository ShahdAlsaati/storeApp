import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/categories_model.dart';
import '../services/api_handler.dart';
import '../widget/categories_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<CategoriesModel> categoriesList=[];

  @override
  void didChangeDependencies(){
    getProducts();
    super.didChangeDependencies();
  }
  Future<void> getProducts() async{
    categoriesList = await ApiHandler.getAllCategories();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body:FutureBuilder<List<CategoriesModel>>(
          future: ApiHandler.getAllCategories(),
          builder: ((context,snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
              return const Center(child: CircularProgressIndicator(),);
            else if(snapshot.hasError){
              return  Center(child: Text(
                'An error occurd ${snapshot.error.toString()}',
                style: TextStyle(
                    color: Colors.red
                ),
              ),);
            }
            else if(snapshot.data==null){
              return const Center(child: Text(
                'No products has been added yet',
                style: TextStyle(
                    color: Colors.red
                ),
              ),);
            }
            return   GridView.builder(
                // shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (ctx, index) {
                  return ChangeNotifierProvider.value(
                      value:snapshot.data![index],
                    child: CategoryWidget()
                  );
                });
          }

          )

      ),

    );
  }
}