import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storeapp/Screens/users_screen.dart';
import 'package:storeapp/constant/global_color.dart';
import 'package:storeapp/services/api_handler.dart';
import 'package:storeapp/widget/sale_widget.dart';
import '../model/product_model.dart';
import '../widget/app_bar_icon.dart';
import '../widget/feeds_graid.dart';
import 'categories_screen.dart';
import 'feeds_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 late TextEditingController _textEditingController;
 List<ProductsModel> productsList=[];
 @override
  void initState(){
    _textEditingController=TextEditingController();
    super.initState();
  }
 @override
 void dispose(){
   _textEditingController.dispose();
   super.dispose();
 }
 // @override
 // void didChangeDependencies(){
 //   getProducts();
 //   super.didChangeDependencies();
 // }
 // Future<void> getProducts() async{
 //   productsList = await ApiHandler.getAllProducts();
 //   setState((){});
 //
 // }
  @override
  Widget build(BuildContext context) {
   Size size=MediaQuery.of(context).size;
    return GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 4,
            title: Text('Home'),
            leading: AppBarIcons(
              function: (){
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: const CategoriesScreen()));
              },
              icon: IconlyBold.category,

            ),
            actions: [
              AppBarIcons(
                function: (){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child:  UsersScreen()));
                },
                icon: IconlyBold.user3,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height:18 ,),
                TextFormField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Theme.of(context).cardColor,
                      ),

                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),

                      borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary
                      ),

                    ),
                    suffixIcon: Icon(
                      IconlyLight.search,
                      color: lightIconColor,
                    )
                  ),
                ),
               SizedBox(
                 height: 18,
               ),
               Expanded(
                 child: SingleChildScrollView(

                   child:  Column(
                     children: [

                       SizedBox(
                         height: size.height*0.25,
                         child: Swiper(itemCount: 3,
                           itemBuilder: (ctx,index){
                             return const SaleWidget();
                           },
                           pagination: const SwiperPagination(
                             alignment: Alignment.bottomCenter,
                             builder: DotSwiperPaginationBuilder(
                                 color: Colors.white,
                                 activeColor: Colors.red),
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           children: [
                             const Text(
                               "Latest Products",
                               style: TextStyle(
                                 fontWeight: FontWeight.w600,
                                 fontSize: 18,
                               ),
                             ),
                             const Spacer(),
                             AppBarIcons(
                                 function: () {
                                   Navigator.push(
                                       context,
                                       PageTransition(
                                           type: PageTransitionType.fade,
                                           child:  FeedsScreen()));
                                 },
                                 icon: IconlyBold.arrowRight2),
                           ],
                         ),
                       ),
                      FutureBuilder<List<ProductsModel>>(
                          future: ApiHandler.getAllProducts(),
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
                          return FeedsGridWidget(productsList: snapshot.data!);
                          }

                      )

                      ),
                     ],
                   )


                 ),
               ),

              ],
            ),
          ),
        )

    );
  }
}
