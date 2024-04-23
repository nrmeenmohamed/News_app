


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit():super(AppInitialState());

  static AppCubit get(context) =>BlocProvider.of(context);



  // // logic
  // int currentIndex = 0;
  // List<Widget> screens = [
  //   NewTasks(),
  //   DoneTasks(),
  //   ArchivedTasks(),
  // ];
  // List<String> titles = [
  //   'New Tasks',
  //   'Done Tasks',
  //   'Archived Tasks',
  // ];
  //
  //
  //
  // void changeIndex(int index){
  //   currentIndex = index;
  //   emit(AppChangeBottomNavBarState());
  // }
  //
  //
  // // news app
  // bool isDark = false;
  // void changeAppMode({bool? fromShared}){
  //   if(fromShared != null){
  //     isDark = fromShared;
  //     emit(AppChangeModeState());
  //   }
  //   else{
  //     isDark = !isDark;
  //     CacheHelper.putBool(key: 'isDark', value: isDark).then((value){
  //       emit(AppChangeModeState());
  //     });
  //   }
  //
  // }
}