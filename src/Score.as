package
{
	//import feathers.control.Button;
	//import feathers.controls.Button;
	//import feathers.themes.MetalWorksMobileTheme;
	
	import dto.LevelData;
	
	import events.ObjectiveEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Align;
	
	import utils.SoundManager;
    
    /** The Menu shows the logo of the game and a start button that will, once triggered, 
     *  start the actual game. In a real game, it will probably contain several buttons and
     *  link to several screens (e.g. a settings screen or the credits). If your menu contains
     *  a lot of logic, you could use the "Feathers" library to make your life easier. */
    public class Score extends Sprite
    {
		public static const PLAY_AGAIN:String = "playAgain";
		public static const MAIN_MENU:String = "mainMenu";
		public static const START_NEXT_LEVEL:String = "startNextLevel";
		
		protected var scoreLabel:TextField;
		protected var scoreValue:TextField;
		protected var maxMultiplierLabel:TextField;
		protected var maxMultiplierValue:TextField;
		protected var maxTreatsConsumedLabel:TextField;
		protected var maxTreatsConsumedValue:TextField;
		protected var totalScoreValue:TextField;
		protected var sprinklesValue:TextField;
		
		protected var _score:Number;
		protected var _maxMultiplier:int;
		protected var _sprinkles:int;
		protected var _completedTier:Number;
		protected var _levelSprinkles:Number;
		
        public function Score()
        {
            init();
        }
        
        protected function init():void
        {
			var backgroundImage:Image = new Image(Root.getAssetMgr().getTexture("endScreen"));
			addChild(backgroundImage);
			
			if (!utils.SoundManager.muted) utils.SoundManager.menuSnd.play(0 , 10000 );
			
			_score = LevelData.getInstance().currentScore;

			scoreValue = new TextField(250, 75, String(_score ));
			scoreValue.format.setTo( "PermanentMarker", 50 , 0xffffff );
			scoreValue.format.horizontalAlign = Align.LEFT;
			scoreValue.x = 15;
			scoreValue.y = 110;
			addChild(scoreValue);
			
			var moreButton:Button = new Button(Root.getAssetMgr().getTexture("AgainButton"));
			moreButton.x = 10;
			moreButton.y = Constants.STAGE_HEIGHT * 0.40;
			moreButton.addEventListener(Event.TRIGGERED, onPlayAgainTriggered);
			addChild(moreButton);
			
			var homeButton:Button = new Button(Root.getAssetMgr().getTexture("HomeButton"));
			homeButton.x = 10;
			homeButton.y = Constants.STAGE_HEIGHT * 0.49;
			homeButton.addEventListener(Event.TRIGGERED, onMainMenuTriggered);
			addChild(homeButton);
        }
	
		protected function onPlayAgainTriggered():void
		{
			SoundManager.stopAllSounds();
			dispatchEventWith(PLAY_AGAIN, true, "classic");
		}
		
		protected function onMainMenuTriggered():void
		{
			SoundManager.stopAllSounds();
			dispatchEventWith(MAIN_MENU, true, "classic");
		}
    }
}