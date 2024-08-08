import 'package:auto_route/auto_route.dart';
import 'package:dailyx/core/di/di.dart';
import 'package:dailyx/presentation/widgets/appbar/custom_app_bar.dart';
import 'package:dailyx/presentation/widgets/end_drawer/custom_end_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/main_page_cubit.dart';


@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  

  @override
  Widget build(BuildContext context) {
    final MainPageCubit cubit = di.get<MainPageCubit>();
    cubit.getTasksList();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Hi'),
      body: BlocProvider<MainPageCubit>(
        create: (context) => cubit,
        child: BlocBuilder<MainPageCubit, MainPageState>(
          builder: (context, state) => Padding(padding: const EdgeInsets.all(12.0), child: _buildContent(context, cubit),),
        )
      ),
      endDrawer: const CustomEndDrawer(),
    );
  }
  
  Widget _buildContent(BuildContext context, MainPageCubit cubit) {
    bool isDone = false;

    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(height: 15, thickness: 0.0, color: Colors.white,),
      itemCount: BlocProvider.of<MainPageCubit>(context).tasks.length,
      itemBuilder: (context, index) {
        return Builder(builder: (context) => Card(
          color: const Color.fromARGB(255, 255, 218, 162),
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Expanded(
                child: Checkbox(
                  value: isDone, 
                  onChanged: (value) {
                    setState(() {
                      isDone = value!;
                    });
                }),
              ),
              Text(cubit.tasks[index].summary)
            ],
          ),
        ));
      }
    );
  }

  bool _getCheckerValue({bool value = false}){
    return value;
  }
}
