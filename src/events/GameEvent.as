package events
{
	import starling.events.Event;
	
	public class GameEvent extends Event
	{
		
		public static const BALL_TOUCHED:String = "ballTouched";
		public static const DESTROY_BALL:String = "destroyBall";
		public static const ON_XML_LOADED:String = "onXMLLoaded";
		public static const DATA_LOADED:String = "dataLoaded";
		
		public var params:Object;
		
		public function GameEvent(type:String, _params:Object=null, bubbles:Boolean=false)
		{
			super(type, bubbles);
			this.params = _params;
			trace( this.params );
		}
	}
}