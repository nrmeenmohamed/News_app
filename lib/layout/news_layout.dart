import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/state.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {

         var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: (){
                  cubit.changeMode();
                },
                icon: Icon(
                  Icons.brightness_4,
                ),
              ),

            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
          ),
          body: cubit.screens[cubit.currentIndex],
        );

      },
    );
  }
}
