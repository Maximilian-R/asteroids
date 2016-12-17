package core {
	
	public class Level {
		private var _level:Number;
		private var _asteroids:Number;
		private var _completionScore:Number;
		
		public function Level(level:Number, asteroids:Number, completionScore:Number) {
			_level = level;
			_asteroids = asteroids;
			_completionScore = completionScore;
		}	
		
		/* ------------------ GETTERS ----------------------*/ 
		public function get level():Number { return _level; }
		public function get asteroids():Number { return _asteroids; }
		public function get completionScore():Number { return _completionScore; }
		
		/* ------------------ SETTERS ----------------------*/
		public function set level(value:Number):void { _level = value; }
		public function set asteroids(value:Number):void { _asteroids = value; }
		public function set completionScore(value:Number):void { _completionScore = value; }
	}
}