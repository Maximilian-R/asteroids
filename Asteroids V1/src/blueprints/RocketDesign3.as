package blueprints {
	import blueprints.IRocketDesign;
	import blueprints.RocketDesign1;
	import flash.display.Sprite;
	import core.Config;
	public class RocketDesign3 implements IRocketDesign {
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _flamePosition:Number = 0;
		
		public function RocketDesign3() {
			_width = Config.getNumber("width", "rocketdesign3");
			_height = Config.getNumber("height", "rocketdesign3");
			_flamePosition = Config.getNumber("flame_position", "rocketdesign3");
		}
		
		public function draw(ship:Sprite):void {
			ship.graphics.clear();
			ship.graphics.lineStyle(2, Config.getColor("colorLine", "ship"));
			ship.graphics.beginFill(0x000000, 1);
			
			ship.graphics.moveTo( -10, -40);
			ship.graphics.lineTo( -18, -26);
			ship.graphics.lineTo( -18, 30);
			ship.graphics.lineTo( 18, 30);
			ship.graphics.lineTo( 18, -26);
			ship.graphics.lineTo( 10, -40);
			ship.graphics.lineTo( -10, -40);
			
			//Left Wing;
			ship.graphics.moveTo( -34, -70);
			ship.graphics.lineTo( -34, 70);
			ship.graphics.lineTo( -60, 0);
			ship.graphics.lineTo( -34, -70);
			
			// Right Wing
			ship.graphics.moveTo( 34, -70);
			ship.graphics.lineTo( 34, 70);
			ship.graphics.lineTo( 60, 0);
			ship.graphics.lineTo( 34, -70);
			
			ship.graphics.endFill();
			
			//Wing connectors
			ship.graphics.lineStyle(2, Config.getColor("colorDetail", "ship"));
	
			ship.graphics.moveTo( -18, -4);
			ship.graphics.lineTo( -34, -20);
			
			ship.graphics.moveTo( -18, 4);
			ship.graphics.lineTo( -34, 20);
			
			ship.graphics.moveTo( 18, -4);
			ship.graphics.lineTo( 34, -20);
			
			ship.graphics.moveTo( 18, 4);
			ship.graphics.lineTo( 34, 20);
			
			ship.graphics.endFill();
		}
		
		public function getFlamePosition():Number {
			return _flamePosition;
		}
		
		public function getWidth():Number {
			return _width;
		}
		
		public function getHeight():Number {
			return _height;
		}
	}
}