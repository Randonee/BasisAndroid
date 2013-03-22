package basisandroid.settings;

import basis.settings.Target;
import basis.settings.XmlSettings;

import haxe.xml.Fast;

class XmlAndroidSettings extends XmlSettings
{
	override private function createTarget(?parentTarget:Target=null):Target
	{
		return new AndroidTarget(parentTarget);
	}
	
	override private function parseSettings(settingsXML:Fast, currentTarget:Target):Void
	{
		if(settingsXML.hasNode.appBuildNumber)
			parseAppBuildNumber(settingsXML.node.appBuildNumber, currentTarget);
		if(settingsXML.hasNode.appVersion)
			parseAppVersion(settingsXML.node.appVersion, currentTarget);
		if(settingsXML.hasNode.appPackage)
			parseAppPackage(settingsXML.node.appPackage, currentTarget);
		if(settingsXML.hasNode.emulator)
			parseEmulator(settingsXML.node.emulator, currentTarget);
			
		for( dir in settingsXML.nodes.resourceDir )
			parseResourceDirectories(dir, currentTarget);
			
		super.parseSettings(settingsXML, currentTarget);
	}
	
	private function parseAppBuildNumber(xml:Fast, currentTarget:Target):Void
	{
		currentTarget.setSetting(AndroidTarget.APP_BUILD_NUMBER, xml.att.value);
	}
	
	private function parseAppVersion(xml:Fast, currentTarget:Target):Void
	{
		currentTarget.setSetting(AndroidTarget.APP_VERSION, xml.att.value);
	}
	
	private function parseAppPackage(xml:Fast, currentTarget:Target):Void
	{
		currentTarget.setSetting(AndroidTarget.APP_PACKAGE, xml.att.value);
	}
	
	private function parseEmulator(xml:Fast, currentTarget:Target):Void
	{
		currentTarget.setSetting(AndroidTarget.EMULATOR, xml.att.use.toLowerCase());
	}
	
	private function parseResourceDirectories(dir:Fast, currentTarget):Void
	{
		currentTarget.addToCollection(AndroidTarget.RESOURCE_DIRECTORIES, dir.att.path);
	}
	
}