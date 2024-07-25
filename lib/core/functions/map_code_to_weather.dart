String mapCodeToWearher(int code) {
  if (code == 0.0) {
    return "sunny";
  } else if (code >= 1 && code <= 61) {
    return "cloud_sun";
  } else if (code >= 65) {
    return "raining";
  } else {
    return "cloud_sun_rain";
  }
}
