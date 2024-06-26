import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/state.dart';

import '../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsState>(
      listener: (BuildContext context, NewsState state) {  },
      builder: (BuildContext context, NewsState state) {
        var list = NewsCubit.get(context).business;
        return articleBuilder(list, context);

      },
    );
  }
}
