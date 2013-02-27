package example;

import android.app.MainActivity;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Button;
import android.view.View;
import android.view.KeyEvent;
import r.Id;
import r.Layout;

class MainView implements OnKeyListener implements OnClickListener
{
	private var _inputLabel:TextView;
	private var _inputField:EditText;
	private var _outputField:EditText;
	private var _outputLabel:TextView;
	private var _sampleButton:Button;
	
	public function new()
	{
		MainActivity.getInstance().setContentView(Layout.main);
		_inputField = cast(MainActivity.getInstance().findViewById(Id.inputField), EditText);
		_outputField = cast(MainActivity.getInstance().findViewById(Id.outputField), EditText);
		_sampleButton = cast(MainActivity.getInstance().findViewById(Id.sampleButton), Button);
		
		_inputField.setOnKeyListener(this);
		_sampleButton.setOnClickListener(this);
	}
	
	public function onClick(v:View):Void
	{
		_inputField.setText("Button Clicked");
	}
	
	public function onKey(v:View, actionId:Int, event:KeyEvent):Bool
	{
		_outputField.setText("oo");
		return true;
	}
	
}