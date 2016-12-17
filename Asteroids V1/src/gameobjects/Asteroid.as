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
			var cornerSize:Number = size * 0.7;
			graphics.moveTo(0, -size);
			graphics.lineTo(-cornerSize, -cornerSize);
			graphics.lineTo(-size, 0);
			graphics.lineTo(-cornerSize, cornerSize);
			graphics.lineTo(0, size);
			graphics.lineTo(cornerSize, cornerSize);
			graphics.lineTo(size, 0);
			graphics.lineTo(cornerSize, -cornerSize);
			graphics.lineTo(0, -size);
			
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