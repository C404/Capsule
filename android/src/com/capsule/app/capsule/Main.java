package com.capsule.app.capsule;

import android.app.Activity;
import android.content.pm.ActivityInfo;
import android.graphics.Color;
import android.graphics.PorterDuff.Mode;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.ViewAnimator;

public class Main extends Activity implements OnClickListener
{
	private VideoRecorder recorder;
	private TappableCameraPreview camview;
	private NavMenu menu;
	
	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		if (D.flag) Log.i(D.tag(this), "Activity created");
		super.onCreate(savedInstanceState);
		
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
		getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
		setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
		setContentView(R.layout.main);
		
		final VideoProgressBar progressBar = (VideoProgressBar) findViewById(R.id.progressbar);
		final ViewAnimator status = (ViewAnimator) findViewById(R.id.status);
		final SocialList soclist = (SocialList) findViewById(R.id.soclist);
		
		camview = (TappableCameraPreview) findViewById(R.id.camview);
		menu = (NavMenu) findViewById(R.id.menu);
		recorder = new VideoRecorder(progressBar, menu, status);
		
		camview.setOnClickListener(this);
		camview.init(recorder);
		menu.init(recorder);
		soclist.init();
	}

	protected void onPostCreate(Bundle savedInstanceState)
	{
		super.onPostCreate(savedInstanceState);
		
		/*
		 * Start animations (tooltip + camera)
		 */
		
		final TextView info = (TextView) findViewById(R.id.info);
		final ImageView camera = (ImageView) findViewById(R.id.camera);
		final Animation animInfo = new AlphaAnimation(1.0f, 0.0f);
		final Animation animCamera = new AlphaAnimation(1.0f, 0.0f);
		final int color = Color.parseColor("#f87a48");
		
		info.setTextColor(color);
		info.getCompoundDrawables()[0].setColorFilter(color, Mode.MULTIPLY);
		animInfo.setDuration(5000);
		animInfo.setFillEnabled(true);
		animInfo.setFillAfter(true);
		info.startAnimation(animInfo);
		
		camera.setColorFilter(Color.RED, Mode.MULTIPLY);
		animCamera.setDuration(400);
		animCamera.setRepeatCount(Animation.INFINITE);
		animCamera.setRepeatMode(Animation.REVERSE);
		camera.startAnimation(animCamera);
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu)
	{
		getMenuInflater().inflate(R.menu.settings, menu);
		return true;
	}

	@Override
	public void onClick(View view) {
		recorder.stopRecord();
	}
	
	@Override
	public void onPause()
	{
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
		recorder.release();
	}
	
	@Override
	public void onStart()
	{
		super.onStart();
		if (D.flag) Log.i(D.tag(this), "Activity started");
	}
}
