import 'package:bloc/bloc.dart';
import '../bloc/bloc.dart';
import '../repository/repository.dart';
import '../models/weather.dart';
import 'package:meta/meta.dart';

class WeatherBloc extends Bloc<WeatherEvents, WeatherStates> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherEmpty());

  @override
  Stream<WeatherStates> mapEventToState(
    WeatherEvents event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (error) {
        print(error);
        yield WeatherError();
      }
    } else if (event is RefreshWeather) {
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (e) {
        print("Error $e");
        yield state;
      }
    } else if (event is ResetWeather) {
      yield WeatherEmpty();
    }
  }
}
