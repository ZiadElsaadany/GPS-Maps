# Maps

# Location
location Packcage: [https://pub.dev/packages/location]
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

