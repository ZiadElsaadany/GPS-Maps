
import 'package:flutter/material.dart';
import 'package:gps/home/presentation/view/home_screen.dart';
import 'package:location/location.dart';

void main() {
  runApp( GPS());
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
    getUserLocation();
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

  late PermissionStatus permissionStatus;

   bool serviceEnabled= false;

  Location location =  Location();

  //to get permission that allow user to get permission
Future<bool> isPermissionGranted( ) async{
  permissionStatus=await location.hasPermission();
if(permissionStatus== PermissionStatus.denied) {
  // not allow using location
  //request to permission from user to use location
   permissionStatus = await location.requestPermission();
}
return permissionStatus == PermissionStatus.granted;
}

// no internet and gps
Future<bool> isServiceEnabled ( ) async {
  serviceEnabled =await location.serviceEnabled();
if(!serviceEnabled) {
  // to open the service  --> gps
 serviceEnabled = await location.requestService();
}
return serviceEnabled ;
}

// get location
  LocationData ? locationData ;

getUserLocation( )async {
bool granted=   await isPermissionGranted();
if(!granted) {
  // user denied permission
  return ;
}
 bool gpsEnabled =  await isServiceEnabled();
if(!gpsEnabled){
  // user didn't allow to open GPS
  return;
}
locationData =     await location.getLocation();
print(locationData?.latitude.toString());
print(locationData?.longitude.toString());



}
}
