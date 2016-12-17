package gameobjects.superpowers {
	import gameobjects.superpowers.Shield;
	import gameobjects.Ship;
	import core.Config;
	public class ShieldPower extends Superpower {
		
		public function ShieldPower(framesDuration:Number=0) {
			super();
		}
		
		override protected function activate(ship:Ship):void {
			super.activate(ship);
			ship.shield = new Shield(ship.desgin.getHeight() * 0.5, 0, 0);
		}
		
		override protected function end():void {
			super.end();
		}
		
		override protected function draw():void {
			graphics.clear();
			graphics.lineStyle(4, Config.getColor("color", "shield"));
			graphics.drawCircle(0, 0, Config.getNumber("radius", "superpower"));
		}
	}
}