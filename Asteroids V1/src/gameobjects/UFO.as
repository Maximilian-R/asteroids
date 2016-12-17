package gameobjects {
	import commands.ShootCommand;
	import core.Entity;
	import core.Config;
	import flash.geom.Point;
	
	public class UFO extends Entity {
		private var _shoot:ShootCommand = new ShootCommand("ufo");
		private var _target:Entity = null;
		
		public function UFO(x:Number = 0, y:Number = 0, target:Entity = null) {
			super(x, y);
			_target = target;
			draw();
			_xVelocity = Config.getNumber("thrust", "ufo");
		}
		
		override protected function draw():void {
			graphics.clear();
			graphics.lineStyle(2, Config.getColor("colorLine", "ufo"));
			
			var width:Number = Config.getNumber("width", "ufo");
			var height:Number = Config.getNumber("height", "ufo");
			
			graphics.moveTo( -width * 0.5, 0);
			graphics.lineTo( -width * 0.4, height * 0.5);
			graphics.lineTo( width * 0.4, height * 0.5);
			graphics.lineTo( width * 0.5, 0);
			graphics.lineTo( width * 0.3, - height * 0.2);
			graphics.lineTo( -width * 0.3, - height * 0.2);
			graphics.lineTo( -width * 0.5, 0);
			graphics.moveTo( -width * 0.3, - height * 0.2);
			graphics.lineTo( -width * 0.2, - height * 0.5);
			graphics.lineTo( width * 0.2, - height * 0.5);
			graphics.lineTo( width * 0.3, - height * 0.2);
			
			graphics.endFill();
		}
		
		override public function update():void {
			/* Rotate towards target */
			var dx:Number = _target.localToGlobal(new Point(0, 0)).x - this.x;
			var dy:Number = _target.localToGlobal(new Point(0, 0)).y - this.y;
			var radians:Number = Math.atan2(dy, dx);
			this.rotation = (radians * 180 / Math.PI) + 90; //+90 Degrees to aim correct. Ship was drawn vertically.
			
			super.update();
			_shoot.execute(this);
		}
		
		override public function isColliding(that:Entity):Boolean {
			if (that is Bullet) {
				var bullet:Bullet = Bullet(that);
				if (bullet.shooter == this) {
					return false;
				}
			}
			return super.isColliding(that);
		}
		
		override public function onCollision(e:Entity):void {
			super.onCollision(e);
		}
		
		/* ------------------ GETTERS ----------------------*/ 
		public function get shoot():ShootCommand { return _shoot; }
	}
}