package objects
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class BackgroundManager extends Sprite
	{
		
		private var bgLayer1:BGLayer;
		private var bgLayer2:BGLayer;
		private var bgLayer3:BGLayer;
		private var bgLayer4:BGLayer;
		
		private var _speed:Number = 0;
		
		public function BackgroundManager()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			bgLayer1 = new BGLayer(1);
			bgLayer1.parallax = 0.02;
			this.addChild(bgLayer1);
			
			bgLayer2 = new BGLayer(2);
			bgLayer2.parallax = 0.2;
			this.addChild(bgLayer2);
			
			//bgLayer3 = new BGLayer(3);
			//bgLayer3.parallax = 0.5;
			//this.addChild(bgLayer3);
			
			//bgLayer4 = new BGLayer(4);
			//bgLayer4.parallax = 1;
			//this.addChild(bgLayer4);
			
			//this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/*we will not be needing the stuff for paralax for this project . 
		//TODO : Add this to a boolean call to activate.
		Create Class and make this reusable.
		private function onEnterFrame(event:Event):void
		{
			bgLayer1.x -= Math.ceil(_speed * bgLayer1.parallax);
			if (bgLayer1.x < -stage.stageWidth) bgLayer1.x = 0;
			
			bgLayer2.x -= Math.ceil(_speed * bgLayer2.parallax);
			if (bgLayer2.x < -stage.stageWidth) bgLayer2.x = 0;
			
			bgLayer3.x -= Math.ceil(_speed * bgLayer3.parallax);
			if (bgLayer3.x < -stage.stageWidth) bgLayer3.x = 0;
			
			bgLayer4.x -= Math.ceil(_speed * bgLayer4.parallax);
			if (bgLayer4.x < -stage.stageWidth) bgLayer4.x = 0;
		}
		
		public function set speed(value:Number):void
		{
			_speed = value;
		}
		
		public function get speed():Number
		{
			return _speed;
		}
		*/
	}
}