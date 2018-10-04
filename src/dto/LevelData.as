package dto
{
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import starling.events.EventDispatcher;
	
	public class LevelData extends EventDispatcher
	{
		public static const LEVEL_LOADED:String = "levelLoaded";
		
		
		
		
		//set up for singleton class
		protected static var _instance:LevelData = null;
		
		protected var _levelXML:XML; 
		protected var XML_URL:String; 
		protected var myXMLURL:URLRequest; 
		protected var myLoader:URLLoader; 
		
		//Level Data vars
		protected var _levelName:String;
		protected var _levelDescription:String;
		protected var _currentLevel:Number;
		protected var _currentLevelRank:Number;
		protected var _tier1Objective:Number;
		protected var _tier2Objective:Number;
		protected var _tier3Objective:Number;
		
		protected var _tier1ObjectiveReward:Number;
		protected var _tier2ObjectiveReward:Number;
		protected var _tier3ObjectiveReward:Number;
		
		protected var _startingTime:Number;
		protected var _startingMultiplier:Number;
		protected var _levelSpeed:Number;
		protected var _maxLevelSpeed:Number;
		protected var _fteId:Number;
		protected var _objectString:String;
		protected var _currentScore:Number = 0;
		protected var _currentSprinkles:Number = 0;
		protected var _numberOfObjects:Number;
		
		protected var _userSelectedLevel:Number;
		protected var _levelRewardID:int;
		protected var _levelMaxMultiplier:Number;
		protected var _levelObjectiveID:Number;

		public function LevelData()
		{
				
		}

		public function get currentSprinkles():Number
		{
			return _currentSprinkles;
		}

		public function set currentSprinkles(value:Number):void
		{
			_currentSprinkles = value;
		}

		public function get levelObjectiveID():Number
		{
			return _levelObjectiveID;
		}

		public function set levelObjectiveID(value:Number):void
		{
			_levelObjectiveID = value;
		}

		public function get levelMaxMultiplier():Number
		{
			return _levelMaxMultiplier;
		}

		public function set levelMaxMultiplier(value:Number):void
		{
			_levelMaxMultiplier = value;
		}

		public function get levelRewardID():int
		{
			return _levelRewardID;
		}

		public function set levelRewardID(value:int):void
		{
			_levelRewardID = value;
		}

		public function get userSelectedLevel():Number
		{
			return _userSelectedLevel;
		}

		public function set userSelectedLevel(value:Number):void
		{
			_userSelectedLevel = value;
		}

		public function get maxLevelSpeed():Number
		{
			return _maxLevelSpeed;
		}

		public function set maxLevelSpeed(value:Number):void
		{
			_maxLevelSpeed = value;
		}

		public function get levelDescription():String
		{
			return _levelDescription;
		}

		public function set levelDescription(value:String):void
		{
			_levelDescription = value;
		}

		public static function getInstance():LevelData{
			if(_instance==null){
				_instance=new LevelData();
			}
			return _instance;
		}

		protected function xmlLoaded(event:Event):void 
		{ 
			//levelXML = XML(level); 
		}
		
		public function setLevelDataFromXML(xml:XML):void
		{
			levelXML = xml;
			levelName = levelXML.levelName
			levelDescription = levelXML.levelDescription;
			currentLevel = levelXML.currentLevel;
			currentLevelRank = levelXML.currentLevelRank;
			tier1Objective = levelXML.tier1Objective;
			tier2Objective = levelXML.tier2Objective;
			tier3Objective = levelXML.tier3Objective;
			tier1ObjectiveReward = levelXML.tier1ObjectiveReward;
			tier2ObjectiveReward = levelXML.tier2ObjectiveReward;
			tier3ObjectiveReward = levelXML.tier3ObjectiveReward;
			startingTime = levelXML.startingTime;
			startingMultiplier = levelXML.startingMultiplier;
			fteId = levelXML.fteId;
			levelSpeed = levelXML.levelSpeed;
			maxLevelSpeed = levelXML.maxLevelSpeed;
			objectString = levelXML.objectString;
			levelRewardID = levelXML.levelRewardID;
			levelObjectiveID = levelXML.levelObjectiveID;
		}
		
		/////////////////////////Getters and Setters//////////////////
		
		public function get tier3ObjectiveReward():Number
		{
			return _tier3ObjectiveReward;
		}
		
		public function set tier3ObjectiveReward(value:Number):void
		{
			_tier3ObjectiveReward = value;
		}
		
		public function get tier2ObjectiveReward():Number
		{
			return _tier2ObjectiveReward;
		}
		
		public function set tier2ObjectiveReward(value:Number):void
		{
			_tier2ObjectiveReward = value;
		}
		
		public function get tier1ObjectiveReward():Number
		{
			return _tier1ObjectiveReward;
		}
		
		public function set tier1ObjectiveReward(value:Number):void
		{
			_tier1ObjectiveReward = value;
		}
		
		public function set objectString(value:String):void
		{
			_objectString = value;
		}
		public function get currentScore():Number
		{
			return _currentScore;
		}
		public function set currentScore(value:Number):void
		{
			_currentScore = value;
		}
		//Current Level
		public function get currentLevel():Number
		{
			return _currentLevel;
		}
		public function set currentLevel(value:Number):void
		{
			_currentLevel = value;
		}
		//he XML
		public function set levelXML(value:XML):void
		{
			_levelXML = value;
		}
		public function get levelXML():XML
		{
			return _levelXML;
		}
		
		public function get fteId():Number
		{
			return _fteId;
		}
		
		public function set fteId(value:Number):void
		{
			_fteId = value;
		}
		
		public function get levelSpeed():Number
		{
			return _levelSpeed;
		}
		
		public function set levelSpeed(value:Number):void
		{
			_levelSpeed = value;
		}
		
		public function get startingMultiplier():Number
		{
			return _startingMultiplier;
		}
		
		public function set startingMultiplier(value:Number):void
		{
			_startingMultiplier = value;
		}
		
		public function get startingTime():Number
		{
			return _startingTime;
		}
		
		public function set startingTime(value:Number):void
		{
			_startingTime = value;
		}
		
		public function get tier3Objective():Number
		{
			return _tier3Objective;
		}
		
		public function set tier3Objective(value:Number):void
		{
			_tier3Objective = value;
		}
		
		public function get tier2Objective():Number
		{
			return _tier2Objective;
		}
		
		public function set tier2Objective(value:Number):void
		{
			_tier2Objective = value;
		}
		
		public function get tier1Objective():Number
		{
			return _tier1Objective;
		}
		
		public function set tier1Objective(value:Number):void
		{
			_tier1Objective = value;
		}
		
		public function get currentLevelRank():Number
		{
			return _currentLevelRank;
		}
		
		public function set currentLevelRank(value:Number):void
		{
			_currentLevelRank = value;
		}
		
		public function get levelName():String
		{
			return _levelName;
		}
		
		public function set levelName(value:String):void
		{
			_levelName = value;
		}
		public function get objectString():String
		{
			return _objectString;
		}
		
		public function set objectArray(value:String):void
		{
			_objectString = value;
		}
	}
}