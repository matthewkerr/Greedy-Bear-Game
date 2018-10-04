package events
{
	
	import dto.GameData;
	import dto.LevelData;
	import dto.ObjectiveData;
	import dto.RewardData;
	
	public class ObjectiveEvent
	{
		private static var _instance:ObjectiveEvent = null;
		
		public static const BASIC_SCORE:String = "basicScore";
		public static const BASIC_MULTIPLE:String = "basicMultiple";

		public function ObjectiveEvent()
		{
		}
		
		public static function getInstance():ObjectiveEvent{
			if(_instance==null){
				_instance=new ObjectiveEvent();
			}
			return _instance;
		}
		
		/////////////////////////////////////////////////////
		///////////THIS IS THE METHOD THAT RULES THEM ALL
		public function IsObjectiveComplete( ):Boolean 
		{
			var retVal:Boolean = false;
			var objectiveId:Number = LevelData.getInstance().levelObjectiveID;
			var objectiveType:String = ObjectiveData.getInstance().LevelObjectives[objectiveId].name;
			var objectiveValue:Number = ObjectiveData.getInstance().LevelObjectives[objectiveId].value;
			var score:Number = LevelData.getInstance().currentScore;
			var levelmaxMultiplier:Number  = LevelData.getInstance().levelMaxMultiplier;
			
			switch( objectiveType)
			{
				case "basicScore" :
				{
					basicScore( score , ObjectiveData.getInstance().LevelObjectives[0].value )
					break;
				}
				case "maxMultiplier" :
				{
					maxMultiplier( levelmaxMultiplier ,  objectiveValue )
					break;
				}
				case "timeBonus" :
				{
					//timeBonus( maxMultiplier ,  ObjectiveData.getInstance().LevelObjectives[0].value )
					break;
				}
			}
			return retVal;
		}

		//these methods Get The  level objective reward and the Tier result
		///////////////////////////////////////////
		public function GetObjectiveReward( tier:Number ):Number 
		{
			
			trace("levelRewardTier : " + tier);
			var levelRewardId:Number = LevelData.getInstance().levelRewardID;
			trace("levelRewardId : " + levelRewardId);
			
			var retVal:Number = 0;
			if ( tier == 1 )
			{
				retVal = RewardData.getInstance().LevelRewards[levelRewardId].tier1value;
				trace("retVal : " + retVal);
			}
			else if ( tier == 2 )
			{
				retVal = RewardData.getInstance().LevelRewards[levelRewardId].tier2value;
				trace("retVal : " + retVal);
			}
			else if ( tier == 3 )
			{
				retVal = RewardData.getInstance().LevelRewards[levelRewardId].tier3value;
				trace("retVal : " + retVal);
			}

			return retVal;
		}
		
		public function GetObjectiveTierResult( score:Number ):Number {
			var retVal:Number;
			var tier1:Number = ObjectiveData.getInstance().LevelObjectives[LevelData.getInstance().levelObjectiveID].tier1value;
			var tier2:Number = ObjectiveData.getInstance().LevelObjectives[LevelData.getInstance().levelObjectiveID].tier2value;
			var tier3:Number = ObjectiveData.getInstance().LevelObjectives[LevelData.getInstance().levelObjectiveID].tier3value;
			trace("tier1 : " + tier1);
			trace("tier2 : " + tier2);
			trace("tier3 : " + tier3);
			trace("score : " + score);
			if ( score >= tier1 ) 
			{
				retVal = 1;
				trace("1 : " + 1);
			}
			else if (( score > tier2 ) && ( score < tier1 ))
			{
				retVal = 2;
				trace("2 : " + 2);
			}
			else if ((score > tier3 ) && ( score < tier2))
			{
				retVal = 3;
				trace("3 : " + 3);
			}
			else
			{
				retVal = 0;
			}
			return retVal;
		}
		////////////////////////////////////////
		
		//////////Below are methods to see if an objective has been reached while playng the game.
		
		//this passes in the objective type string for true/flase result
		public function startThisFunction( func:String , value:Number, compare:Number):void
		{
			trace(func);
			this[func](value, compare);
		}
		
		//methods...
		protected function basicScore( value:Number, compare:Number ):Boolean
		{
			var bool:Boolean = false;
			if ( value >= compare ) { bool = true; }
			trace(bool);
			return bool;
		}
		
		protected function maxMultiplier( value:Number, compare:Number ):Boolean
		{
			var bool:Boolean = false;
			if ( value >= compare ) { bool = true; }
			trace(bool);
			return bool;
		}
		
		protected function timeBonus( value:Number, compare:Number ):Boolean
		{
			var bool:Boolean = false;
			if ( value >= compare ) { bool = true; }
			trace(bool);
			return bool;
		}
		
		
	}
}