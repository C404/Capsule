package com.capsule.app.capsule;

import android.app.Activity;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;
import android.widget.VideoView;

public class VideoPlayer extends Activity
{
	private VideoView videoPlayer;
	
	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                WindowManager.LayoutParams.FLAG_FULLSCREEN);
		setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
		
		setContentView(R.layout.player);
		videoPlayer = (VideoView) findViewById(R.id.videoview);
		videoPlayer.setVideoPath(Global.outputFile);
		videoPlayer.start();
	}
	
	@Override
	public void onPause()
	{
		videoPlayer.pause();
		super.onPause();
		if (D.flag) Log.i(D.tag(this), "Activity paused");
	}
	
	@Override
	public void onStop()
	{
		super.onStop();
		if (D.flag) Log.i(D.tag(this), "Activity stoped");		
	}
	
	@Override
	public void onRestart()
	{
		videoPlayer.resume();
		super.onRestart();
		if (D.flag) Log.i(D.tag(this), "Activity restarted");
	}
	
	@Override
	public void onResume()
	{
		super.onResume();
		if (D.flag) Log.i(D.tag(this), "Activity resumed");
	}
	
	@Override
	public void onDestroy()
	{
		super.onDestroy();
		if (D.flag) Log.i(D.tag(this), "Activity destroyed");
	}
	
	@Override
	public void onStart()
	{
		super.onStart();
		if (D.flag) Log.i(D.tag(this), "Activity started");
	}
	
	@Override
	protected void onRestoreInstanceState (Bundle savedInstanceState)
	{
		super.onRestoreInstanceState(savedInstanceState);
	}
	
	@Override
	protected void onSaveInstanceState (Bundle outState)
	{
		super.onSaveInstanceState(outState);
	}
}
