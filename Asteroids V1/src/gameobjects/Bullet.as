package gameobjects {
	import core.Entity;
	import flash.events.Event;
	import core.Config;
	
	public class Bullet extends Entity {
		private var _framesAlive:Number = 0;
		private var _shooter:Entity;
		
		public function Bullet(shooter:Entity, x:Number, y:Number, angle:Number) {
			super(x, y); 
			_shooter = shooter;
			rotation = angle;
			draw();
			
			var angle:Number = this.rotation * (Math.PI / 180);
			_xVelocity = Math.sin(angle) * Config.getNumber("impulse", "bullet");
			_yVelocity = -(Math.cos(angle)) * Config.getNumber("impulse", "bullet");
			
			
		}
		
		override protected function draw():void {
			var width:Number = Config.getNumber("width", "bullet");
			var height:Number = Config.getNumber("height", "bullet");
			
			graphics.clear();
			graphics.beginFill(Config.getColor("color", "bullet"), 1);
			graphics.drawRect(-width*0.5, -height*0.5, width, height);
			cacheAsBitmap = true;
		}
		
		override public function update():void {
			/* dont call super.update(), bullets should not world wrap. */ 
			this.x += _xVelocity;
			this.y += _yVelocity;
			this.rotation += _rVelocity;
			
			_framesAlive++;
			if (_framesAlive >= Config.getNumber("time_to_live", "bullet")) {
				_isAlive = false;
			}
		}
		
		override public function onCollision(e:Entity):void {
			if (e == _shooter) {
				return;
			}
			super.onCollision(e);
		}
		
		/* ------------------ GETTERS ----------------------*/ 
		public function get shooter():Entity {return _shooter;}
	}
}