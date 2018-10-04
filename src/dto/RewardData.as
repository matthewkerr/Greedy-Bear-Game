package dto
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class RewardData
	{
		//set up for singleton class
		private static var _instance:RewardData = null;
		//vars for Loading ConfigData
		private var _rewardXML:XML; 
		private var XML_URL:String; 
		private var myXMLURL:URLRequest; 
		private var myLoader:URLLoader; 
		
		private var rewards:XML = <Reward numRows="6">
			<reward id="0" name="sprinkles" value="5" tier1value="5" tier2value="4" tier3value="3" includeTypesString="" />
			<reward id="1" name="sprinkles" value="7" tier1value="7" tier2value="5" tier3value="4" includeTypesString="" />
			<reward id="2" name="sprinkles" value="8" tier1value="8" tier2value="6" tier3value="5" includeTypesString="" />
			<reward id="3" name="sprinkles" value="10" tier1value="10" tier2value="7" tier3value="6" includeTypesString="" />
			<reward id="4" name="sprinkles" value="50" tier1value="50" tier2value="45" tier3value="40" includeTypesString="" />
			<reward id="5" name="sprinkles" value="100" tier1value="100" tier2value="90" tier3value="80" includeTypesString="" />
		</Reward>
		
		protected var _LevelRewards:Array;
		
		public function RewardData()
		{
		}

		public function get LevelRewards():Array
		{
			return _LevelRewards;
		}

		public function set LevelRewards(value:Array):void
		{
			_LevelRewards = value;
		}

		public function get rewardXML():XML
		{
			return _rewardXML;
		}

		public function set rewardXML(value:XML):void
		{
			_rewardXML = value;
		}
		
		public static function getInstance():RewardData{
			if(_instance==null){
				_instance=new RewardData();
			}
			return _instance;
		}
		
		public function LoadRewardData():void
		{
			//_rewardXML = new XML(); 
			//XML_URL = "../data/RewardData.xml"; 
			//myXMLURL = new URLRequest(XML_URL); 
			//myLoader = new URLLoader(myXMLURL); 
			//myLoader.addEventListener(Event.COMPLETE, xmlLoaded); 
			xmlLoaded()
		}
		
		private function xmlLoaded(event:Event = null):void 
		{ 
			_rewardXML = XML(rewards); 
			getRewardData();
		}
		
		public function getRewardData():void
		{
			//here I will load the objevts into an array of objects
			///////////////////////////////////////
			LevelRewards = new Array();
			var length:Number = _rewardXML.@numRows;
			//trace("length" + length );
			
			for ( var i:uint = 0; i < length ; i ++ )
			{
				var levelReward:Object = new Object();
				levelReward.id = _rewardXML.reward[i].@id;
				levelReward.name = _rewardXML.reward[i].@name;
				levelReward.value = _rewardXML.reward[i].@value;
				levelReward.tier1value = _rewardXML.reward[i].@tier1value;
				levelReward.tier2value = _rewardXML.reward[i].@tier2value;
				levelReward.tier3value = _rewardXML.reward[i].@tier3value;
				levelReward.includeTypesString = _rewardXML.reward[i].@includeTypesString;
				LevelRewards.push(levelReward);
			}
		}

	}
}