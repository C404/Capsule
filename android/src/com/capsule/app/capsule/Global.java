package com.capsule.app.capsule;

import android.os.Environment;

public class Global
{
	public static Boolean firstStart = true;
	public static final String outputPath = Environment.getExternalStorageDirectory().getPath()+'/';
	public static final String outputFile = outputPath+"capsule.mp4";
}
