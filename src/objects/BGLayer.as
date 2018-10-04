package objects
{
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class BGLayer extends Sprite
	{
		
		private var image1:Image;
		private var image2:Image;
		private var _layer:int;
		private var _parallax:Number;
		private var background:Image;
		private var _quad:Quad;
		private var _quad2:Quad;
		private var _sun:Image;
		private var _moon:Image;
		
		public function BGLayer(layer:int)
		{
			super();
			this._layer = layer;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function get moon():Image
		{
			return _moon;
		}

		public function set moon(value:Image):void
		{
			_moon = value;
		}

		public function get sun():Image
		{
			return _sun;
		}

		public function set sun(value:Image):void
		{
			_sun = value;
		}

		public function get quad2():Quad
		{
			return _quad2;
		}

		public function set quad2(value:Quad):void
		{
			_quad2 = value;
		}

		public function get quad():Quad
		{
			return _quad;
		}

		public function set quad(value:Quad):void
		{
			_quad = value;
		}

		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage );
			
			if ( _layer == 1)
			{
				var bottomColor:uint = 0xD9F8FF; // blue
				var topColor:uint    = 0x00CCFF; // blue
				var darksbottomColor:uint = 0x2952a3; // blue
				var darktopColor:uint    = 0x29297a; // blue
				
				quad = new Quad(Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT);
				quad.setVertexColor(0, topColor);
				quad.setVertexColor(1, topColor);
				quad.setVertexColor(2, bottomColor);
				quad.setVertexColor(3, bottomColor);
				quad.alpha = 1;
				quad.touchable = false;
				this.addChildAt(quad, 0);
				
				quad2 = new Quad(Constants.STAGE_WIDTH, Constants.STAGE_HEIGHT);
				quad2.setVertexColor(0, darktopColor);
				quad2.setVertexColor(1, darktopColor);
				quad2.setVertexColor(2, darksbottomColor);	
				quad2.setVertexColor(3, darksbottomColor);
				quad2.alpha = .01;
				quad2.touchable = false;
				this.addChildAt(quad2, 1);
				
				background = new Image(GameAssets.getAssetMgr().getTexture("background_hills"));
				background.touchable = false;
				this.addChildAt( background , 2 );
				
				moon = new Image(GameAssets.getAssetMgr().getTexture("moon-large"));
				moon.touchable = false;	
				moon.alpha = 0.0;
				//this.addChildAt( moon , 3 );
				
				sun = new Image(GameAssets.getAssetMgr().getTexture("sun-large"));
				sun.touchable = false;	
				sun.alpha = 1.0;
				//this.addChildAt( sun , 4 );
				
			}
		}
		
		public function set parallax(value:Number):void
		{
			_parallax = value;
		}
		
		public function get parallax():Number
		{
			return _parallax;
		}
	}
}