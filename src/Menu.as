package
{
	import flash.geom.Rectangle;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import utils.SoundManager;
	
	public class Menu extends Sprite
	{
		public static const START_GAME:String = "startGame";
		public static const OPEN_STORE:String = "openStore";
		public static const SELECT_LEVEL:String = "selectLevel";
		public static const SELECT_PROFILE:String = "onSelectProfile";
		
		private var _background:Image;
		
		public function Menu()
		{
			init();
		}
		
		private function init():void
		{
			var buttonTexture:Texture = GameAssets.getAssetMgr().getTexture("start_btn_active");
			var button:Button = new Button( buttonTexture, "" );
			button.x = Constants.STAGE_WIDTH * 0.50 - button.width / 2 ;
			button.y = Constants.STAGE_HEIGHT * 0.40;
			button.addEventListener(Event.TRIGGERED, onStartTriggered);
			addChild(button);
			if (!utils.SoundManager.muted) utils.SoundManager.menuSnd.play(0 , 10000 );
		}
		
		private function onStartTriggered():void
		{
			SoundManager.stopAllSounds();
			dispatchEventWith(SELECT_LEVEL, true, "classic");
		}
	}
}