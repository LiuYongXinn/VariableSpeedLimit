package com.vissim.pojo;

public enum WeatherEnum {
    CLEAR(1),
    FOG(2),
    LIGHT_RAIN(3),
    MODERATE_RAIN(4),
    HEAVY_RAIN(5),
    SNOW(6);

    private final int weatherIndex;


    WeatherEnum(int weatherIndex) {
        this.weatherIndex = weatherIndex;
    }

    public int getWeatherIndex() {
        return weatherIndex;
    }
}
