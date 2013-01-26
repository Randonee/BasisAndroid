package android.app;

import android.view.View;
import android.view.ViewGroupLayoutParams;
import android.content.ContextThemeWrapper;

@:native("android.app.Activity")
extern class Activity extends ContextThemeWrapper
{
	public function new():Void;
	public function addContentView(view:View, params:ViewGroupLayoutParams):Void;
	public function getCurrentFocus():View;
	public function setContentView(view:Dynamic):Void;
	public function findViewById(id:Int):View;
}