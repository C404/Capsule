package com.capsule.app.capsule;

import android.content.Context;
import android.content.Intent;
import android.util.AttributeSet;
import android.view.View;
import android.view.animation.AlphaAnimation;
import android.widget.ViewSwitcher;

public class NavMenu extends ViewSwitcher
{
	private VideoRecorder recorder;
	
	public NavMenu(Context context)
	{
		super(context);
	}
	
	public NavMenu(Context context, AttributeSet attrs)
	{
		super(context, attrs);
	}
	
	public void init(VideoRecorder rec)
	{
		recorder = rec;
		
		findViewById(R.id.restart).setOnClickListener(
				new View.OnClickListener() {
					public void onClick(View v)
			    	{
			    		handleRestart();
			    	}
			    }
		);
		findViewById(R.id.share).setOnClickListener(
			    new View.OnClickListener() {
			    	public void onClick(View v)
			    	{
			    		handleShare();
			    	}
			    }
		);
		findViewById(R.id.replay).setOnClickListener(
			    new View.OnClickListener() {
			    	public void onClick(View v)
			    	{
			    		handleReplay();
			    	}
			    }
		);
	}
	
	public void show()
	{
		setDisplayedChild(0);
		setVisibility(View.VISIBLE);
	}
	
	public void hide()
	{
		final AlphaAnimation anim = new AlphaAnimation(1.0f, 0.0f);
		anim.setDuration(600);
		startAnimation(anim);
		setVisibility(View.INVISIBLE);
	}
	
	private void handleRestart()
	{
		recorder.startRecord();
	}

	private void handleShare()
	{
		showNext();
	}
	
	private void handleReplay()
	{
		final Context cntx = getContext();
		
		Intent videoPlayer = new Intent(cntx, VideoPlayer.class);
		cntx.startActivity(videoPlayer);
	}
}
