import 'package:bloc/bloc.dart';
import 'package:flutterbloctutorial/data/apiserviceimpl.dart';
import 'package:flutterbloctutorial/data/entity/FoodReceipeModel.dart';
import 'package:flutterbloctutorial/domain/apiservices.dart';
import 'package:meta/meta.dart';

part 'homebloc_event.dart';
part 'homebloc_state.dart';

class HomeBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  APIService apiService = APIServiceImp();
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitiateEvent>((event, emit) => homeInitiate());
    on<GetFoodDataInProgressEvent>((event, emit) => GetFoodDataInProgress());
    on<GetFoodDataCompletedEvent>((event, emit) => GetFoodDataCompleted(event));
    on<GetFoodDataErrorEvent>((event, emit) =>GetFoodDataError());
    on<AddFoodToFavouriteEvent>((event, emit) => AddFoodToFavourite(event.value));
    on<UpdateFavouriteCountEvent>((event, emit) => UpdateFavouriteCount(event.value));
  }
  GetFoodDataInProgress() {
    emit(GetFoodDataInProgressState());
  }

  GetFoodDataCompleted(GetFoodDataCompletedEvent event) {
    emit(GetFoodDataCompletedState(event.value));
  }

  homeInitiate() {
    emit(HomeInitialState());
  }

  GetFoodDataError() {
    emit(GetFoodDataErrorState());
  }

  AddFoodToFavourite(List<FoodReceipeModel> value) {
    emit(AddFoodToFavouriteState(value));
  }

  UpdateFavouriteCount(List<FoodReceipeModel> value) {
    emit(UpdateFavouriteCountState(value));
  }





}