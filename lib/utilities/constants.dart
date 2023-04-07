const int kHttpSuccessful = 200;

const String kWeatherAPIAuthority = 'api.open-meteo.com';
const String kWeatherAPIPath = '/v1/forecast';
const Map<String, String> kWeatherAPIQueryParameters = {
  'hourly':
      'temperature_2m,apparent_temperature,precipitation_probability,precipitation,rain,weathercode,visibility',
  'daily':
      'temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,precipitation_sum,rain_sum,precipitation_hours,windspeed_10m_max',
  'forecast_days': '1',
  'timezone': 'auto',
};

const Map<String, String> kWeatherCodeConditionDescription = {
  '0': 'Clear sky',
  '1': 'Mainly clear',
  '2': 'Partly cloudy',
  '3': 'Overcast',
  '45': 'Fog',
  '48': 'Depositing rime fog',
  '51': 'Drizzle: Light intensity',
  '53': 'Drizzle: Moderate intensity',
  '55': 'Drizzle: Dense intensity',
  '56': 'Freezing Drizzle: Light intensity',
  '57': 'Freezing Drizzle: Dense intensity',
  '61': 'Rain: Slight intensity',
  '63': 'Rain: Moderate intensity',
  '65': 'Rain: Heavy intensity',
  '66': 'Freezing Rain: Light intensity',
  '67': 'Freezing Rain: Heavy intensity',
  '71': 'Snow fall: Slight intensity',
  '73': 'Snow fall: Moderate intensity',
  '75': 'Snow fall: Heavy intensity',
  '77': 'Snow grains',
  '80': 'Rain showers: Slight intensity',
  '81': 'Rain showers: Moderate intensity',
  '82': 'Rain showers: Violent intensity',
  '85': 'Snow showers slight intensity',
  '86': 'Snow showers heavy intensity',
  '95': 'Thunderstorm: Slight or moderate intensity',
  '96': 'Thunderstorm with slight hail',
  '99': 'Thunderstorm with heavy hail',
};
