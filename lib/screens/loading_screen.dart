import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/screens/location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Location location = Location();
    await location.getLocation();

    NetworkHelper networkHelper = await NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=7bba544d21031439d2242f529ed44f92&units=metric');
    dynamic decodedData = await networkHelper.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(weatherData: decodedData);
    }));
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
            // ElevatedButton(
            //   onPressed: getCurrentLocation,
            //   child: Text('Get Location'),
            // ),
          ],
        ),
      ),
    );
  }
}
