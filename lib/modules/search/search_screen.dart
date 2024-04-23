import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/state.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return  BlocConsumer<NewsCubit, NewsState>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    label: 'search',
                    prefix: Icons.search,
                    validate: (String value){
                      if(value.isEmpty){
                        return " search must not be empty";
                      }
                      return null;
                    },
                    onChange: (value){
                      NewsCubit.get(context).getSearch(value);
                    }
                ),
              ),
              Expanded(child: articleBuilder(list, context, isSearch: true)),
            ],
          ),
        );

      },
    );
  }
}
