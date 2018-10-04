package objects
{
	import dto.ObjectData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Ball extends Sprite
	{
		private static var _instance:ObjectData = null;
	
		private var ball:Image;
		private var _active:Boolean = false;
		private var _speed:Number;
		private var _scoreValue:Number;
		private var _isSpecial:Boolean;
		private var _additionalTime:Number;
		private var _ballType:Number;
		private var _bonusX:Number;
		private var _slowRate:Number = 0;
		private var _penaltyValue:Number = 0;
		private var _biteCount:Number;
		private var _specialId:Number;
		private var _sprinkles:Number;
		private var _increseLevelSpeed:Number;
		
		public function Ball()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage );
			trace("Ball");

		}
	
		public function get increseLevelSpeed():Number
		{
			return _increseLevelSpeed;
		}

		public function set increseLevelSpeed(value:Number):void
		{
			_increseLevelSpeed = value;
		}

		public function get sprinkles():Number
		{
			return _sprinkles;
		}

		public function set sprinkles(value:Number):void
		{
			_sprinkles = value;
		}

		public function get specialId():Number
		{
			return _specialId;
		}

		public function set specialId(value:Number):void
		{
			_specialId = value;
		}

		public function get biteCount():Number
		{
			return _biteCount;
		}

		public function set biteCount(value:Number):void
		{
			_biteCount = value;
			checkBiteCount();
		}

		public function get penaltyValue():Number
		{
			return _penaltyValue;
		}

		public function set penaltyValue(value:Number):void
		{
			_penaltyValue = value;
		}

		public function get slowRate():Number
		{
			return _slowRate;
		}

		public function set slowRate(value:Number):void
		{
			_slowRate = value;
		}

		public function get bonusX():Number
		{
			return _bonusX;
		}

		public function set bonusX(value:Number):void
		{
			_bonusX = value;
		}

		public function get ballType():Number
		{
			return _ballType;
		}

		public function set ballType(value:Number):void
		{
			_ballType = value;
		}

		public function get additionalTime():Number
		{
			return _additionalTime;
		}

		public function set additionalTime(value:Number):void
		{
			_additionalTime = value;
		}

		public function get isSpecial():Boolean
		{
			return _isSpecial;
		}

		public function set isSpecial(value:Boolean):void
		{
			_isSpecial = value;
		}

		public function get active():Boolean
		{
			return _active;
		}

		public function set active(value:Boolean):void
		{
			_active = value;
		}

		public function get speed():Number
		{
			return _speed;
		}

		public function set speed(value:Number):void
		{
			_speed = value;
		}

		public function get scoreValue():Number
		{
			return _scoreValue;
		}

		public function set scoreValue(value:Number):void
		{
			_scoreValue = value;
		}

		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createBall();
		}
		
		private function checkBiteCount():void
		{
			if ( biteCount == 0 ) { return; } 
			ball = new Image(GameAssets.getAssetMgr().getTexture("Object" + ballType + "_" + biteCount));	
			trace("ball" , ball );
			this.addChild(ball);
			this.active = true;
		}
		
		private function createBall():void
		{
			checkBiteCount();
		}
	}
}