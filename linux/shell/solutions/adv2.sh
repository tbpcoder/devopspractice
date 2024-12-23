#!/bin/bash

API_KEY="your_api_key"
CITY="Bangalore"
URL="http://api.openweathermap.org/data/2.5/weather?q=$CITY&appid=$API_KEY&units=metric"

WEATHER=$(curl -s "$URL" | jq '. | {temperature: .main.temp, weather: .weather[0].description}')

echo "Current weather in $CITY:"
echo "$WEATHER"
