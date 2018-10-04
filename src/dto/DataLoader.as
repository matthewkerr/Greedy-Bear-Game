package dto
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import events.GameEvent;
	import starling.events.EventDispatcher;

	public class DataLoader extends EventDispatcher
	{	
		//set up for singleton class
		private static var _instance:DataLoader = null;
		
		//vars for Loading ConfigData
		private var _myXML:XML; 
		private var XML_URL:String; 
		private var myXMLURL:URLRequest; 
		private var myLoader:URLLoader; 
		
		public function DataLoader(){}

		public static function getInstance():DataLoader{
			if(_instance==null){
				_instance=new DataLoader();
			}
			return _instance;
		}

		protected function xmlLoaded(event:Event):void 
		{ 
			myXML = XML(myLoader.data); 
		}
		
		public function LoadData( path:String = "" ):void
		{
			myXML = new XML(); 
			XML_URL = path; 
			myXMLURL = new URLRequest(XML_URL); 
			myLoader = new URLLoader(myXMLURL);
			myLoader.addEventListener(Event.COMPLETE, xmlLoaded); 
		}
		
		public function get myXML():XML { return _myXML; }
		public function set myXML(value:XML):void
		{
			_myXML = value;
		}
	}
}