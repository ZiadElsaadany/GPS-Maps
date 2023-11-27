import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps/home/presentation/view_model/home_cubit/home_states.dart';
import 'package:location/location.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());


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
 StreamSubscription<LocationData>?  locationListener ;
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
    if (kDebugMode) {
      print(locationData?.latitude.toString());
    }
    if (kDebugMode) {
      print(locationData?.longitude.toString());
    }
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval:1000,
      distanceFilter: 10
    );
  locationListener =  location.onLocationChanged.listen((newestLocation) {
      locationData =    newestLocation;

    });

  // s




  }

  // dispose
  stopLocationListener( ) {
    locationListener?.cancel();
  }

}
