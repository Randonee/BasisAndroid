package basis;

import android.os.Bundle;
import android.app.Activity;
import android.content.Context;

public class MainActivity extends Activity
{
	static MainActivity activity;
	static Context context;
	
	public static Context getContext()
	{
		return context;
	}
	
	public static MainActivity getInstance()
	{
		return activity;
	}
	
	@Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
		::main::.main();
	}
}
