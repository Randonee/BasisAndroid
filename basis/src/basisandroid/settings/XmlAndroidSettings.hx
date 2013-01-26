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
	
	override private function parseTarget(targetXML:Fast, currentTarget:Target):Void
	{
		if(targetXML.hasNode.appBuildNumber)
			parseAppBuildNumber(targetXML.node.appBuildNumber, currentTarget);
		if(targetXML.hasNode.appVersion)
			parseAppVersion(targetXML.node.appVersion, currentTarget);
		if(targetXML.hasNode.appPackage)
			parseAppPackage(targetXML.node.appPackage, currentTarget);
		if(targetXML.hasNode.emulator)
			parseEmulator(targetXML.node.emulator, currentTarget);
		
		super.parseTarget(targetXML, currentTarget);
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
	
}