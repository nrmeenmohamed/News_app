import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? submit,
  Function? onChange,
  Function()? suffixPressed,
  Function? onTap,
  //required String Function(String?) validate,
  required Function validate,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ? IconButton(icon: Icon(suffix),onPressed: (){suffixPressed!();},) : null,
    border: OutlineInputBorder(),
  ),
  onFieldSubmitted: (value){submit!();},
  onChanged: (value)
  {
    onChange!(value);
  },
  onTap: onTap != null ? (){onTap()!;} : null,
  validator: (value)
  {
    validate(value);
  },
);





Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0,),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


void navigateTo(context, Widget widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget
    ),
);



Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),

            image: DecorationImage(

              image:NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(width: 20,),

        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children: [

              Text(

                '${article['title']}',

                style: Theme.of(context).textTheme.titleMedium,

                maxLines: 3,

                overflow: TextOverflow.ellipsis,

              ),

              Text(

               '${article['publishedAt']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),



            ],

          ),

        ),

      ],

    ),

  ),
);


Widget articleBuilder(list, context,{isSearch}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (BuildContext context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index], context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: list.length,
  ),
  fallback: (BuildContext context) => isSearch != null ? Container() : Center(child: CircularProgressIndicator()),
);