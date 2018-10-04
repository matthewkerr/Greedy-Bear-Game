package utils
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	
	public class SoundManager
	{
		[Embed(source="../../assets/audio/gone fishing.mp3")]
		private static const backgroundMusic:Class;
		
		[Embed(source="../../assets/audio/menu screen.mp3")]
		private static const menuMusic:Class;
		
		[Embed(source="../../assets/audio/end music.mp3")]
		private static const endMusic:Class;
		
		//Sound Muting
		public static var muted:Boolean = false;
		
		//Initializing the sounds
		public static var gameSnd:Sound = new backgroundMusic() as Sound;
		public static var menuSnd:Sound = new menuMusic() as Sound;
		public static var endSnd:Sound = new endMusic() as Sound;
	
		public function SoundManager() { }
		
		public static function stopAllSounds():void 
		{
			SoundMixer.stopAll();
		}
	}
}