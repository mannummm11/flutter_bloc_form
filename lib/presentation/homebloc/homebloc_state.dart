part of 'homebloc.dart';


abstract class HomeBlocState {}

class HomeInitialState extends HomeBlocState {}
class GetFoodDataInProgressState extends HomeBlocState{}
class GetFoodDataCompletedState extends HomeBlocState{
  List<FoodReceipeModel> list = [];
  GetFoodDataCompletedState(this.list);
}
class GetFoodDataErrorState extends HomeBlocState{}
class AddFoodToFavouriteState extends HomeBlocState{
  List<FoodReceipeModel> list = [];
  AddFoodToFavouriteState(this.list);
}
class UpdateFavouriteCountState extends HomeBlocState {
  List<FoodReceipeModel> list = [];
  UpdateFavouriteCountState(this.list);
}
