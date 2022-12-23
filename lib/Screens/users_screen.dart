import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../model/users_model.dart';
import '../services/api_handler.dart';
import '../widget/users_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body:FutureBuilder<List<UsersModel>>(
          future: ApiHandler.getAllUsers(),
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
                'No users has been added yet',
                style: TextStyle(
                    color: Colors.red
                ),
              ),);
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
                itemBuilder:(ctx,index){
                  return  ChangeNotifierProvider.value(
                      value: snapshot.data![index],
                      child: UsersWidget());
                }
            );
          }

          )

      ),

    );  }
}
