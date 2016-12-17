package events {
	import core.Entity;
	import gameobjects.Ship;
	import flash.events.Event;
	import core.Config;
	
	public class WarpEvent extends Event {
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		public function WarpEvent(x:Number, y:Number) {
			super(Config.WARP_EVENT_STRING);
			_x = x;
			_y = y;
		}
		
		override public function clone():Event {
			return new WarpEvent(_x, _y);
		}
		
		/* ------------------ GETTERS ----------------------*/ 
		public function get x():Number { return _x; }
		public function get y():Number { return _y; }
	}
}