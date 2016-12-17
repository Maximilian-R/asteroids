package gameobjects {
	import core.Entity;
	import core.Utils;
	import events.AsteroidBreakEvent;
	import core.Config;
	
	public class Asteroid extends Entity {
		
		public static const ASTEROID_BREAK:String = "asteroidBreak";
		public static const TYPE_BIG:String = "asteroid_big";
		public static const TYPE_MEDIUM:String = "asteroid_medium";
		public static const TYPE_SMALL:String = "asteroid_small";
		
		private var _type:String = TYPE_BIG;
		
		public function Asteroid(x:Number = 0, y:Number = 0, typeSize:String = TYPE_BIG) {
			super(x, y);
			_type = typeSize;
			
			var startSpeed:Number = Config.getNumber("start_speed", _type);
			_xVelocity = Utils.randomNum( -startSpeed, startSpeed);
			_yVelocity = Utils.randomNum( -startSpeed, startSpeed);
			_rVelocity = 0;
			draw();
		}
		
		override protected function draw():void {
			graphics.clear();
			graphics.beginFill(Config.getColor("colorFill", _type), 0.5);
			graphics.lineStyle(Config.getNumber("lineThickness", _type), Config.getColor("colorLine", _type));
			
			var size:Number = Config.getNumber("radius", _type);
			
			var firstX:Number;
			var firstY:Number;
			var vertexes:Number = 8;
			
			var offsets:Array = new Array();
			for (var j:int = 0; j < vertexes; j++) {
				offsets.push(Utils.randomNum(-10,10));
			}
			
			graphics.moveTo(size + offsets[0], 0);
			for (var i:int = 0; i < vertexes; i++) {
				var angle:Number = (360 / vertexes * i) * (Math.PI / 180);
				var r:Number = size + offsets[i];
				var x:Number = r * Math.cos(angle);
				var y:Number = r * Math.sin(angle);
				graphics.lineTo(x, y);
				
				if (i == 0) {
					firstX = x;
					firstY = y;
				}
			}
			graphics.lineTo(firstX, firstY);
			graphics.endFill();
			
			cacheAsBitmap = true;
		}
		
		override public function onCollision(e:Entity):void {
			super.onCollision(e);
			dispatchEvent(new AsteroidBreakEvent(x, y, _type));
		}
		
		/* ------------------ GETTERS ----------------------*/ 
		override public function get radius():Number {return Config.getNumber("radius", _type); }
	}
}