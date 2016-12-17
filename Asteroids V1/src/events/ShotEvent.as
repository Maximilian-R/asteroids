package events {
	import core.Entity;
	import gameobjects.Ship;
	import flash.events.Event;
	import core.Config;
	
	public class ShotEvent extends Event {
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _rotation:Number = 0;
		private var _shooter: Entity;
		
		public function ShotEvent(shooter:Entity, x:Number, y:Number, rotation:Number) {
			super(Config.SHOT_EVENT_STRING);
			_x = x;
			_y = y;
			_rotation = rotation;
			_shooter = shooter;
		}
		
		override public function clone():Event {
			return new ShotEvent(_shooter, _x, _y, _rotation);
		}
		
		/* ------------------ GETTERS ----------------------*/ 
		public function get x():Number { return _x; }
		public function get y():Number { return _y; }
		public function get rotation():Number { return _rotation; }
		public function get shooter():Entity { return _shooter; }
	}
}