import 'package:flutter/material.dart';
import 'package:flutter_foreca/screens/location_screen.dart';
import 'package:flutter_foreca/services/location.dart';
import 'package:flutter_foreca/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '119c85091039a4cdfea5fb1abae83b52';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();
    navigate();
  }

  void navigate() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const LocationScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100.0,
      )),
    );
  }
}


