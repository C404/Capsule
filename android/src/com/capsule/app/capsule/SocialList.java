package com.capsule.app.capsule;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.SimpleAdapter;

public class SocialList extends ListView
{
	private ArrayList<Map<String, Object>> socialNetworks = new ArrayList<Map<String, Object>>();
	private final String[] keys = {"name", "ressource"};
	private final int[] targetViews = {R.id.socname, R.id.socimg};
	
	public SocialList(Context context)
	{
		super(context);
	}
	
	public SocialList(Context context, AttributeSet attrs)
	{
		super(context, attrs);
	}
	
	public SocialList(Context context, AttributeSet attrs, int defStyle)
	{
		super(context, attrs, defStyle);
	}

	private class SocialNetwork extends HashMap<String, Object>
	{
		private static final long serialVersionUID = 2791764863728432675L;

		public SocialNetwork(String name, int imageID)
		{
			put(keys[0], name);
			put(keys[1], imageID);
		}
	}
	
	private void populate()
	{
	    socialNetworks.add(new SocialNetwork("Facebook", R.drawable.facebook_logo));
	    socialNetworks.add(new SocialNetwork("Twitter", R.drawable.twitter_logo));
	    socialNetworks.add(new SocialNetwork("Youtube", R.drawable.youtube_logo));
	}
	
	public void init()
	{
		final Context cntx = getContext();
	    final SimpleAdapter adapter = new SimpleAdapter(cntx, socialNetworks, R.layout.socnet, keys, targetViews);
	    LayoutInflater inflater = LayoutInflater.from(cntx);
	    View socheader = inflater.inflate(R.layout.sochead, null);
	    View soctail = inflater.inflate(R.layout.soctail, null);
	    
		populate();
	    addHeaderView(socheader);
	    addFooterView(soctail);
	    setVerticalScrollBarEnabled(false);
	    setAdapter(adapter);
	    
	    setOnItemClickListener(new OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id)
            {
            	final ImageView capsule = (ImageView) view.findViewById(R.id.capsule);
            	final Boolean isVisible = capsule.getVisibility() == View.VISIBLE ? true : false;
            	
            	if (isVisible)
            		capsule.setVisibility(View.INVISIBLE);
            	else
            		capsule.setVisibility(View.VISIBLE);
            }
	    });
	}
}
