package com.example.android.sunshine.app;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.media.audiofx.BassBoost;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.support.v4.app.Fragment;
import android.text.format.Time;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 * A placeholder fragment containing a simple view.
 */
public class ForecastFragment extends Fragment {
    ArrayAdapter<String> forecastAdapter = null;
    String[] cityDetails = null;

    public ForecastFragment() {
    }

    @Override
    public void onStart() {
        super.onStart();
        updateWeather();
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setHasOptionsMenu(true);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        inflater.inflate(R.menu.forecastfragment, menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();Log.d("MENU", "MENU ID: " + id);Log.d("MENU", "ACTION: " + R.id.action_show_location);
        if (id == R.id.action_refresh){
            updateWeather();
            return true;
        }

        if (id == R.id.action_settings) {
            Intent settingsIntent = new Intent(getActivity(), SettingsActivity.class);
            startActivity(settingsIntent);
        }

        if (id == R.id.action_show_location) {
            Intent intent = new Intent(Intent.ACTION_VIEW);
            Uri location = Uri.parse("geo:0,0?q="+cityDetails[1]+","+cityDetails[2]+"("+cityDetails[0]+")");
            intent.setData(location);
            if (intent.resolveActivity(getActivity().getPackageManager()) != null) {
                startActivity(intent);
            }
        }

        return super.onOptionsItemSelected(item);
    }

    public void updateWeather(){
        FetchWeatherTask fetchWeatherTask = new FetchWeatherTask();

        SharedPreferences sharedPref = PreferenceManager.getDefaultSharedPreferences(getActivity());
        String default_location = getResources().getString(R.string.pref_location_default);
        String pref_location = sharedPref.getString(getString(R.string.pref_location_key), default_location);
        Log.d("PREF", "DEFAULT LOCATION: " + default_location);
        Log.d("PREF", "SETTING LOCATION: " + pref_location);
        String default_units = getString(R.string.pref_units_default);
        String pref_units = sharedPref.getString(getString(R.string.pref_units_key), default_units);
        Log.d("PREF", "DEFAULT UNITS: " + default_units);
        Log.d("PREF", "SETTING UNITS: " + pref_units);
        fetchWeatherTask.execute(pref_location, pref_units);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View rootView = inflater.inflate(R.layout.fragment_main, container, false);

        forecastAdapter = new ArrayAdapter<String>(this.getActivity(),
                                                                        R.layout.list_item_forecast,
                                                                        R.id.list_item_forecast_textview,
                                                                        new ArrayList<String>());

        final ListView listViewForecast =  (ListView)rootView.findViewById(R.id.listview_forecast);
        listViewForecast.setAdapter(forecastAdapter);
        listViewForecast.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Toast.makeText(getActivity(), forecastAdapter.getItem(position), Toast.LENGTH_SHORT).show();
                Intent detailIntent = new Intent(getActivity(), DetailActivity.class);
                detailIntent.putExtra(Intent.EXTRA_TEXT, forecastAdapter.getItem(position));
                startActivity(detailIntent);
            }
        });

        String forecastJsonStr = null;

        return rootView;
    }

    private class FetchWeatherTask extends AsyncTask<String, Integer, String[]>{

        private final String LOG_TAG = FetchWeatherTask.class.getSimpleName();

        @Override
        protected String[] doInBackground(String... params) {
            String forecastJsonStr =  null;
            HttpURLConnection urlConnection = null;
            BufferedReader reader = null;
            String[] forecastStrs = null;

            try {
                final String FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?";
                final String QUERY_PARAM = "q";
                final String FORMAT_PARAM = "mode";
                final String UNITS_PARAM = "units";
                final String DAYS_PARAM = "cnt";

                Uri builtUri = Uri.parse(FORECAST_BASE_URL).buildUpon()
                        .appendQueryParameter(QUERY_PARAM, params[0])
                        .appendQueryParameter(FORMAT_PARAM, "json")
                        .appendQueryParameter(UNITS_PARAM, "metric")
                        .appendQueryParameter(DAYS_PARAM, Integer.toString(7)).build();
                //Log.v(LOG_TAG, "URL: " + builtUri.toString());

                URL url = new URL(builtUri.toString());

                urlConnection = (HttpURLConnection) url.openConnection();
                urlConnection.setRequestMethod("GET");
                urlConnection.connect();

                InputStream inputStream = urlConnection.getInputStream();
                StringBuffer buffer = new StringBuffer();
                if (inputStream == null) {
                    return null;
                }
                reader = new BufferedReader(new InputStreamReader(inputStream));

                String line;
                while ((line = reader.readLine()) != null) {
                    buffer.append(line + "\n");
                }

                if (buffer.length() == 0) {
                    return null;
                }
                forecastJsonStr = buffer.toString();
                //Log.d("JSON", forecastJsonStr);
                forecastStrs = getWeatherDataFromJson(forecastJsonStr, 7, params[1]);
                cityDetails = getCityFromJson(forecastJsonStr);
            } catch (Exception e) {
                Log.e(LOG_TAG, "General Error: " + e.getMessage(), e);
                return null;
            } finally{
                if (urlConnection != null) {
                    urlConnection.disconnect();
                }
                if (reader != null) {
                    try {
                        reader.close();
                    } catch (final IOException e) {
                        Log.e(LOG_TAG, "Error closing stream", e);
                    }
                }
            }
            //Log.v(LOG_TAG, "JSON: " + forecastJsonStr);

            return forecastStrs;
        }

        private String getReadableDateString(long time){
            // Because the API returns a unix timestamp (measured in seconds),
            // it must be converted to milliseconds in order to be converted to valid date.
            SimpleDateFormat shortenedDateFormat = new SimpleDateFormat("EEE MMM dd");
            return shortenedDateFormat.format(time);
        }

        /**
         * Prepare the weather high/lows for presentation.
         */
        private String formatHighLows(double high, double low) {
            // For presentation, assume the user doesn't care about tenths of a degree.
            long roundedHigh = Math.round(high);
            long roundedLow = Math.round(low);

            String highLowStr = roundedHigh + "/" + roundedLow;
            return highLowStr;
        }

        private String[] getCityFromJson(String forecastJsonStr) throws JSONException {
            final String OWM_CITY = "city";
            final String OWM_CITY_NAME = "name";
            final String OWM_CORD = "coord";
            final String OWM_LAT = "lat";
            final String OWM_LON = "lon";

            JSONObject forecastJson = new JSONObject(forecastJsonStr);

            JSONObject city = forecastJson.getJSONObject(OWM_CITY);
            String cityName = city.getString(OWM_CITY_NAME);
            JSONObject coord = city.getJSONObject(OWM_CORD);
            Double lat = coord.getDouble(OWM_LAT);
            Double lon = coord.getDouble(OWM_LON);

            String[] cityResult = new String[3];
            cityResult[0] = cityName;
            cityResult[1] = lat.toString();
            cityResult[2] = lon.toString();

            Log.d("CITY", cityResult[0] + "(" + cityResult[1] + ", " + cityResult[2] + ")");

            return cityResult;
        }

        /**
         * Take the String representing the complete forecast in JSON Format and
         * pull out the data we need to construct the Strings needed for the wireframes.
         *
         * Fortunately parsing is easy:  constructor takes the JSON string and converts it
         * into an Object hierarchy for us.
         */
        private String[] getWeatherDataFromJson(String forecastJsonStr, int numDays, String units)
                throws JSONException {

            // These are the names of the JSON objects that need to be extracted.
            final String OWM_LIST = "list";
            final String OWM_WEATHER = "weather";
            final String OWM_TEMPERATURE = "temp";
            final String OWM_MAX = "max";
            final String OWM_MIN = "min";
            final String OWM_DESCRIPTION = "main";


            JSONObject forecastJson = new JSONObject(forecastJsonStr);
            JSONArray weatherArray = forecastJson.getJSONArray(OWM_LIST);

            // OWM returns daily forecasts based upon the local time of the city that is being
            // asked for, which means that we need to know the GMT offset to translate this data
            // properly.

            // Since this data is also sent in-order and the first day is always the
            // current day, we're going to take advantage of that to get a nice
            // normalized UTC date for all of our weather.

            Time dayTime = new Time();
            dayTime.setToNow();

            // we start at the day returned by local time. Otherwise this is a mess.
            int julianStartDay = Time.getJulianDay(System.currentTimeMillis(), dayTime.gmtoff);

            // now we work exclusively in UTC
            dayTime = new Time();

            String[] resultStrs = new String[numDays];
            for(int i = 0; i < weatherArray.length(); i++) {
                // For now, using the format "Day, description, hi/low"
                String day;
                String description;
                String highAndLow;

                // Get the JSON object representing the day
                JSONObject dayForecast = weatherArray.getJSONObject(i);

                // The date/time is returned as a long.  We need to convert that
                // into something human-readable, since most people won't read "1400356800" as
                // "this saturday".
                long dateTime;
                // Cheating to convert this to UTC time, which is what we want anyhow
                dateTime = dayTime.setJulianDay(julianStartDay+i);
                day = getReadableDateString(dateTime);

                // description is in a child array called "weather", which is 1 element long.
                JSONObject weatherObject = dayForecast.getJSONArray(OWM_WEATHER).getJSONObject(0);
                description = weatherObject.getString(OWM_DESCRIPTION);

                // Temperatures are in a child object called "temp".  Try not to name variables
                // "temp" when working with temperature.  It confuses everybody.
                JSONObject temperatureObject = dayForecast.getJSONObject(OWM_TEMPERATURE);
                double high = temperatureObject.getDouble(OWM_MAX);
                double low = temperatureObject.getDouble(OWM_MIN);
                if (units.equalsIgnoreCase("imperial")){
                    high = high * 1.8 + 32;
                    low = low * 1.8 + 32;
                }

                highAndLow = formatHighLows(high, low);
                resultStrs[i] = day + " - " + description + " - " + highAndLow;
            }

            for (String s : resultStrs) {
                //Log.v(LOG_TAG, "Forecast entry: " + s);
            }
            return resultStrs;

        }

        @Override
        protected void onPostExecute(String[] strings) {
            super.onPostExecute(strings);
            forecastAdapter.clear();
            forecastAdapter.addAll(strings);
        }
    }
}
