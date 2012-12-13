package com.capsule.app.capsule;

import java.io.IOException;

import android.media.CamcorderProfile;
import android.media.MediaRecorder;
import android.os.AsyncTask;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.animation.TranslateAnimation;
import android.widget.ViewAnimator;

public class VideoRecorder 
{
	private final MediaRecorder media = new MediaRecorder();
	private VideoProgressBar progressBar;
	private NavMenu menu;
	private ViewAnimator status;
	
	private final Integer videoDuration = 10;
	private boolean isRecording = false;
	
	public VideoRecorder(VideoProgressBar pbar, NavMenu m, ViewAnimator st)
	{
		progressBar = pbar;
		menu = m;
		status = st;
		
		final TranslateAnimation outAnim = new TranslateAnimation(0.0f, -800.0f, 0.0f, 0.0f);
		final TranslateAnimation inAnim = new TranslateAnimation(-800.0f, -0.0f, 0.0f, 0.0f);
		inAnim.setDuration(800);
		outAnim.setDuration(800);
		status.setInAnimation(inAnim);
		status.setOutAnimation(outAnim);
		
		media.setOnInfoListener(new MediaRecorder.OnInfoListener() {
			public void onInfo(MediaRecorder mr, int what, int extra)
			{
				if (what == MediaRecorder.MEDIA_RECORDER_INFO_MAX_DURATION_REACHED) {
					if (D.flag) Log.i(D.tag(true), "Record Timeout");
					stopRecord();
				}
			}
		});
	}
	
	public void setPreview(SurfaceHolder holder)
	{
		media.setPreviewDisplay(holder.getSurface());
	}
	
	public void release()
	{
		media.release();
	}
	
	public void reset()
	{
		CamcorderProfile hightQ = CamcorderProfile.get(CamcorderProfile.QUALITY_480P);
		
		media.reset();
		media.setAudioSource(MediaRecorder.AudioSource.MIC);
		media.setVideoSource(MediaRecorder.VideoSource.CAMERA);
		//media.setOutputFormat(MediaRecorder.OutputFormat.DEFAULT);
		//media.setAudioEncoder(MediaRecorder.AudioEncoder.DEFAULT);
		//media.setVideoEncoder(MediaRecorder.VideoEncoder.DEFAULT);

		media.setProfile(hightQ);
		media.setMaxDuration(videoDuration * 1000);
		media.setOutputFile(Global.outputFile);
	}
	
	public void startRecord()
	{
		if (isRecording)
			return;
		if (D.flag) Log.i(D.tag(this), "Start recording ...");
		isRecording = true;
		
		reset();
		try {
			media.prepare();
		}
		catch (IllegalStateException e) {
			if (D.flag) e.printStackTrace();
			throw new RuntimeException();
		}
		catch (IOException e) {
			if (D.flag) e.printStackTrace();
			throw new RuntimeException();
		}
		if (Global.firstStart) // This is the first time the app is run
			Global.firstStart = false;
		else
			menu.hide();
		media.start();
		progressBar.start(videoDuration);
		status.setDisplayedChild(0);
	}
	
	private void stopMedia()
	{
		AsyncTask<Void, Void, Void> task = new AsyncTask<Void, Void, Void>() {
			@Override
			protected void onPreExecute()
			{
			}
			
			@Override
			protected Void doInBackground(Void... params)
			{
				media.stop();
				return null;
			}
			
			@Override
			protected void onPostExecute(Void param)
			{
				status.showNext();
				menu.show();
			}
		};
		task.execute();		
	}
	
	public void stopRecord()
	{
		if (!isRecording)
			return;
		if (D.flag) Log.i(D.tag(this), "Stop recording ...");
		isRecording = false;
		stopMedia();
		progressBar.stop();
		status.showNext();
	}
}
