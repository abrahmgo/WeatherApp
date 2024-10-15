
![weather-forecast](https://github.com/user-attachments/assets/ea46c2ed-ea5d-4aab-acd1-9a105e674dfe)


# Exercise

Weather app, this application is a demo that takes several swift topics, such as location, notification, apis, core data among others.

## Before to start

Go to ```APIConfig``` file and **set token property with your own value**

```swift
    static var token: String {
        return "534535346456fdg3dfer345fe435"
    }
```

## Features

- Weather for current location
- Search cities and its location
- Save favority city
- Delete favority city
- Set notification for your favority city

## App Settings

- Change app language
- Change url server, thi option it will available if we have two or more servers/environments
  
Go to settings app, select Weather app, change language

<img width="447" alt="Captura de pantalla 2024-10-14 a la(s) 6 38 17 p m" src="https://github.com/user-attachments/assets/2434b1b5-9b37-4175-83ac-cd5923f66f40">

## Demo

| Location  | Weather |
| ------------- | ------------- |
|  ![Simulator Screenshot - iPhone 15 Pro - 2024-10-14 at 18 47 34](https://github.com/user-attachments/assets/691730cd-33a5-41d6-b679-e6d461858fd0) | ![Simulator Screenshot - iPhone 15 Pro - 2024-10-14 at 18 51 36](https://github.com/user-attachments/assets/76d5a22a-d454-4e54-aea7-d2aab7298315)
 |
| Delete  | 
| ------------- |
|![Simulator Screenshot - iPhone 15 Pro - 2024-10-14 at 18 48 49](https://github.com/user-attachments/assets/3530c2a5-3fca-4804-8d04-bc99f78d95d5)
  |

## API Reference

#### Get weather for certain location

```http
  GET https://api.openweathermap.org/data/2.5/weather?lat={lat}lang={lang}&lon={lon}&appid={API key}
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `lat` | `String` | latitude |
| `lon` | `String` | longitude|
| `API key` | `Double` | api key |
| `lan` | `String` | language |
| `units` | `String` | Units of measurement |


Review https://openweathermap.org/current for language types and units type

#### Get weather for certain location

```http
  GET https://openweathermap.org/img/wn/{nameImage}2x.png
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `nameImage` | `String` | icon name, see response |

Example for api

```json
                          
{
   "coord": {
      "lon": 7.367,
      "lat": 45.133
   },
   "weather": [
      {
         "id": 501,
         "main": "Rain",
         "description": "moderate rain",
         "icon": "10d"
      }
   ],
   "base": "stations",
   "main": {
      "temp": 284.2,
      "feels_like": 282.93,
      "temp_min": 283.06,
      "temp_max": 286.82,
      "pressure": 1021,
      "humidity": 60,
      "sea_level": 1021,
      "grnd_level": 910
   },
   "visibility": 10000,
   "wind": {
      "speed": 4.09,
      "deg": 121,
      "gust": 3.47
   },
   "rain": {
      "1h": 2.73
   },
   "clouds": {
      "all": 83
   },
   "dt": 1726660758,
   "sys": {
      "type": 1,
      "id": 6736,
      "country": "IT",
      "sunrise": 1726636384,
      "sunset": 1726680975
   },
   "timezone": 7200,
   "id": 3165523,
   "name": "Province of Turin",
   "cod": 200
}                    
                        
```


## Authors

- [@abrahmgo](https://www.github.com/abrahmgo)

