package GUI {
	import core.Config;
	import flash.display.Sprite;

	public class GameInfo extends Sprite {
		
		private var _healthBar:Label = new Label("", "Arial", false, 40);
		private var _currentLevel:Label = new Label("", "Arial", false, 40);
		private var _currentScore:Label = new Label("", "Arial", false, 40);
		private var _marginFromEdges:Number = 20;
		private var _pausedLabel:Label = new Label("Paused", "Arial", false, 100);
		
		public function GameInfo() {
			_pausedLabel.x = Config.WORLD_WIDTH * 0.5 - _pausedLabel.width * 0.5;
			_pausedLabel.y = Config.WORLD_HEIGHT * 0.5 - _pausedLabel.height * 0.5;
			addChild(_healthBar);
			addChild(_currentLevel);
			addChild(_currentScore);
			addChild(_pausedLabel);
		}
		
		public function set currentScore(score:Number):void {
			_currentScore.text = "Score: " + score;
			_currentScore.x = Config.WORLD_WIDTH - _currentScore.width - _marginFromEdges;
			_currentScore.y = _currentScore.height;
		}
		
		public function set healthBarText(health:Number):void {
			_healthBar.text = "Lives: " + health;
			_healthBar.x = _marginFromEdges;
			_healthBar.y = Config.WORLD_HEIGHT - _healthBar.height;
		}
		
		public function set currentLevel(level:Number):void {
			_currentLevel.text = "Level: " + level;
			_currentLevel.x = Config.WORLD_WIDTH - _currentLevel.width - _marginFromEdges;
			_currentLevel.y = Config.WORLD_HEIGHT - _currentLevel.height;
		}
		
		public function set paused(visible:Boolean):void {
			if (visible) {
				_pausedLabel.visible = true;
			} else {
				_pausedLabel.visible = false;
			}
		}
	}
}