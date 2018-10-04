package managers
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.net.SharedObject;
	import flash.utils.Timer;
	import dto.LevelData;
	
	import starling.events.EventDispatcher;
	
	public class SaveManager extends EventDispatcher
	{
		protected var timer:Timer;
		
		//set up for singleton class
		protected static var _instance:SaveManager = null;
		
		private function SaveManager()
		{
			
		}
		
		public static function getInstance():SaveManager{
			if(_instance==null){
				_instance=new SaveManager();
			}
			return _instance;
		}
		
		protected function onExit(event:Event):void {
			save();
		}
		
		protected function save(event:Event = null):void {
			
			var currentScore:Number = LevelData.getInstance().currentScore;
			var currentSprinkles:Number = LevelData.getInstance().currentSprinkles;
			var currentLevel:Number = LevelData.getInstance().currentLevel;
			var currentLevelRank:Number = LevelData.getInstance().currentLevelRank;
			var sharedObj:SharedObject = SharedObject.getLocal("GreedyBear");
			
			sharedObj.data["currentScore"] = currentScore;
			sharedObj.data["currentSprinkles"] = currentSprinkles;
			sharedObj.data["currentLevel"] = currentLevel;
			sharedObj.data["currentLevelRank"] = currentLevelRank;
			sharedObj.flush();
		}
		
		public function work():void
		{
			timer = new Timer(5000, 0);
			NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExit );
			timer.addEventListener(TimerEvent.TIMER, save );
			timer.start();
		}
		
		public function stop():void
		{
			NativeApplication.nativeApplication.removeEventListener(Event.EXITING, onExit);
			timer.stop();
		}
	}
}