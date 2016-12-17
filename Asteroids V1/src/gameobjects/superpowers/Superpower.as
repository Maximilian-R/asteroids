package gameobjects.superpowers {
	import core.Entity;
	import gameobjects.Ship;
	
	public class Superpower extends Entity {
		protected var _activated:Boolean = false;
		private var _duration:Number = 0;
		
		public function Superpower(framesDuration:Number = 0) {
			super();
			_duration = framesDuration;
			draw();
		}
		
		override public function onCollision(e:Entity):void {
			if (e is Ship) {
				activate(e as Ship);
			}
		}
		
		protected function activate(ship:Ship):void {
			_activated = true;
			visible = false;
			x = 0;
			y = 0;
		}
		
		protected function end():void {
			_isAlive = false;
		}
		
		override public function update():void {
			if (!_activated) {
				return;
			}
			
			if (_duration-- == 0) {
				end();
			}
		}
	}
}