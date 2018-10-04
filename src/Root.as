package
{
	import flash.system.Capabilities;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.filesystem.File;
	
	import starling.assets.AssetManager;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.events.Event
		
	import dto.LevelData;
	import dto.ObjectData;
	import dto.ObjectiveData;
	import dto.SpecialData;
	import dto.RewardData;
	
	public class Root extends Sprite
	{
		private static var _assetMgr:AssetManager;
		private static var _instance:Root = null;
		private var mActiveScene:Sprite;
		private var _background:Image;
		private var _levelLoaded:Boolean;
		
		private var _levelXML:XML; 
		private var XML_URL:String; 
		private var myXMLURL:URLRequest; 
		private var myLoader:URLLoader; 
		
		private var level:XML = <Level>		
			<levelName>"Eat to Win"</levelName>
			<levelDescription>"Click treats to eat them as they fall!"</levelDescription>			
			<currentLevel>1</currentLevel>
			<currentLevelRank>0</currentLevelRank>
			<levelMode>day</levelMode>
			<useFte>true</useFte>
			<fteId>1</fteId>
			<levelCompleteObjective>0</levelCompleteObjective>	
			<levelBackgroundSound>"somestring.mp3"</levelBackgroundSound>
			<startingTime>30</startingTime>
			<maxLevelTime>30</maxLevelTime>
			<levelSpeed>1000</levelSpeed>
			<maxLevelSpeed>600</maxLevelSpeed>
			<minLevelSpeed>1600</minLevelSpeed>
			<numberOfObjects>25</numberOfObjects>
			<objectString>0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24</objectString>
			<percentIncreaseTimeBonus>1</percentIncreaseTimeBonus>
			<percentIncreaseTaffy>1</percentIncreaseTaffy>
			<percentIncreaseMysteryCookie>1</percentIncreaseMysteryCookie>
			<percentIncreaseCurrency>0</percentIncreaseCurrency>
			<startingMultiplier>1</startingMultiplier>
			<levelObjectiveID>1</levelObjectiveID>
			<levelRewardID>1</levelRewardID>
		</Level> 
		
		public static function getInstance():Root{
			if(_instance==null){
				_instance=new Root();
			}
			return _instance;
		}
		
		public static function getAssetMgr():AssetManager
		{
			return _assetMgr;
		}
		
		public function Root()
		{
			super();
		}
		
		public function start(background:Texture):void
		{
			_background = new Image(background) ;
			loadResources();
			
			addEventListener(Menu.SELECT_LEVEL,  onSelectLevel);
			addEventListener(Game.GAME_OVER,  onGameOver);
			addEventListener(Score.PLAY_AGAIN,  onPlayAgain);
			addEventListener(Score.MAIN_MENU,  onMainMenu );
		}
		
		public function onSelectLevel(event:starling.events.Event):void
		{
			getLevelData( 1 );
		}
		
		public function onPlayAgain( event:starling.events.Event):void 
		{
			getLevelData( 1 );
		}
		
		public function getLevelData(level:Number):void
		{
			//_levelXML = new XML(level); 
			//XML_URL = "../levels/" + level + ".xml"; 
			//myXMLURL = new URLRequest(XML_URL); 
			//myLoader = new URLLoader(myXMLURL);
			//myLoader.addEventListener(flash.events.Event.COMPLETE, xmlLoaded); 
			xmlLoaded();
		}
		
		private function xmlLoaded(event:flash.events.Event = null):void 
		{ 
			_levelXML = new XML(level); 
			LevelData.getInstance().setLevelDataFromXML(_levelXML);
			if ( _background ) { removeChild(_background) };
			showScene(Game);
		}
		
		private function loadResources():void
		{
			ObjectData.getInstance().LoadObjectData();
			ObjectiveData.getInstance().LoadObjectData();
			SpecialData.getInstance().LoadSpecialObjectData();
			RewardData.getInstance().LoadRewardData();
			
			_assetMgr = GameAssets.getAssetMgr();
			_assetMgr.verbose = true;
			_assetMgr.enqueue(Embeds);
			// Enqueue an asset from disk (AIR only)
			var appDir:File = File.applicationDirectory;
			_assetMgr.loadQueue(function onComplete():void
			{
				addChild(_background);
				showScene(Menu);
			});
		}
		
		private function onMainMenu( event:starling.events.Event):void 
		{
			addChild(_background);
			showScene(Menu);
		}
		
		private function onGameOver(event:starling.events.Event, score:int):void
		{
			showScene(Score);
		}
		
		public function showScene(screen:Class):void
		{
			if (mActiveScene) mActiveScene.removeFromParent(true);
			mActiveScene = new screen();
			addChild(mActiveScene);
			
		}
	}
}