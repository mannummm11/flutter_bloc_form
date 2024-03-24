part of 'homebloc.dart';

abstract class HomeBlocEvent {}

class HomeInitiateEvent extends HomeBlocEvent{}
class GetFoodsEvent extends HomeBlocEvent{}
class GetFoodDataInProgressEvent extends HomeBlocEvent{}
class GetFoodDataCompletedEvent extends HomeBlocEvent{
  List<FoodReceipeModel> value;
  GetFoodDataCompletedEvent(this.value);
}
class GetFoodDataErrorEvent extends HomeBlocEvent{}
class AddFoodToFavouriteEvent extends HomeBlocEvent{
  List<FoodReceipeModel> value;
  AddFoodToFavouriteEvent(this.value);
}
class UpdateFavouriteCountEvent extends HomeBlocEvent {
  List<FoodReceipeModel> value;
  UpdateFavouriteCountEvent(this.value);
}
