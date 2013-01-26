package basisandroid;

class Main
{
	static public function main():Void
	{
		new AndroidBuildTool(Sys.args()[0]).build();
	}
}