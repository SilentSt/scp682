import 'package:location/location.dart';

Future movingAlg(Location location) async
{
  var _locationData = await location.getLocation();
  return _locationData;
}