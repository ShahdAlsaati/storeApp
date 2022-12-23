import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:storeapp/model/product_model.dart';

import '../constant/api_consts.dart';
import '../model/categories_model.dart';
import '../model/users_model.dart';

class ApiHandler{
 static Future<List<dynamic>> getAllData({required String target}) async{
 try{
  var uri =Uri.https(BASE_URL, "/api/v1/$target");
  var response= await http.get(uri);
  // print("Response ${jsonDecode(response.body)}");
  var data =jsonDecode(response.body);
  List tempList=[];
  if(response.statusCode!=200)
  {
   throw(data["message"]);
  }
  for(var v in data){
   tempList.add(v);
  }
  return tempList;
 }
 catch(error){
  print("An error occord $error");
  throw error.toString();
 }
 }
 static Future<List<ProductsModel>> getAllProducts() async{
   List tempList= await getAllData( target: 'products',);
    return ProductsModel.produtsFromSnapShot(tempList);
  }
 static Future<List<CategoriesModel>> getAllCategories() async{
  List tempList= await getAllData( target: 'categories',);
  return CategoriesModel.categoriesFromSnapShot(tempList);
 }
 static Future<List<UsersModel>> getAllUsers() async{
  List tempList= await getAllData( target: 'users',);
  return UsersModel.usersFromSnapShot(tempList);
 }
 static Future<ProductsModel> getProdutsByID({required String id}) async{
  try{
   var uri =Uri.https(BASE_URL, "/api/v1/products/$id");
   var response= await http.get(uri);
   var data =jsonDecode(response.body);

   return ProductsModel.fromJson(data);
  }
  catch(error){
   print("An error occord $error");
   throw error.toString();
  }
 }

}