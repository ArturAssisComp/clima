Map<String, String> _kOpenMeteoWeatherCodeEmoji = {
  '0': '☀️',
  '1': '🌤️',
  '2': '⛅',
  '3': '☁️',
  '45': '🌫️',
  '48': '🌫️',
  '51': '🌧️',
  '53': '🌧️',
  '55': '🌧️',
  '56': '🌨️',
  '57': '🌨️',
  '61': '🌦️',
  '63': '🌧️',
  '65': '🌧️',
  '66': '🌨️',
  '67': '🌨️',
  '71': '❄️',
  '73': '❄️',
  '75': '❄️',
  '77': '❄️',
  '80': '🌨️',
  '81': '🌨️',
  '82': '🌧️',
  '85': '❄️',
  '86': '❄️',
  '95': '🌫️',
  '96': '🌫️',
  '99': '🌫️',
};

class WeatherModel {
  String getWeatherIcon(String weatherCode) {
    return _kOpenMeteoWeatherCodeEmoji[weatherCode]!;
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
