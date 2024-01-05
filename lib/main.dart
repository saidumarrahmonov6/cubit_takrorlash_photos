import 'package:cubit_takrorlash/network/network_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(home: BlocProvider(
    create: (context) => NetworkCubit(),
    child: MyApp(),
  ), debugShowCheckedModeBanner: false,));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NetworkCubit>(context).yukla();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image list"),),
      body:  BlocBuilder<NetworkCubit , NetworkState>(
        builder: (context , state) {
          if(state is NetworkInitial){
            return SizedBox();
          } else if (state is NetworkLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is NetworkSuccess){
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (BuildContext context , int index){
                return Row(
                  children: [
                    Container(width: 200, height: 200, child: Image.network(state.list[index].thumbnailUrl.toString())),
                    SizedBox(width: 20,),
                    Container(width: 100, height: 200 , child: Text(state.list[index].title.toString())),
                  ],
                );
              },
            );
          } else if(state is NetworkError){
            return Center(
              child: Text(state.message.toString()),
            );
          } else {
            return Center(
              child: Text("Nomalum xatolik !"),
            );
          }
        },
      )
    );
  }
}
