package gameobjects.superpowers {
	import gameobjects.Ship;
	import core.Config;
	
	public class HealthPack extends Superpower {
		
		public function HealthPack(framesDuration:Number = 0) {
			super();
		}
		
		override protected function activate(ship:Ship):void {
			super.activate(ship);
			ship.health++;
		}
		
		override protected function draw():void {
			graphics.clear();
			graphics.beginFill(Config.getColor("color", "healthpack"), 1.0);
			graphics.drawCircle(0, 0, Config.getNumber("radius", "superpower"));
		}
		
	}

}