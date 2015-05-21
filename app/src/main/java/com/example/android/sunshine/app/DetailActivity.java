package com.example.android.sunshine.app;

import android.content.Intent;
import android.support.v4.view.MenuCompat;
import android.support.v4.view.MenuItemCompat;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.ActionBar;
import android.support.v4.app.Fragment;
import android.os.Bundle;
import android.support.v7.widget.ShareActionProvider;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.os.Build;
import android.widget.TextView;


public class DetailActivity extends ActionBarActivity {
    MenuItem menuShare = null;
    private ShareActionProvider shareActionProvider;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);
        if (savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.container, new PlaceholderFragment())
                    .commit();
        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_detail, menu);

        menuShare = menu.findItem(R.id.action_share);

        try {
            shareActionProvider = (ShareActionProvider) MenuItemCompat.getActionProvider(menuShare);
        } catch (Exception e) {
            Log.d("ERROR", "ShareIntent: " + e.getMessage(), e);
        }

        try {
            Intent shareIntent = new Intent();
            shareIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_DOCUMENT);
            shareIntent.setAction(Intent.ACTION_SEND);
            shareIntent.putExtra(Intent.EXTRA_TEXT, getIntent().getStringExtra(Intent.EXTRA_TEXT) + " #SunshineApp");
            shareIntent.setType("text/plain");

            shareActionProvider.setShareIntent(shareIntent);
        } catch (Exception e) {
            Log.d("ERROR", "ShareIntent: " + e.getMessage(), e);
        }
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

        public PlaceholderFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                                 Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_detail, container, false);
            String details = getActivity().getIntent().getStringExtra(Intent.EXTRA_TEXT);
            TextView tv = (TextView) rootView.findViewById(R.id.detail_text);
            tv.setText(details);

            return rootView;
        }
    }
}
