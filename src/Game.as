package 
{

    import flash.desktop.NativeApplication;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
    import flash.net.URLRequest;
    import flash.utils.Timer;
    import flash.utils.getTimer;
    
    import dto.LevelData;
    import dto.ObjectData;
    import dto.ObjectiveData;
    import dto.SpecialData;
    
    import events.ObjectiveEvent;
    
    import hud.HUD;
    
    import objects.BGLayer;
    import objects.Ball;
    import specials.Special;
    
    import starling.animation.Transitions;
    import starling.animation.Tween;
    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.deg2rad;
    import utils.SoundManager;

    /** The Game class represents the actual game. In this scaffold, it just displays a 
     *  Starling that moves around fast. When the user touches the Starling, the game ends. */ 
    public class Game extends Sprite
    {
        public static const GAME_OVER:String = "gameOver";
	
		public var mStarling:Starling;
		public var ballItem:Ball;
		public var hudkit:HUD;
		
		//Here is the stuff for the level
		private var _gameState:String;
		private var _level:int;
		private var _levelScore:Number;
		private var _timeLeftOnLevel:Number;
		private var _currentLevel:Number;
		private var _currentLevelRank:Number;
		private var _levelSpeed:int;
		private var _levelName:String;
		private var _maxLevelSpeed:Number;
		private var _startingTimeOnLevel:Number;
		private var _timePrevious:Number;
		private var _timeCurrent:Number;
		private var _elapsed:Number;
		private var _soundManager:SoundManager;
		private var _lastBallX:Number;
		private var _scoreMultiplier:Number;
		private var _ballsOnStage:Array;
		private var _objectTimer:Timer;
		private var _background:BGLayer;
		private var _isLevelRunning:Boolean;
		private var _isBallActive:Boolean;
		private var _objectRotation:Number;
		private var _ballSpeed:Number;
		private var _specialArray:Array;
		private var _numSpecials:Number;
		private var _objectsInLevel:Array;
		private var _objectCount:Number;
		private var _percent:Number;
		private var _difference:Number;
		private var _maxMultiplierReached:Number;
		private var _numLives:int;

        public function Game()
        {
			_init();
        }
		
		public function get gameState():String { return _gameState; }
		
        private function _init():void
        {
			/////////////////////////////////
			//Control what happens when the app goes to sleep and wakes up
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, function (e:*):void 
				{
					if (!utils.SoundManager.muted) utils.SoundManager.gameSnd.play(0 , 10000 );
					resumeObjectTimer();
				});
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, function (e:*):void 
				{ 
					SoundManager.stopAllSounds();
					stopObjectTimer();
				});
			
			_background = new BGLayer(1);
			addChild( _background);
			
			displayHud();
			//_objectsInLevel = new Array();
			
			if (!utils.SoundManager.muted) utils.SoundManager.gameSnd.play(0 , 10000 );	
			
			startLevel(LevelData.getInstance().currentLevel);
        }
		
		protected function startLevel(level:Number ):void
		{
			//Here we set up the level properties
			_maxMultiplierReached = 0;
			_levelName = LevelData.getInstance().levelName;
			_currentLevel =  LevelData.getInstance().currentLevel;
			_currentLevelRank = LevelData.getInstance().currentLevelRank;
			_timeLeftOnLevel = LevelData.getInstance().startingTime;
			_scoreMultiplier = LevelData.getInstance().startingMultiplier;
			_levelSpeed = LevelData.getInstance().levelSpeed;
			_maxLevelSpeed = LevelData.getInstance().maxLevelSpeed;
			_startingTimeOnLevel = LevelData.getInstance().startingTime;
			_levelScore = 0;
			_currentLevel = _currentLevel - 1;
			_numLives = 5;
			_objectCount = 0;
			_level = level;
			_objectsInLevel = getObjectsInLevel();
			_ballsOnStage = new Array();
			
			//set some stuff on the HUD
			hudkit.timeLeft = _timeLeftOnLevel;
			hudkit.scoreVal = _levelScore;
			hudkit.multipVal = _numLives;
			
			_gameState = "play";
			this._isLevelRunning = true;
	
			this.addEventListener(TouchEvent.TOUCH, onTouch );
			this.addEventListener(starling.events.Event.ENTER_FRAME, onGameTick);
			this.addEventListener(starling.events.Event.ENTER_FRAME, checkElapsed);
			
			_objectTimer = new Timer(_levelSpeed);
			_objectTimer.addEventListener(TimerEvent.TIMER, onObjectTimeComplete );
			_objectTimer.start();
		}
		
		protected function createObstacle():void
		{
			if ( _gameState == "stop" ) { return };
			
			//type = type;
			var objectType:int = randomRange(0, _objectsInLevel.length -1 );
			var cupcake:Object = ObjectData.getInstance().GameObjects[objectType];
			var cupcakeSpecial:Object = SpecialData.getInstance().SpecialObjects[cupcake.specialId];
			//here we should bring back to objects properties by the object type
			var randomX:Boolean = cupcake.randomX;
			var startX:Number = cupcake.startX;
			var randomY:Boolean = cupcake.randomY;
			var startY:Number = cupcake.startY;
			var speed:Number = cupcake.speed;
			var randomSpeed:Number = cupcake.randomSpeed;
			var minSpeed:Number = cupcake.minSpeed;
			var maxSpeed:Number = cupcake.maxSpeed;
			var additionalTime:Number = cupcakeSpecial.additionalTime;
			var bonusMultiplier:Number = cupcakeSpecial.bonusMultiplier;
			var objectSlowRate:Number = cupcakeSpecial.objectSlowRate;
			var penaltyValue:Number = cupcakeSpecial.penaltyValue;
			var sprinkles:Number = cupcakeSpecial.sprinkles;
			var increaseLevelSpeed:Number = cupcakeSpecial.increaseLevelSpeed;
			var rotation:Number = cupcake.rotation;
			
			//Create the Object 
			var ball:Ball = new Ball();
			ball.pivotX = 32;
			ball.pivotY = 32 ;
			ball.speed = speed;
			ball.scoreValue = cupcake.score;
			ball.additionalTime = additionalTime;
			ball.ballType = objectType;
			ball.bonusX = bonusMultiplier;
			ball.slowRate = objectSlowRate;
			ball.penaltyValue = penaltyValue;
			ball.sprinkles = sprinkles;
			ball.increseLevelSpeed = cupcakeSpecial.increaseLevelSpeed;
			ball.biteCount = cupcake.biteCount;
			ball.specialId = cupcake.specialId;
			ball.isSpecial = cupcake.isSpecial;
			_isBallActive = true;
			
			var useRandomSpeed:Boolean = ( randomSpeed == 1 ) ;
			_ballSpeed = getObjectSpeed( speed, useRandomSpeed , minSpeed , maxSpeed);
			
			if ( randomX ) { ball.x = randomRange( 32 , 260  ) ; }
			
			if ( ball.x == _lastBallX ) { ball.x = randomRange( 32 , Constants.STAGE_WIDTH - ball.width ) ; }
			
			_lastBallX = ball.x
			_objectRotation = rotation;
			
			this.addChildAt(ball, getChildIndex(hudkit));

			_ballsOnStage.push(ball);
			
			var tween:Tween = new Tween(ball, _ballSpeed , Transitions.LINEAR);
			tween.animate("y", Constants.STAGE_HEIGHT + ball.height );
			tween.animate("rotation", deg2rad(_objectRotation));
			tween.onComplete =  onTweenComplete;
			tween.onCompleteArgs = [tween, null];
			Starling.juggler.add(tween);
		}
		
		///////////////////////////////////////////////////////////
		/////////////////////////////////Timer Stuff
		protected function onObjectTimeComplete(event:TimerEvent ) : void
		{
			if ( _levelSpeed < _maxLevelSpeed ) { _levelSpeed = _maxLevelSpeed; };
			_objectTimer.reset();
			if ( _gameState == "stop" ) {
				_objectTimer = null;
				_objectTimer.removeEventListener(TimerEvent.TIMER, onObjectTimeComplete );
				return;
			};
			_objectTimer.start();
			var numObsticles:int = randomRange( 1, 2 );
			for ( var i:int = 0; i < numObsticles; i ++ ) {
				createObstacle();
			}
		}
		
		protected function stopObjectTimer():void
		{
			_objectTimer.stop();
			_objectTimer.removeEventListener(TimerEvent.TIMER, onObjectTimeComplete );
		}
	
		protected function resumeObjectTimer():void
		{
			_objectTimer.start();
			_objectTimer.addEventListener(TimerEvent.TIMER, onObjectTimeComplete );
		}
		
		private function _removeTimers():void {
			this.removeEventListener(TouchEvent.TOUCH, onTouch );
			this.removeEventListener(starling.events.Event.ENTER_FRAME, onGameTick);
			this.removeEventListener(starling.events.Event.ENTER_FRAME, checkElapsed);
			if ( _objectTimer )
			{
				_objectTimer.removeEventListener(TimerEvent.TIMER, onObjectTimeComplete );
			}
		}
		///////////////////////////////////////////GAME PLAY STUFF/////////////////////////
		///////////////////////////////////////////////////////////////////////////////////
		protected function onGameTick(event:starling.events.Event):void
		{
			switch( _gameState )
			{
				case "play" :
					testBallsOffStage();
					if ( _numLives  <= 0  )
					{
						_objectTimer.stop();
						_gameState = "stop";
						SoundManager.stopAllSounds();
						this.removeEventListener(starling.events.Event.ENTER_FRAME, onGameTick);
						dispatchEventWith(GAME_OVER, true, LevelData.getInstance().currentScore);
					}
					break;
				case "stop" :
					_removeTimers();
					dispatchEventWith(GAME_OVER, true, LevelData.getInstance().currentScore);
					break;
				default :
					break;
			}
		}
		
		protected function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(this, TouchPhase.BEGAN);
			if (touch)
			{
				if ( touch.target.parent is Ball)
				{
					var localPos:Point = touch.getLocation(this);
					var item:Ball = touch.target.parent as Ball;
					GameAssets.getAssetMgr().playSound("click");
					var itemScore:Number = _scoreMultiplier * item.scoreValue;
					_isBallActive = false;
					_levelScore =  _levelScore + itemScore;
					_levelSpeed = _levelSpeed - 200;
					LevelData.getInstance().currentSprinkles =  LevelData.getInstance().currentSprinkles + item.sprinkles;
					LevelData.getInstance().currentScore =  LevelData.getInstance().currentScore + _levelScore;
					LevelData.getInstance().currentScore = _levelScore;
					LevelData.getInstance().levelMaxMultiplier = GetAndSetMaxMultiplier( _scoreMultiplier );

					if ( item.ballType == 17 )// MATT .. WHY DID YOU DO THAT !!!
					{
						_numLives = _numLives + 1;
					}
					hudkit.scoreVal = _levelScore;
					hudkit.timeLeft = _timeLeftOnLevel;
					hudkit.multipVal = _numLives;

					
					var textField:TextField = new TextField(250, 35, "+" + ( item.scoreValue * _scoreMultiplier ) );
					textField.x = (Constants.STAGE_WIDTH - textField.width) / 2;
					textField.y = (Constants.STAGE_HEIGHT - textField.height) / 2;
					textField.touchable = false;
					addChild(textField);
					
					var tween:Tween = new Tween(textField, 1 , Transitions.LINEAR);
					tween.animate("alpha", 0);
					tween.onComplete =  onTweenComplete;
					tween.onCompleteArgs = [tween, textField];
					Starling.juggler.add(tween);
					
					this.removeChild(item);
					_ballsOnStage.splice( _ballsOnStage.indexOf(item ), 1); 
					
				}
			}
		}
		
		protected function checkElapsed(event:starling.events.Event):void
		{
			_timePrevious = _timeCurrent;
			_timeCurrent = getTimer();
			_elapsed = (_timeCurrent - _timePrevious) * 0.001;
		}
		
		///////////////////////////FUNCTIONS AND OTHER METHODS
		protected function dropSpecial( percent:Number ):Boolean
		{
			var roll:Number = Math.floor(Math.random() * ( 100 - 1 ) + 1 );
			if ( roll <= percent ) { return true; } 
			return false;	
		}
		
		protected function getObjectsInLevel():Array
		{
			var objectOrderString:String = LevelData.getInstance().objectString;
			var tempArrayTest:Array = objectOrderString.split(",");
			for each( var value:String in objectOrderString )
			{
				tempArrayTest.push(value);
			}
			return tempArrayTest;
		}
		
		protected function testBallsOffStage():void
		{
			for ( var i:uint = 0 ; i < _ballsOnStage.length ; i ++ )
			{
				if ( _ballsOnStage[i].y > 480  )
				{
					_numLives = _numLives - 1;
					hudkit.multipVal = _numLives;
					_levelSpeed = _levelSpeed - 200;
					this.removeChild( _ballsOnStage[i] );
					_ballsOnStage.splice( i , 1 );
				}
			}
		}
		
		protected function getObjectSpeed( speed:Number, randomSpeed:Boolean , minSpeed:Number , maxSpeed:Number ):Number
		{
			var vel:Number = speed;
			if ( randomSpeed ) 
			{ 
				vel = randomRange( 1.5 , 2.5); 
				return vel;
			}
			return vel;
		}
		
		protected function onTweenComplete(tween:Tween, textField:TextField):void
		{
			Starling.juggler.remove(tween);
			if ( textField != null )
			{
				this.addChild(textField);
			}
		}
		
		protected function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		protected function randomInt(minNum:int, maxNum:int):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}

		protected function GetAndSetMaxMultiplier( mult:Number ):Number
		{
			if ( mult > _maxMultiplierReached ) { _maxMultiplierReached = mult }
			return _maxMultiplierReached;
		}
		
		//HUD STUFF///////////////////////////////////////////////////////////////////
		protected function displayHud():void
		{
			hudkit = new HUD();
			hudkit.x = 0;
			hudkit.y = 0;
			hudkit.touchable = false;
			var highest_depth: int = this.numChildren;
			this.addChildAt(hudkit, highest_depth );
		}
    }
}