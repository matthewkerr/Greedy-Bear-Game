package
{
	import starling.assets.AssetManager;

	public class GameAssets 
	{
		private static var _assetMgr:AssetManager;
		private static var _instance:GameAssets = null;
		
		public function GameAssets() { }
		
		public static function getAssetMgr(scale:int = 2):AssetManager
		{
			if(_assetMgr == null){
				_assetMgr = new AssetManager(scale);
			}
			return _assetMgr;
		}
	}
}