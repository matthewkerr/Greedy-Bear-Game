package
{
	import starling.events.Event;
	
	public class GameEvent extends Event
	{
		//Events
		public static const START_GAME:String = "startGame";
		public static const OPEN_STORE:String = "openStore";
		public static const SELECT_LEVEL:String = "selectLevel";
		public static const SELECT_PROFILE:String = "onSelectProfile";
		public static const ASSETS_LOADED:String = "onAssetsLoaded";
		
		public function GameEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}