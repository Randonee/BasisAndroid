package basisandroid.settings;

import basis.settings.Target;

class AndroidTarget extends Target
{
	//Settings
	static inline public var EMULATOR:String = "emulator";
	static inline public var APP_BUILD_NUMBER:String = "appBuildNumber";
	static inline public var APP_VERSION:String = "appVersion";
	static inline public var APP_PACKAGE:String = "appPackage";
	
	//Collections
	static inline public var FRAMEWORKS:String = "frameworks";
	
	public function getAndroidTarget():AndroidTarget
	{
		for(target in subTargets)
			if(target.getSetting(Target.TYPE) == "android")
				return cast(target, AndroidTarget);
		
		return null;
	}
	
	
}