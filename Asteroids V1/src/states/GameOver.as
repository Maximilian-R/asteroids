package states {
	import GUI.Label;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;
	import core.Config;
	import core.Key;
	import core.WallOfFame;
	
	public class GameOver extends Sprite implements IState {	
		private var _gameOverLabel:Label = new Label("Game Over", "Arial", false, 120);
		private var _scoreLabel:Label = new Label("Score: ", "Arial", false, 60);
		private var _returnState:IState = null;
		private var _highscoreboard:WallOfFame = new WallOfFame();
		private var _textInput:TextField = new TextField();
		private var _score:Number = 0;
		private var _highScoreList:Label = new Label("Loading...", "Arial", false, 40);
		private var _playAgainLabel:Label = new Label("Press ESC -> Play Again", "Arial", false, 60);
		
		public function GameOver(score:Number, timeBonus:Number) {
			_score = score + timeBonus;
			
			_gameOverLabel.x = Config.WORLD_WIDTH * 0.5 - _gameOverLabel.width * 0.5;
			_gameOverLabel.y = Config.WORLD_HEIGHT * 0.2 - _gameOverLabel.height * 0.5;
			_scoreLabel.x = Config.WORLD_WIDTH * 0.5 - _scoreLabel.width * 0.5;
			_scoreLabel.y = Config.WORLD_HEIGHT * 0.5 - _scoreLabel.height * 0.5;
			
			var format:TextFormat = new TextFormat("Arial", 60, 0xFFFFFF);
			_textInput.defaultTextFormat = format;
			_textInput.width = 500;
			_textInput.type = TextFieldType.INPUT;
			_textInput.border = true;
			_textInput.borderColor = 0xFFFFFF;
			_textInput.text = "Name:";
			_textInput.x = Config.WORLD_WIDTH * 0.5 - _textInput.width * 0.5;
			_textInput.y = _scoreLabel.y - _textInput.height;
			
			_highScoreList.x = Config.WORLD_WIDTH * 0.5 - _highScoreList.width * 0.5;
			_highScoreList.y = _scoreLabel.y + _scoreLabel.height;
			_highScoreList.visible = false;
			
			if (timeBonus != 0) {			
				_scoreLabel.text = "Score: " + score + " + time bonus: " + timeBonus + " = " + (score + timeBonus);
			} else {
				_scoreLabel.text = "Score: " + score;
			}
			
			_playAgainLabel.x = _playAgainLabel.width;
			_playAgainLabel.y = Config.WORLD_HEIGHT - _playAgainLabel.height;
			
			addChild(_gameOverLabel);
			addChild(_scoreLabel);
			addChild(_textInput);
			addChild(_highScoreList);
			addChild(_playAgainLabel);
			
			Key.DISPATCHER.addEventListener(Keyboard.ESCAPE + "", backToShipPicker);
			Key.DISPATCHER.addEventListener(Keyboard.ENTER + "", checkIn);
			
			showHighScoreList();
		}
		
		private function checkIn(e:Event):void {
			Key.DISPATCHER.removeEventListener(Keyboard.ENTER + "", checkIn);
			_textInput.visible = false;
			
			var name:String = _textInput.text;
			_highscoreboard.addScore(name, _score);
			showHighScoreList();
		}
		
		private function showHighScoreList():void {
			_highScoreList.visible = true;
			_highScoreList.text = "Loading...";
			_highScoreList.text = _highscoreboard.getHighScoreList();
		}
		
		public function update():IState {
			return _returnState;
		}
		
		public function destroy():void {
			Key.DISPATCHER.removeEventListener(Keyboard.ESCAPE + "", backToShipPicker);
			
			_gameOverLabel = null;
			_scoreLabel = null;
			_returnState = null;
			_highscoreboard = null;
			_textInput = null;
			_playAgainLabel = null;
			_score = 0;
			_highScoreList = null; 
			
			removeChildren(0, numChildren - 1);
		}
		
		private function backToShipPicker(e:Event):void {
			_returnState = new PickShipState();
		}
	}
}