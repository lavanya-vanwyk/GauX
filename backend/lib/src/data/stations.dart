import 'package:gaux_contracts/gaux_contracts.dart';

/// Gautrain stations GauX operates from.
///
/// TODO(verify): coordinates are approximate (about 100 m), mirrored from
/// the app's bundled list. Check them against Gautrain's published station
/// locations; they decide the nearest station and the service area.
const gautrainStations = [
  StationDto(
    id: 'park',
    name: 'Park',
    location: GeoPoint(lat: -26.1955, lng: 28.0415),
  ),
  StationDto(
    id: 'rosebank',
    name: 'Rosebank',
    location: GeoPoint(lat: -26.1455, lng: 28.0437),
  ),
  StationDto(
    id: 'sandton',
    name: 'Sandton',
    location: GeoPoint(lat: -26.1075, lng: 28.0567),
  ),
  StationDto(
    id: 'marlboro',
    name: 'Marlboro',
    location: GeoPoint(lat: -26.0843, lng: 28.1115),
  ),
  StationDto(
    id: 'midrand',
    name: 'Midrand',
    location: GeoPoint(lat: -25.9963, lng: 28.1366),
  ),
  StationDto(
    id: 'centurion',
    name: 'Centurion',
    location: GeoPoint(lat: -25.8516, lng: 28.1897),
  ),
  StationDto(
    id: 'pretoria',
    name: 'Pretoria',
    location: GeoPoint(lat: -25.7586, lng: 28.1895),
  ),
  StationDto(
    id: 'hatfield',
    name: 'Hatfield',
    location: GeoPoint(lat: -25.7477, lng: 28.2381),
  ),
  StationDto(
    id: 'rhodesfield',
    name: 'Rhodesfield',
    location: GeoPoint(lat: -26.1265, lng: 28.2257),
  ),
  StationDto(
    id: 'or-tambo',
    name: 'OR Tambo',
    location: GeoPoint(lat: -26.1330, lng: 28.2310),
  ),
];
