package hud
{

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.deg2rad;
	import starling.utils.Align;
	import dto.GameData;
	import starling.display.Image;

	
	public class HUD extends Sprite
	{
		private var multiplabel:starling.text.TextField;
		private var score:starling.text.TextField;
		private var timeDisplay:TextField;
		private var _scoreVal:Number;
		private var _multipVal:Number;
		private var _timeLeft:Number;
		private var _timeLeftTween:Tween;
		
		public var lemonaide:Image;
		
		
		public function HUD()
		{
			super();
			createHUD();
		}
		
		public function get timeLeft():Number
		{
			return _timeLeft;
		}

		public function set timeLeft(value:Number):void
		{
			_timeLeft = value;
			setTimeLeft(value);
		}

		public function get multipVal():Number
		{
			return _multipVal;
		}

		public function set multipVal(value:Number):void
		{
			_multipVal = value;
			this.multiplabel.text = String(value);
		}

		public function get scoreVal():Number
		{
			return _scoreVal;
		}

		public function set scoreVal(value:Number):void
		{
			_scoreVal = value;
			this.score.text = String(value);
		}

		private function createHUD():void
		{
			lemonaide = new Image( Root.getAssetMgr().getTexture("Object17_1")); 
			lemonaide.x = 2;
			lemonaide.y = 2;
			lemonaide.width = 35;
			lemonaide.height = 35;
			addChild( lemonaide );
			initTextFields();
		}
		
		private function setTimeLeft(value:Number):void
		{
			if ( value <= 10 )
			{
				_timeLeftTween = new Tween(timeDisplay, .2 , Transitions.LINEAR);
				_timeLeftTween.scaleTo(1.5);
				_timeLeftTween.onComplete =  onLimeLeftTweenComplete;
				_timeLeftTween.onCompleteArgs = [_timeLeftTween];
				Starling.juggler.add(_timeLeftTween);
			}
			else
			{
				_timeLeftTween = new Tween(timeDisplay, .2 , Transitions.LINEAR);
				_timeLeftTween.scaleTo(1);
				_timeLeftTween.onComplete =  onLimeLeftTweenComplete;
				_timeLeftTween.onCompleteArgs = [_timeLeftTween];
				Starling.juggler.add(_timeLeftTween);
			}
			
		}
		
		private function onLimeLeftTweenComplete(tween:Tween):void
		{
			Starling.juggler.add(tween);	
		}
		
		
		private function initTextFields():void
		{
			multiplabel = new TextField(320, 35, "1x");
			multiplabel.format.setTo( "PermanentMarker", 32 , 0xffffff );
			multiplabel.format.horizontalAlign = Align.LEFT;
			multiplabel.x = lemonaide.x + lemonaide.width + 3;
			multiplabel.y = 5;
			addChild(multiplabel);
			
			score = new TextField(320, 35, "1x");
			score.format.setTo("PermanentMarker", 32 , 0xffffff );
			score.format.horizontalAlign = Align.RIGHT;
			score.x = 0;
			score.y = 5;
			addChild(score);
			
			
		}
	}
}