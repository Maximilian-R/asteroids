package events {
	import flash.events.Event;
	import core.Config;
	
	public class AsteroidBreakEvent extends Event {
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _type:String = "";
		
		public function AsteroidBreakEvent(x:Number, y:Number, type:String) {
			super(Config.ASTEROID_BREAK, false, false);
			_x = x;
			_y = y;
			_type = type;
		}
		
		override public function clone():Event {
			return new AsteroidBreakEvent(_x, _y, _type);
		}
		
		/* ------------------ GETTERS ----------------------*/ 
		public function get x():Number { return _x; }
		public function get y():Number { return _y; }
		public function get asteroidType():String { return _type; }
	}
}