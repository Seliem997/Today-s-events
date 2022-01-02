import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},
      builder: (context, state) {
        var list=NewsCubit.get(context).sport;
        return Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) => list.isNotEmpty,
            widgetBuilder: (BuildContext context) {
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index) => buildArticleItem(list[index], context),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
                itemCount: list.length,
              );
            },
            fallbackBuilder: (context) => const Center(child: CircularProgressIndicator())
        );
      },
    );
  }
}
