package dto
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import starling.events.EventDispatcher;
	
	public class SpecialData extends EventDispatcher
	{
		//set up for singleton class
		private static var _instance:SpecialData = null;
		//vars for Loading ConfigData
		private var _specialXML:XML; 
		private var XML_URL:String; 
		private var myXMLURL:URLRequest; 
		private var myLoader:URLLoader; 
		
		private var _SpecialObjects:Array;
		
		private var special:XML = <Special numRows="1">
	<special id="0" name="bonusTime" objectId="17" additionalTime="10" bonusMultiplier="0" objectSlowRate="0" penaltyValue="0" currancy="1" increseLevelSpeed="0"  percentChance="1"/>
</Special>
		
		public function SpecialData()
		{
			_init();
		}

		public function get SpecialObjects():Array
		{
			return _SpecialObjects;
		}

		public function set SpecialObjects(value:Array):void
		{
			_SpecialObjects = value;
		}

		public function get specialXML():XML
		{
			return _specialXML;
		}

		public function set specialXML(value:XML):void
		{
			_specialXML = value;
		}

		private function _init():void
		{
			
		}
		
		public static function getInstance():SpecialData{
			if(_instance==null){
				_instance=new SpecialData();
			}
			return _instance;
		}
		
		public function LoadSpecialObjectData():void
		{
			//specialXML = new XML(); 
			//XML_URL = "../data/SpecialData.xml"; 
			//myXMLURL = new URLRequest(XML_URL); 
			//myLoader = new URLLoader(myXMLURL); 
			//myLoader.addEventListener(Event.COMPLETE, xmlLoaded); 
			xmlLoaded()
		}
		
		private function xmlLoaded(event:Event = null):void 
		{ 
			specialXML = XML(special); 
			getSpecialObjectData();
		}
		
		public function getSpecialObjectData():void
		{
			//here I will load the objevts into an array of objects
			///////////////////////////////////////
			SpecialObjects = new Array();
			var length:Number = specialXML.@numRows;

			for ( var i:uint = 0; i < length ; i ++ )
			{
				//<object speed="2.5" randomSpeed="false" minSpeed="" maxSpeed="" randomX="true" startX="0" startY="-64" name="score1" type="1" score="1" isSpecial="false" 
				//imageId="1" imageName="Object1" additionalTime="0" bonusX="0" slowRate="0" penaltyValue="0" currancy="0" levelSpeed="0" />
				var gameObject:Object = new Object();
				gameObject.name = specialXML.special[i].@name;
				gameObject.additionalTime = specialXML.special[i].@additionalTime;
				gameObject.bonusX = specialXML.special[i].@bonusMultiplier;
				gameObject.objectSlowRate = specialXML.special[i].@objectSlowRate;
				gameObject.penaltyValue = specialXML.special[i].@penaltyValue;
				gameObject.currancy = specialXML.special[i].@currancy;
				gameObject.increaseLevelSpeed = specialXML.special[i].@increaseLevelSpeed;
				gameObject.objectId = specialXML.special[i].@objectId;
				gameObject.percentChance = specialXML.special[i].@percentChance;
				SpecialObjects.push(gameObject);
				//trace("SpecialObjects.length: " + SpecialObjects.length );
			}
		}
	}
}

 




