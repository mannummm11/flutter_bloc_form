import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloctutorial/data/apiserviceimpl.dart';
import 'package:flutterbloctutorial/data/entity/FoodReceipeModel.dart';
import 'package:flutterbloctutorial/presentation/homebloc/homebloc.dart';
import 'package:flutterbloctutorial/presentation/homeui/user_register.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final apiService = APIServiceImp();
  final rec = "dosa";
  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = context.read<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<HomeBloc, HomeBlocState>(
        builder: ((context, state)  {
          switch (state) {
            case HomeInitialState():
              {
                _homeBloc.add(GetFoodDataInProgressEvent());
                _homeBloc.apiService
                    .getFoodReceipe(rec)
                    .then((value) => {
                  _homeBloc.add(GetFoodDataCompletedEvent(value)),
                })
                    .onError((error, stackTrace) =>
                {_homeBloc.add(GetFoodDataErrorEvent())});
                return Scaffold();
              }

            case GetFoodDataInProgressState():
              return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                    ),
                  ));

            case GetFoodDataCompletedState():
              return Scaffold(
                  appBar: getAppBar(
                      state.list.where((element) => element.isSelected).length),
                  body: createInitialUi(state.list));

            case GetFoodDataErrorState():
              return Scaffold(
                body: Center(child: Text("ERROR")),
              );

            case AddFoodToFavouriteState():
              return Scaffold(
                  appBar: getAppBar(
                      state.list.where((element) => element.isSelected).length),
                  body: createInitialUi(state.list));

            case UpdateFavouriteCountState():
              return Scaffold(
                  appBar: getAppBar(
                      state.list.where((element) => element.isSelected).length),
                  body: createInitialUi(state.list));

            default:
              return Scaffold(
                body: Text("default"),
              );
          }
        }),
        listener: ((context, state) {

        }),
      ),
    );
  }

  AppBar getAppBar(int favCount) {
    return AppBar(
      title: Text(
        "Lets Makeit",
        style: TextStyle(color: Colors.white, fontSize: 22),
      ),
      backgroundColor: Colors.blueAccent,
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shop,
              color: Colors.white,
            )),
        Stack(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UserRegister()));
                },
                icon: Icon(
                  Icons.favorite,
                  color: favCount > 0 ? Colors.red : Colors.white,
                )),
            Positioned(
                right: 13,
                top: -1,
                child: Text(
                  favCount > 0 ? favCount.toString() : "",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.yellow),
                )),
          ],
        )
      ],
    );
  }

  Widget createInitialUi(List<FoodReceipeModel> foodItems) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        Card(
                          child: Image.network(
                            foodItems[index].imageUrl,
                            width: double.maxFinite,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodItems[index].label,
                                style: TextStyle(
                                    letterSpacing: 3,
                                    backgroundColor: Colors.orangeAccent,
                                    color: Colors.white,
                                    fontSize: 14),
                              ),
                              Text(
                                "Total Time" +
                                    foodItems[index].totalTime.toString(),
                                style: TextStyle(
                                    letterSpacing: 3,
                                    backgroundColor: Colors.orangeAccent,
                                    color: Colors.white,
                                    fontSize: 14),
                              ),
                              Text(
                                "Weight: ${foodItems[index].totalWeight.toString().substring(0, 6)}  Calories: ${foodItems[index].calories.toString().substring(0, 6)}",
                                style: TextStyle(
                                    letterSpacing: 3,
                                    backgroundColor: Colors.orangeAccent,
                                    color: Colors.white,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          left: 16,
                          bottom: 16,
                        ),
                        Positioned(
                            right: 16,
                            top: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    foodItems[index].isSelected =
                                        !foodItems[index].isSelected;
                                    _homeBloc.add(
                                        UpdateFavouriteCountEvent(foodItems));
                                    _homeBloc.add(
                                        AddFoodToFavouriteEvent(foodItems));
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: foodItems[index].isSelected
                                        ? Colors.red
                                        : Colors.white,
                                    size: 35,
                                  )),
                            ))
                      ],
                    ));
              },
              itemCount: foodItems.length,
            )));
  }
}
