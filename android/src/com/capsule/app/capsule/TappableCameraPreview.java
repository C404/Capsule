package com.capsule.app.capsule;

import android.content.Context;
import android.util.AttributeSet;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

public class TappableCameraPreview extends SurfaceView implements SurfaceHolder.Callback
{
	private SurfaceHolder holder;
	private VideoRecorder recorder;
	
	public TappableCameraPreview(Context context)
	{
		super(context);
	}
	
	public TappableCameraPreview(Context context, AttributeSet attrs)
	{
		super(context, attrs);
	}
	
	public TappableCameraPreview(Context context, AttributeSet attrs, int defStyle)
	{
		super(context, attrs, defStyle);
	}
	
	public void init(VideoRecorder vrec)
	{
		recorder = vrec;
		holder = getHolder();
	    holder.addCallback(this);
		recorder.setPreview(holder);
		this.setClickable(true);
	}
	
	@Override
	public void surfaceCreated(SurfaceHolder holder)
	{
		if (D.flag) Log.i(D.tag(this), "Surface created");
		if (Global.firstStart)
			recorder.startRecord();
	}
	
	@Override
	public void surfaceChanged(SurfaceHolder holder, int format, int width, int height)
	{
	}

	@Override
	public void surfaceDestroyed(SurfaceHolder holder)
	{
		if (D.flag) Log.i(D.tag(this), "Surface destroyed");
		recorder.stopRecord();
	}
}
