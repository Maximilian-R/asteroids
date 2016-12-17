package core {
	import flash.display.Sprite;
	import states.World;
	
	public class Entity extends Sprite {
		
		protected var _xVelocity:Number = 0;
		protected var _yVelocity:Number = 0;
		protected var _rVelocity:Number = 0;
		protected var _thrust:Number = 0;
		protected var _isAlive:Boolean = true;
		
		public function Entity(x:Number = 0, y:Number = 0) {
			super();
			this.x = x;
			this.y = y;
		}
		
		public function onCollision(e:Entity):void {
			_isAlive = false;
			//drawCollisionHull();
		}
		
		public function isColliding(that:Entity):Boolean {
			var dx:Number = this.x - that.x;
			var dy:Number = this.y - that.y;
			var distance:Number = Math.sqrt(dx * dx + dy * dy);
			return (distance < this.radius + that.radius);
		}
		
		public function update():void {
			this.x += _xVelocity;
			this.y += _yVelocity;
			this.rotation += _rVelocity;
			worldWrap();
		}
		
		/* Assumes entity registration point is in center */
		protected function worldWrap():void {
			if (x - (width * 0.5) > stage.stageWidth) {
				x = 0 - (width * 0.5);
			} else if (x + (width * 0.5) < 0) {
				x = stage.stageWidth + (width * 0.5);
			} 
			
			if (y - (height * 0.5) > stage.stageHeight) {
				y = 0 - (height * 0.5);
			} else if (y + (height * 0.5) < 0) {
				y = stage.stageHeight + (height * 0.5);
			}
		}
		
		/* Only for debugging */ 
		protected function drawCollisionHull():void {
			World(parent)._collision.graphics.lineStyle(1, 0xFFFF00, 0.7);
			World(parent)._collision.graphics.moveTo(this.x, this.y);
			World(parent)._collision.graphics.drawCircle(this.x, this.y, this.radius);
		}
		
		public function destroy():void {}
		protected function checkInput():void {}
		protected function draw():void {}
		
		/* ------------------ GETTERS ----------------------*/ 
		public function get thrust():Number { return _thrust; }
		public function get isAlive():Boolean { return _isAlive; }
		public function get xVelocity():Number { return _xVelocity; }
		public function get yVelocity():Number { return _yVelocity; }
		public function get rVelocity():Number { return _rVelocity; }
		public function get radius():Number {return 0.5 * Math.sqrt(width * width + height * height); }
		
		/* ------------------ SETTERS ----------------------*/
		public function set thrust(value:Number):void { _thrust = value; }
		public function set isAlive(value:Boolean):void { _isAlive = value; }
		public function set xVelocity(value:Number):void { _xVelocity = value; }
		public function set yVelocity(value:Number):void { _yVelocity = value; }
		public function set rVelocity(value:Number):void { _rVelocity = value; }
	}
}