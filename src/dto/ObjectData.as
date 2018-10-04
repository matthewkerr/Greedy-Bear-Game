package dto
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	//import events.GameEvent;
	
	import starling.events.EventDispatcher;
	
	public class ObjectData extends EventDispatcher
	{
		//set up for singleton class
		private static var _instance:ObjectData = null;
		//vars for Loading ObjectData
		private var _objectXML:XML; 
		private var XML_URL:String; 
		private var myXMLURL:URLRequest; 
		private var myLoader:URLLoader; 
		private var _GameObjects:Array;
		
		private var objects:XML = <Objects numObjects="25">
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="score1" type="0" score="1" sprinkles="0" isSpecial="false" specialId="0" imageId="0" imageName="Object0"  rotation="380"/>
			<object speed="1.3" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="score3" type="1" score="3" sprinkles="0" isSpecial="false" specialId="0" imageId="1" imageName="Object1"  rotation="-360"/>
			<object speed="1.1" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="score5" type="2" score="5" sprinkles="0" isSpecial="false" specialId="0" imageId="2" imageName="Object2"  rotation="180"/>
			<object speed="1.9" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="score7" type="3" score="7" sprinkles="0" isSpecial="false"  specialId="0" imageId="3" imageName="Object3"  rotation="360"/>
			<object speed="1.9" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="score10" type="4" score="10"  sprinkles="0" isSpecial="false" specialId="0" imageId="4" imageName="Object4"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="2" randomX="true" startX="0" startY="-64" name="" type="5" score="1" sprinkles="0" isSpecial="false"  specialId="0"  imageId="5" imageName="Object5"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="2" randomX="true" startX="0" startY="-64" name="" type="6" score="1" sprinkles="0" isSpecial="false" specialId="0"  imageId="6" imageName="Object6"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="2" randomX="true" startX="0" startY="-64" name="" type="7" score="1" sprinkles="0" isSpecial="false"  specialId="0" imageId="7" imageName="Object7"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="2" randomX="true" startX="0" startY="-64" name="" type="8" score="1" sprinkles="0" isSpecial="false" specialId="0" imageId="8" imageName="Object8"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="2" randomX="true" startX="0" startY="-64" name="" type="9" score="1" sprinkles="0" isSpecial="false" specialId="0" imageId="9" imageName="Object9"  rotation="360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="2" randomX="true" startX="0" startY="-64" name="" type="10" score="1" sprinkles="0" isSpecial="false" specialId="0" imageId="10" imageName="Object10"  rotation="360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="3" randomX="true" startX="0" startY="-64" name="" type="11" score="1" sprinkles="0" isSpecial="false" specialId="0" imageId="11" imageName="Object11"  rotation="360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="3" randomX="true" startX="0" startY="-64" name="" type="12" score="1" sprinkles="0" isSpecial="false" specialId="0" imageId="12" imageName="Object12"  rotation="360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="3" randomX="true" startX="0" startY="-64" name="score1" type="13" score="1" sprinkles="0" isSpecial="false" specialId="0" imageId="13" imageName="Object13"  rotation="360"/>
			<object speed="1.3" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="3" randomX="true" startX="0" startY="-64" name="score3" type="14" score="3" sprinkles="0" isSpecial="false" specialId="0" imageId="14" imageName="Object14"  rotation="-360"/>
			<object speed="1.1" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="3" randomX="true" startX="0" startY="-64" name="score5" type="15" score="5" sprinkles="0"  isSpecial="false" specialId="0" imageId="15" imageName="Object15"  rotation="360"/>
			<object speed="1.9" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="3" randomX="true" startX="0" startY="-64" name="score7" type="16" score="7" sprinkles="0"  isSpecial="false" specialId="0" imageId="16" imageName="Object16"  rotation="-360"/>
			<object speed="1.9" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="timeBonus" type="17" score="10" sprinkles="0" isSpecial="true"  specialId="0" imageId="17" imageName="Object17"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="" type="5" score="18" sprinkles="0" isSpecial="false"  specialId="0"  imageId="18" imageName="Object18"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="" type="6" score="19" sprinkles="0" isSpecial="false" specialId="0"  imageId="19" imageName="Object19"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="" type="7" score="20" sprinkles="0" isSpecial="false" specialId="0" imageId="20" imageName="Object20"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="" type="8" score="21" sprinkles="0" isSpecial="false" specialId="0" imageId="21" imageName="Object21"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="" type="9" score="22" sprinkles="0" isSpecial="false" specialId="0" imageId="22" imageName="Object22"  rotation="360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="" type="7" score="23" sprinkles="0" isSpecial="false" specialId="0" imageId="23" imageName="Object23"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="" type="8" score="24" sprinkles="0" isSpecial="false" specialId="0" imageId="24" imageName="Object24"  rotation="-360"/>
			<object speed="1.5" randomSpeed="false" minSpeed="" maxSpeed="" biteCount="1" randomX="true" startX="0" startY="-64" name="" type="9" score="25" sprinkles="0" isSpecial="false" specialId="0" imageId="25" imageName="Object25"  rotation="360"/>
		</Objects>
		
		public function ObjectData(){}

		public function get GameObjects():Array
		{
			return _GameObjects;
		}

		public function set GameObjects(value:Array):void
		{
			_GameObjects = value;
		}

		public function get objectXML():XML
		{
			return _objectXML;
		}

		public function set objectXML(value:XML):void
		{
			_objectXML = value;
		}

		public static function getInstance():ObjectData{
			if(_instance==null){
				_instance=new ObjectData();
			}
			return _instance;
		}
		
		public function LoadObjectData():void
		{
			//objectXML = new XML(); 
			//XML_URL = "../data/ObjectData.xml"; 
			//myXMLURL = new URLRequest(XML_URL); 
			//myLoader = new URLLoader(myXMLURL); 
			//myLoader.addEventListener(Event.COMPLETE, xmlLoaded); 
			xmlLoaded();
		}
		
		private function xmlLoaded(event:Event = null):void 
		{ 
			objectXML = XML(objects); 
			getObjectData();
		}
		
		public function getObjectData():void
		{
			trace("getObjectData");
			//here I will load the objevts into an array of objects
			///////////////////////////////////////
			GameObjects = new Array();
			var length:Number = objectXML.@numObjects;
			for ( var i:uint = 0; i < length ; i ++ )
			{
				//<object speed="2.5" randomSpeed="false" minSpeed="" maxSpeed="" randomX="true" startX="0" startY="-64" name="score1" type="1" score="1" isSpecial="false" 
				//imageId="1" imageName="Object1" additionalTime="0" bonusX="0" slowRate="0" penaltyValue="0" currancy="0" levelSpeed="0" />
				var gameObject:Object = new Object();
				gameObject.speed = objectXML.object[i].@speed;
				gameObject.randomSpeed = objectXML.object[i].@randomSpeed;
				gameObject.minSpeed = objectXML.object[i].@minSpeed;
				gameObject.randomX = objectXML.object[i].@randomX
				gameObject.startX = objectXML.object[i].@startX;
				gameObject.startY = objectXML.object[i].@startY;
				gameObject.name = objectXML.object[i].@name;
				gameObject.score = objectXML.object[i].@score;
				gameObject.specialId = objectXML.object[i].@specialId;
				gameObject.imageName = objectXML.object[i].@imageName;
				gameObject.type = objectXML.object[i].@type;
				gameObject.biteCount = objectXML.object[i].@biteCount;
				gameObject.isSpecial = objectXML.object[i].@isSpecial;
				gameObject.sprinkles = objectXML.object[i].@sprinkles;
				gameObject.rotation = objectXML.object[i].@rotation;
				GameObjects.push(gameObject);
			}
		}
	}
}

 




