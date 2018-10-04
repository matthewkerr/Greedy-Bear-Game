package specials
{
	public class Special
	{
		public var name:String;
		public var value:Number;
		public var type:Number;
		
		public function Special(name:String, value:Number, type:Number)
		{
			this.name = name;
			this.value = value;
			this.type = type;
		}
		
		public function toString():String {
			return " " + name + ":" + value + ":" +  type ;
		}
	}
}