
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps/home/presentation/view/home_screen.dart';
import 'package:gps/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:location/location.dart';

void main() {
  // if(defaultTargetPlatform==TargetPlatform.android) {
  //   AndroidGoogleMapsFlutter.useAndroidViewSurface=true;
  // }
  runApp( MultiBlocProvider(
      providers: [
        BlocProvider(create: (c)=>HomeCubit())
      ],
      child: GPS()));
}

class GPS extends StatefulWidget {
   GPS({super.key});

  @override
  State<GPS> createState() => _GPSState();
}

class _GPSState extends State<GPS> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<HomeCubit>(context).getUserLocation();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute:HomeScreen.id,
      routes: {
        HomeScreen.id:(ctx)=>const HomeScreen()
      } ,
    );
  }


}
