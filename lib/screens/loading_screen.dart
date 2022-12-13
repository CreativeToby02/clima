import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    // getCurrentLocation();
  }

  void getCurrentLocation() async {
    Location location = Location();
    await location.getLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude.34&lon=$longitude.99&appid=$apiKey');
    dynamic decodedData = await networkHelper.getData();

    double temperature = decodedData['main']['temp'];
    print(temperature);
    print(latitude);
    print(longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/ic_launcher-web.png',
              alignment: Alignment.center,
              scale: 6,
            ),
            const SizedBox(
              height: 8,
            ),
            SpinKitThreeBounce(
              color: Colors.white,
              size: 50.0,
            ),
            ElevatedButton(
              onPressed: getCurrentLocation,
              child: Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}
