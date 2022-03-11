import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upwork_assignment/model/hotel_model.dart';
import 'package:upwork_assignment/network/error_model.dart';
import 'package:upwork_assignment/provider/hotel_provider.dart';

abstract class HotelEvent{}

class GetHotelList extends HotelEvent{}

abstract class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

class LoadingHotels extends ListState{}

class HotelsLoaded extends ListState{
  final List<HotelModel> hotels;
  const HotelsLoaded(this.hotels);
}

class NoHotelFound extends ListState{}

class ErrorLoadingHotels extends ListState{
  final String error;
  const ErrorLoadingHotels(this.error);
}


class HotelBloc extends Bloc<HotelEvent,ListState>{
  HotelBloc():super(LoadingHotels()){
    final _hotelProvider = HotelProvider();
    on<GetHotelList>((event, emit) async {
      //emit the states on the bases of data
      // so the ui show the respective widgets
      emit(LoadingHotels());
      var list = await _hotelProvider.getHotels();
      if(list is ErrorModel){
        emit(ErrorLoadingHotels(list.message));
      }else if(list is List<HotelModel>){
        if(list.isEmpty){
          emit(NoHotelFound());
        }else{
          emit(HotelsLoaded(list));
        }
      }else{
        emit(const ErrorLoadingHotels('Unknown reasons'));
      }
    });
  }
}
