package blueprints {
	import blueprints.IRocketDesign;
	import flash.display.Sprite;
	import gameobjects.Ship;
	import core.Config;
	
	public class RocketDesign1 implements IRocketDesign {
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _flamePosition:Number = 0;
		
		public function RocketDesign1() {
			_width = Config.getNumber("width", "rocketdesign1");
			_height = Config.getNumber("height", "rocketdesign1");
			_flamePosition = Config.getNumber("flame_position", "rocketdesign1");
		}
		
		public function draw(ship:Sprite):void {
			ship.graphics.clear();
			ship.graphics.lineStyle(2, Config.getColor("colorLine", "ship"));
			ship.graphics.beginFill(0x000000, 1);
			
			// Upper left
			ship.graphics.moveTo( 0, -70);
			ship.graphics.lineTo( -25, -5);
			ship.graphics.lineTo( -10, 25);
			ship.graphics.lineTo( 0, 20);
			
			// Upper right
			ship.graphics.lineTo( 10, 25);
			ship.graphics.lineTo( 25, -5);
			ship.graphics.lineTo( 0, -70);
			
			// Down
			ship.graphics.moveTo( 0, 20);
			ship.graphics.lineTo( -30, 40);
			ship.graphics.lineTo( -30, 70);
			ship.graphics.lineTo( 0, 50);
			
			ship.graphics.moveTo( 0, 20);
			ship.graphics.lineTo( 30, 40);
			ship.graphics.lineTo( 30, 70);
			ship.graphics.lineTo( 0, 50);
			
			ship.graphics.moveTo( 0, 20);
			ship.graphics.lineTo( 0, 70);
			
			ship.graphics.endFill();
			
			//Window
			ship.graphics.lineStyle(2, Config.getColor("colorDetail", "ship"));
			ship.graphics.beginFill(0x000000, 0);
			ship.graphics.drawCircle(0, -10, 10);
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