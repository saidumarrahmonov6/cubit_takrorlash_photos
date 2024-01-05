import 'package:bloc/bloc.dart';
import 'package:cubit_takrorlash/model/photos.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit() : super(NetworkInitial());
  Dio dio = Dio();

  void yukla() async {
    emit(NetworkLoading());
    try{
      var response = await dio.get("https://jsonplaceholder.typicode.com/photos");
      if(response.statusCode == 200){
        emit(NetworkSuccess(listFromJson(response.data)));
      } else {
        emit(NetworkError("Serverda xatolik"));
      }
    } catch(e){
      emit(NetworkError(e.toString()));
    }
  }
}

