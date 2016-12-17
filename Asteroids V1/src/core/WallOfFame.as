package core {
	import flash.net.SharedObject;
	
	public class WallOfFame {
		
		private var _shared:SharedObject = SharedObject.getLocal("highScoreList");
		private var _highScore:Array = new Array();
		
		public function WallOfFame() {
			load();
		}
		
		public function load():void {
			if (_shared.data.scores) {
				_highScore = _shared.data.scores;
			} else {
				trace("No data found in sharedObject");
			}
		}
		
		public function addScore(name:String, score:Number):void {
			var newRow:Array = new Array(name, score);
			
			/* Highscore List shows top 10 records. Insert at correct position. */ 
			if (_highScore.length == 0) {
				_highScore.push(newRow);
			} else {
				var added:Boolean = false;
				for (var i:int = 0; i < _highScore.length && i < 10; i++) {
					var row:Array = _highScore[i];
					if (score > row[1]) {
						_highScore.insertAt(i, newRow);
						if (_highScore.length > 9) {
							_highScore.removeAt(_highScore.length - 1);
						}
						added = true;
						break;
					}
				}
				if (!added && _highScore.length < 10) {
					_highScore.push(newRow);
				}
			}
			
			save();
		}
		
		private function save():void {
			_shared.data.scores = _highScore;
			_shared.flush();
			_shared.close();
		}
		
		public function getHighScoreList():String {
			var string:String = "";
			var position:Number = 1;
			for each (var row:Array in _highScore) {
				string += position + ". " + row[0] + " " + row[1] + "\n";
				position++;
			}
			
			if (string == "") {
				string = "No Highscores Recorded";
			}
			return string;
		}
	}
}