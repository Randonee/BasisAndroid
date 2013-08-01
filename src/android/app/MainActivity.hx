package android.app;

import android.content.Context;

@:native("basis.MainActivity")
extern class MainActivity extends android.app.Activity
{
	static public function getInstance():MainActivity;
	static public function getContext():Context;
}