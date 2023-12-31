# Maps

# Location
location Package: [https://pub.dev/packages/location]
## Config
#### AndroidMainfest.xml
```java 
 <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
 <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```
#### Ios
```swift
<key>NSLocationWhenInUseUsageDescription</key>
<string>this app access location to get closest cafes near you</string>
```
#### To use location background  
```java
<uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>
```
#### background Ios
```swift
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>this app access location to get closest cafes near you</string>
```
# Implementation
## Requests For Location And Gps
```dart 
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
```
## Get Location In Case Location And Gps Opened 
```dart 
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
```
## Listener Of Location
```dart 
 StreamSubscription<LocationData>?  locationListener ;
 locationListener =  location.onLocationChanged.listen((newestLocation) {
      locationData =    newestLocation;
    });
```
## Cancle Listener 
```dart 
 stopLocationListener( ) {
    locationListener?.cancel();
  }
```

# Google Maps With Flutter
package : **https://pub.dev/packages/google_maps_flutter**
