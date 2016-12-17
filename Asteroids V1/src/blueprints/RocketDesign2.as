package blueprints {
	import blueprints.IRocketDesign;
	import blueprints.RocketDesign1;
	import flash.display.Sprite;
	import core.Config;
	
	public class RocketDesign2 implements IRocketDesign {
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _flamePosition:Number = 0;
		
		public function RocketDesign2() {
			_width = Config.getNumber("width", "rocketdesign2");
			_height = Config.getNumber("height", "rocketdesign2");
			_flamePosition = Config.getNumber("flame_position", "rocketdesign2");
		}
	
		public function draw(ship:Sprite):void {
			ship.graphics.clear();
			ship.graphics.lineStyle(2, Config.getColor("colorLine", "ship"));
			ship.graphics.beginFill(0x000000, 1);
			
			ship.graphics.moveTo( 0, -70);
			ship.graphics.lineTo( -50, 10);
			ship.graphics.lineTo( -30, 60);
			ship.graphics.lineTo( -20, 46);
			
			ship.graphics.lineTo( 20, 46);
			ship.graphics.lineTo( 30, 60);
			ship.graphics.lineTo( 50, 10);
			ship.graphics.lineTo( 0, -70);
			
			//Windows
			ship.graphics.lineStyle(2,Config.getColor("colorDetail", "ship"));
			ship.graphics.drawCircle(0, 20, 10);
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