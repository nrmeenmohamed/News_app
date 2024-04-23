import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../shared/components/components.dart';

class SportsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (BuildContext context, NewsState state) {  },
      builder: (BuildContext context, NewsState state) {
        var list = NewsCubit.get(context).sports;
        return articleBuilder(list, context);

      },
    );
  }
}
