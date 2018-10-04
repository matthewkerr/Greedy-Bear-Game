package dto
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import events.GameEvent;
	
	import starling.events.EventDispatcher;
	
	public class GameData extends EventDispatcher
	{
		//set up for singleton class
		private static var _instance:GameData = null;
		
		private var _configXML:XML; 
		private var _myXML:XML; 
		private var XML_URL:String; 
		private var myXMLURL:URLRequest; 
		private var myLoader:URLLoader; 

		//////Config DATA
		private var _numberOfObjects:Number = 8;
		
		protected var _numLevels:Number = 40;


		public function GameData()
		{
			_init();
		}
		
		public function get numLevels():Number
		{
			return _numLevels;
		}

		public function set numLevels(value:Number):void
		{
			_numLevels = value;
		}

		private function _init():void
		{

		}
		
		public static function getInstance():GameData{
			if(_instance==null){
				_instance=new GameData();
			}
			return _instance;
		}
		
		private function xmlLoaded(event:Event):void 
		{ 
			configXML = XML(myLoader.data); 
			numLevels = configXML.numLevels;
		}
		
		public function getExternalConfigData():void
		{
			//configXML = new XML(); 
			//XML_URL = "C:\Users\Matthew\Adobe Flash Builder 4.7\com.matthew.ballsofglory\data\Config.xml"; 
			//myXMLURL = new URLRequest(XML_URL); 
			//myLoader = new URLLoader(myXMLURL);
			
			//trace("myLoader", myLoader );
			//myLoader.addEventListener(Event.COMPLETE, xmlLoaded); 
		}
		
		/////////////Getter and Setters//This makes our GameData Class work/////////////
		//////////////////////////////////////////////////////////////////////////////
		
		public function get configXML():XML
		{
			return _configXML;
		}
		
		public function set configXML(value:XML):void
		{
			_configXML = value;
		}
		
		public function get numberOfObjects():Number
		{
			return _numberOfObjects;
		}
		
		public function set numberOfObjects(value:Number):void
		{
			_numberOfObjects = value;
		}
	}
}

 




