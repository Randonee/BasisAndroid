package basisandroid;

class Main
{
	static public function main():Void
	{
		try
		{
			new AndroidBuildTool().build();
		}
		catch(error:String)
		{
			neko.Lib.println(error);
		}
	}
}