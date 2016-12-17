package gameobjects.superpowers {
	import gameobjects.Bullet;
	import gameobjects.Ship;
	import core.Config;
	
	public class RapidFire extends Superpower {
		private var _ship:Ship = null;
		
		public function RapidFire() {
			super(Config.getNumber("duration", "rapidfire"));
		}
		
		override protected function activate(ship:Ship):void {
			_ship = ship;
			super.activate(_ship);
			_ship.shotCommand.modifiedShotRate = -Config.getNumber("modified_shot_rate", "rapidfire");
		}
		
		override protected function end():void {
			_ship.shotCommand.modifiedShotRate = 0;
			super.end();
		}
		
		override protected function draw():void {
			graphics.clear();
			graphics.lineStyle(2, Config.getColor("color", "rapidfire"));
			graphics.drawCircle(0, 0, Config.getNumber("radius", "superpower"));
			
			var b:Bullet = new Bullet(null, 0, 0, 0);
			addChild(b);
		}
	}
}