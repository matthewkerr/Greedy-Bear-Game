package
{
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import starling.assets.AssetManager;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	[SWF(frameRate="60", backgroundColor="#000000")]
	public class Main extends Sprite
	{
		// Startup image for HD screens
		[Embed(source="../assets/textures/2x/startupHD.png")]
		private static var BackgroundGameHD:Class;
		
		private var _starling:Starling;
		
		public function Main()
		{
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:flash.events.Event):void 
		{
			this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);
			
			Starling.multitouchEnabled = true;  // useful on mobile devices
			
			// create a suitable viewport for the screen size
			// we develop the game in a *fixed* coordinate system of 320x480; the game might 
			// then run on a device with a different resolution; for that case, we zoom the 
			// viewPort to the optimal size for any display and load the optimal textures.
			const stageWidth:int  = Constants.STAGE_WIDTH; // points
			const stageHeight:int = Constants.STAGE_HEIGHT;
			const screenWidth:int  = stage.fullScreenWidth; // pixels
			const screenHeight:int = stage.fullScreenHeight;
			
			var viewPort:Rectangle = RectangleUtil.fit(
			new Rectangle(0, 0, stageWidth, stageHeight),
			new Rectangle(0, 0, screenWidth, screenHeight),
			ScaleMode.SHOW_ALL);
			
			var scaleFactor:int = viewPort.width < 480 ? 1 : 2; // midway between 320 and 640
			var background:Bitmap = new BackgroundGameHD();
			
			background.x = viewPort.x;
			background.y = viewPort.y;
			background.width  = viewPort.width; 
			background.height = viewPort.height;
			background.smoothing = true;
			addChild(background);
			
			_starling = new Starling(Root, stage, viewPort );
			_starling.stage.stageWidth  = 320;
			_starling.stage.stageHeight = 480;
			_starling.simulateMultitouch  = false;
			_starling.enableErrorChecking = Capabilities.isDebugger;
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, 
				function onRootCreated(event:Object, app:Root):void
				{
					_starling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
					removeChild(background);
					
					var bgTexture:Texture = Texture.fromBitmap(background, false, false, scaleFactor);
					
					app.start(bgTexture);
					_starling.start();
				});
			
			// When the game becomes inactive, we pause Starling; otherwise, the enter frame event
			// would report a very long 'passedTime' when the app is reactivated. 
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, function (e:*):void 
				{ 
					_starling.start();
					//SaveManager.getInstance().work();
				});
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, function (e:*):void 
				{ 
					_starling.stop(); 
					//SaveManager.getInstance().stop();
				});
		}
	}
}