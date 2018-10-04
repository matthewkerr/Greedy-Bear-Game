package dto
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class ObjectiveData
	{
		//set up for singleton class
		private static var _instance:ObjectiveData = null;
		//vars for Loading ConfigData
		private var _objectiveXML:XML; 
		private var XML_URL:String; 
		private var myXMLURL:URLRequest; 
		private var myLoader:URLLoader; 
		
		protected var _LevelObjectives:Array;
		
		private var objectives:XML = <Objective numRows="8">
			<objective id="0" name="basicScore" value="10"  tier1value="10" tier2value="9" tier3value="8" includeTypesString="" />
			<objective id="1" name="basicScore" value="200" tier1value="180" tier2value="150" tier3value="120" includeTypesString="" />
			<objective id="2" name="basicScore" value="500" tier1value="400" tier2value="300" tier3value="250" includeTypesString="" />
			<objective id="3" name="basicScore" value="1000" tier1value="900" tier2value="800" tier3value="700" includeTypesString="" />
			<objective id="4" name="maxMultiplier" value="5" tier1value="10" tier2value="9" tier3value="8" includeTypesString="" />
			<objective id="5" name="maxMultiplier" value="25" tier1value="25" tier2value="20" tier3value="15" includeTypesString="" />
			<objective id="6" name="maxMultiplier" value="50" tier1value="40" tier2value="35" tier3value="30" includeTypesString="" />
			<objective id="7" name="maxMultiplier" value="100" tier1value="90" tier2value="80" tier3value="70" includeTypesString="" />
			<objective id="8" name="timeBonus" value="100" tier1value="90" tier2value="80" tier3value="70" includeTypesString="" />
		</Objective>
		
		public function ObjectiveData(){}

		public function get LevelObjectives():Array
		{
			return _LevelObjectives;
		}

		public function set LevelObjectives(value:Array):void
		{
			_LevelObjectives = value;
		}

		public function get objectiveXML():XML
		{
			return _objectiveXML;
		}

		public function set objectiveXML(value:XML):void
		{
			_objectiveXML = value;
		}
		
		public static function getInstance():ObjectiveData{
			if(_instance==null){
				_instance=new ObjectiveData();
			}
			return _instance;
		}
		
		public function LoadObjectData():void
		{
			//_objectiveXML = new XML(); 
			//XML_URL = "../data/ObjectiveData.xml"; 
			//myXMLURL = new URLRequest(XML_URL); 
			//myLoader = new URLLoader(myXMLURL); 
			//myLoader.addEventListener(Event.COMPLETE, xmlLoaded); 
			xmlLoaded()
		}
		
		private function xmlLoaded(event:Event = null):void 
		{ 
			
			_objectiveXML = XML(objectives); 
			trace("_objectiveXML" , _objectiveXML );
			getObjectiveData();
		}
		
		public function getObjectiveData():void
		{
			//here I will load the objevts into an array of objects
			///////////////////////////////////////
			LevelObjectives = new Array();
			var length:Number = _objectiveXML.@numRows;
			//trace("length" + length );
			
			for ( var i:uint = 0; i < length ; i ++ )
			{
				var levelObjective:Object = new Object();
				levelObjective.id = _objectiveXML.objective[i].@id;
				levelObjective.name = _objectiveXML.objective[i].@name;
				levelObjective.value = _objectiveXML.objective[i].@value;
				levelObjective.tier1value = _objectiveXML.objective[i].@tier1value;
				levelObjective.tier2value = _objectiveXML.objective[i].@tier2value;
				levelObjective.tier3value = _objectiveXML.objective[i].@tier3value;
				levelObjective.includeTypesString = _objectiveXML.objective[i].@includeTypesString;

				LevelObjectives.push(levelObjective);
			}
		}

	}
}