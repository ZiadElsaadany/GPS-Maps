import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      updateUserMarker(  );

    });

  // s




  }

  double defaultLat  = 30.0364361;
  double defaultLong  = 31.2030135;

  var userMarker;

 void updateUserMarker(

     ) {
 userMarker =
   Marker(markerId: const MarkerId("user_location"),
   position: LatLng(
   defaultLat,
   defaultLong
   // BlocProvider.of<HomeCubit>(context).locationData?.latitude??defaultLat,
   // BlocProvider.of<HomeCubit>(context).locationData?.longitude??defaultLong
   )
   );
 emit(UpdateUserMarkerState());
 }


 late CameraPosition kLake ;
 kLakeInitialized( ) {
   kLake = CameraPosition(
       bearing: 192.8334901395799,
       target: LatLng(
           defaultLat,
           defaultLong
         // BlocProvider.of<HomeCubit>(context).locationData?.latitude??defaultLat
         // , BlocProvider.of<HomeCubit>(context).locationData?.longitude??defaultLong
       ),
       tilt: 59.440717697143555,
       zoom: 19.151926040649414);
 }

  late CameraPosition kGooglePlex ;


  kGooglePlexInitialized( ) {
    kGooglePlex = CameraPosition(
   target: LatLng(

   defaultLat ,
   defaultLong
   // BlocProvider.of<HomeCubit>(context).locationData?.latitude??defaultLat
   // , BlocProvider.of<HomeCubit>(context).locationData?.longitude??defaultLong

   ),
   zoom: 14.4746,
   );
 }
// to Change  Camera to lake

  Future<void> goToTheLake(
      Completer<GoogleMapController> controller_
      ) async {
    final GoogleMapController controller = await controller_.future;

      await controller.animateCamera(CameraUpdate.newCameraPosition(kLake));

  }

  //  to change camera whhen change location
   Future<void> changeCameraToUser (
      Completer<GoogleMapController> controller_
      ) async {
    final GoogleMapController controller = await controller_.future;

      await controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(
                  defaultLat,
                  defaultLong
                // BlocProvider.of<HomeCubit>(context).locationData?.latitude??defaultLat
                // , BlocProvider.of<HomeCubit>(context).locationData?.longitude??defaultLong
              ),
              tilt: 59.440717697143555,
              zoom: 19.151926040649414)

      ));

  }



  // dispose
  stopLocationListener( ) {
    locationListener?.cancel();
  }


}
