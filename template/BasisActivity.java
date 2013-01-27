package ::appPackage::;

import android.os.Bundle;
import android.app.Activity;
import android.content.Context;
import basis.MainActivity;

public class BasisActivity extends MainActivity
{	
	@Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
		::main::.main();
	}
}
