# AI-Powered Weather App

This repository contains the source code for an AI-powered weather application for iOS. Built with SwiftUI, this app provides real-time weather information and personalized clothing recommendations based on the current conditions.

---

## Features

### Real-Time Weather Data
The app fetches and displays up-to-the-minute weather information, including temperature, humidity, precipitation, cloud cover, and wind speed. The UI is clean, intuitive, and features a dynamic background that changes with the time of day.

![Real-Time Weather](images/weather-app-main.png)

### AI-Powered Clothing Recommendations
A standout feature of this app is its AI-driven clothing recommendation engine. Based on the current weather, the app suggests appropriate attire to ensure you're always dressed for the conditions.

![AI Recommendations](images/weather-app-ai.png)

### Detailed Weather Metrics
For those who want more than just the temperature, the app provides a detailed breakdown of key weather metrics, all presented in a clean, easy-to-read interface.

![Detailed Metrics](images/weather-app-details.png)

---

## Tech Stack

* **UI Framework:** SwiftUI
* **AI/ML:** GPT-4 API for clothing recommendations
* **Networking:** URLSession for API requests
* **Language:** Swift

---

## How It Works

The app uses the device's location to fetch weather data from a third-party API. This data is then sent to the GPT-4 API, which returns a personalized clothing recommendation based on the weather conditions. The UI is built entirely with SwiftUI, ensuring a modern and responsive user experience.
