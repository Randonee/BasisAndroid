package basisandroid;

import basis.settings.ISettings;
import basis.settings.Target;
import basis.FileUtil;
import basisandroid.settings.XmlAndroidSettings;
import basisandroid.settings.AndroidTarget;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;
import basis.ProcessUtil;


class AndroidBuildTool extends basis.BuildTool
{
	override private function createSettings(path:String):ISettings
	{
		return new XmlAndroidSettings(path);
	}
	
	override private function getSettings_complete(target:Target):Void
	{
		var libPath:String = FileUtil.getHaxelib("BasisAndroid");
	
		var androidTarget:AndroidTarget = cast(target, AndroidTarget).getAndroidTarget();
		
		var args:Array<String> = androidTarget.getCollection(Target.COMMAND_LINE_ARGUMENTS, true);
		var resourceDirectoies:Array<String> = androidTarget.getCollection(AndroidTarget.RESOURCE_DIRECTORIES, true);
		var sourcePaths:Array<String> = androidTarget.getCollection(Target.SOURCE_PATHS, true);
		var assetPaths:Array<String> = androidTarget.getCollection(Target.ASSET_PATHS, true);
		var haxeLibs:Array<String> = androidTarget.getCollection(Target.HAXE_LIBS, true);
		
		var appPackage:String = androidTarget.getSetting(AndroidTarget.APP_PACKAGE);
		
		var mainClass:String = androidTarget.getSetting(Target.MAIN);
		if(mainClass == "" || mainClass == null)
			throw("No main class found. Add <main classpath=\"com.example.Main\"/> to target");
			
		var targetPath:String = androidTarget.getSetting(Target.BUILD_DIR) + "/android/";
		FileUtil.createDirectory(targetPath);
		
		var assetsPath:String = targetPath + "/assets/";
		FileUtil.createDirectory(assetsPath);
		
		var haxePath:String = targetPath + "/haxe/";
		FileUtil.createDirectory(haxePath);
		
		var haxeSRCPath:String = targetPath + "/haxe/src/";
		FileUtil.createDirectory(haxeSRCPath);
		
		var settingsContenxt:Dynamic = androidTarget.getSettingsContext();
		
		FileUtil.copyInto(libPath + "/template" , targetPath, settingsContenxt);
		var mainPackageDir:String = targetPath + "/src/" + StringTools.replace(appPackage, ".", "/");
		FileUtil.createDirectory(mainPackageDir);
		File.copy(targetPath + "/BasisActivity.java", mainPackageDir + "/BasisActivity.java");
		FileSystem.deleteFile(targetPath + "/BasisActivity.java");
		
		
		var mainFound:Bool = false;
		for(a in 0...sourcePaths.length)
		{
			if(FileSystem.exists(sourcePaths[a] + "/" + StringTools.replace(mainClass, ".", "/") + ".hx") )
				mainFound = true;
		
			if(FileSystem.exists(sourcePaths[a]))
			{
				var contents:Array<String> = FileSystem.readDirectory(sourcePaths[a]);
				for(b in 0...contents.length)
				{
					if(contents[b].charAt(0) != ".")
					{
						if(FileSystem.isDirectory(sourcePaths[a] + "/" + contents[b]))
							FileUtil.copyInto(sourcePaths[a] + "/" + contents[b], haxeSRCPath + contents[b]);
						else
							FileUtil.copyFile(sourcePaths[a] + "/" + contents[b], haxeSRCPath + contents[b]);
					}
				}
			}
			else
			{
				throw("Error: source directory not found: " + sourcePaths[a]);
			}
		}
		
		if(!mainFound)
			throw("Error: main file not found: " + mainClass);
		
		for(a in 0...assetPaths.length)
		{
			if(FileSystem.exists(assetPaths[a]))
			{
				var contents:Array<String> = FileSystem.readDirectory(assetPaths[a]);
				for(b in 0...contents.length)
				{
					if(contents[b].charAt(0) != ".")
					{
						if(FileSystem.isDirectory(assetPaths[a] + "/" + contents[b]))
							FileUtil.copyInto(assetPaths[a] + "/" + contents[b], assetsPath + "/" + contents[b]);
						else
							FileUtil.copyFile(assetPaths[a] + "/" + contents[b], assetsPath + "/" + contents[b]);
					}
				}
			}
			else
			{
				throw("Error: asset directory not found: " + assetPaths[a]);
			}
		}
		
		var fout:FileOutput = File.write(targetPath + "/haxe/package.txt");
		fout.writeString(appPackage);
		
		
		FileUtil.createDirectory(targetPath + "/res/");
		for(dir in resourceDirectoies)
			FileUtil.copyInto(dir, targetPath + "/res/");
		
		ProcessUtil.runCommand(targetPath, "haxe", ["debug.hxml"]);
		FileUtil.copyInto(haxePath + "/java/src/", targetPath + "/src/");
		ProcessUtil.runCommand(targetPath, "ant", ["debug"]);
		
	}
}