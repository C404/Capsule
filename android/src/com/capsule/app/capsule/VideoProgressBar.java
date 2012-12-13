package com.capsule.app.capsule;

import java.lang.ref.WeakReference;

import android.content.Context;
//import android.os.AsyncTask;
import android.os.Handler;
import android.os.Message;
import android.util.AttributeSet;
import android.widget.ProgressBar;

public class VideoProgressBar extends ProgressBar
{
	private final Integer MSSEC = 1000;
	//private ProgressTask task;
	private Thread task;
	private volatile boolean isRecording;
	
	public VideoProgressBar(Context context)
	{
		super(context);
	}

	public VideoProgressBar(Context context, AttributeSet attrs)
	{
		super(context, attrs);
	}
	
	public VideoProgressBar(Context context, AttributeSet attrs, int defStyle)
	{
		super(context, attrs, defStyle);
	}
	
	private static class GUIHandler extends Handler
	{
		private final WeakReference<VideoProgressBar> reference;
		
		GUIHandler(VideoProgressBar ref)
		{
			reference = new WeakReference<VideoProgressBar>(ref);
		}
		
		@Override
		public void handleMessage(Message msg)
		{
			VideoProgressBar ref = reference.get();
			if (ref != null) {
				ref.setProgress(msg.what);
			}
		}
	}
	
	// Avoid leaking
	private GUIHandler handle = new GUIHandler(this);
	
	private class ProgressTask implements Runnable
	{
		private Integer videoDuration;
		
		ProgressTask(Integer vd)
		{
			videoDuration = vd;
		}
		
		public void run()
		{
			final Integer max = getMax();
			Integer i = 0;
			
			while (isRecording && i <= max) {
				try {
					Message m = new Message();
					m.what = i;
					handle.sendMessage(m);
					Thread.sleep(videoDuration * MSSEC / max);
				}
				catch (InterruptedException e) {
					break;
				}
				++i;
			}
			Message m = new Message();
			m.what = 0;
			handle.sendMessage(m);
		}
	};
	
	/* XXX: The AsyncTask is broken. The timer resolution is simply amazing ... */
	
	/*
	private class ProgressTask extends AsyncTask<Integer, Integer, Void>
	{
		@Override
		protected void onPreExecute()
		{
		}
		
		@Override
		protected Void doInBackground(Integer... duration)
		{
			final Integer max = getMax();
			Integer i = 0;
			
			while (i <= max) {
				try {
					publishProgress(i);
					Thread.sleep(duration[0] * MSSEC / max);
				}
				catch (InterruptedException e) {
					break;
				}
				++i;
			}
			return null;
		}
		
		@Override
		protected void onPostExecute(Void param)
		{
		}
		
		@Override
		protected void onProgressUpdate(Integer... progressStatus)
		{
			setProgress(progressStatus[0]);
		}
		
		@Override
		protected void onCancelled(Void param)
		{
			setProgress(0);
		}
	}
	*/

	public void start(Integer videoDuration)
	{
		/*
		task = new ProgressTask();
		task.execute(videoDuration);
		*/
		isRecording = true;
		task = new Thread(new ProgressTask(videoDuration));
		task.start();
	}
	
	public void stop()
	{
		//task.cancel(true);
		isRecording = false;
		try {
			task.join();
		}
		catch (InterruptedException e) {}
	}
}
