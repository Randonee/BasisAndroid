package basis;

import android.os.Bundle;
import android.app.Activity;

public class MainActivity extends Activity
{
	static MainActivity activity;
	
	public static MainActivity getInstance()
	{
		return activity;
	}
	
	@Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        activity = this;
	}
}
