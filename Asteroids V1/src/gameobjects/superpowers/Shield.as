package gameobjects.superpowers {
	import core.Entity;
	import core.Config;
	
	public class Shield extends Entity {
		private var _health:Number = 0;
		private var _radius:Number = 0;
		private var _damage_per_hit:Number = 0;
		
		public function Shield(radius:Number, x:Number=0, y:Number=0) {
			super(x, y);
			_health = Config.getNumber("max_shield", "shield");
			_damage_per_hit = Config.getNumber("damage_per_bullet", "shield");
			_radius = radius;
			draw();
		}
		
		override protected function draw():void {
			graphics.clear();
			graphics.lineStyle(4, Config.getColor("color", "shield"), _health);
			graphics.drawCircle(0, 0, _radius + 10);
		}
		
		public function hit():void {
			_health -= _damage_per_hit;
			draw();
			if (_health < 0) {
				_isAlive = false;
			}
		}
	}
}