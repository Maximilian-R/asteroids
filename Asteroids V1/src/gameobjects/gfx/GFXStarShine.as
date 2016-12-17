package gameobjects.gfx {
	import SFX.SoundManager;
	import core.Entity;
	import core.Config;
	
	public class GFXStarShine extends GFX {
		private var _endSize:Number = 0;
		private var _currentSize:Number = 0;
		private var _growingSpeed:Number = 0;
		
		public function GFXStarShine(x:Number, y:Number) {
			super(x, y);
			_endSize = Config.getNumber("end_lenght", "gfxstarshine")
			_growingSpeed = Config.getNumber("growing_speed", "gfxstarshine");
			//SFX.SoundManager.sharedInstance()._boom.playSound();
		}
		
		override public function update():void {
			if (_currentSize >= _endSize ) {
				_isAlive = false;
				return;
			}
			_currentSize += _growingSpeed;
			draw();
		}
		
		override protected function draw():void {
			graphics.clear();
			graphics.lineStyle(2, Config.getColor("color", "gfxstarshine"), 1);
			
			graphics.moveTo(0, 0);
			graphics.lineTo(_currentSize, 0);
			graphics.moveTo(0, 0);
			graphics.lineTo(-_currentSize, 0);
			graphics.moveTo(0, 0);
			graphics.lineTo(0, _currentSize);
			graphics.moveTo(0, 0);
			graphics.lineTo(0, -_currentSize);
			graphics.moveTo(0, 0);
			graphics.lineTo(_currentSize * 0.5, _currentSize * 0.5);
			graphics.moveTo(0, 0);
			graphics.lineTo(-_currentSize * 0.5, -_currentSize * 0.5);
			graphics.moveTo(0, 0);
			graphics.lineTo(_currentSize * 0.5, -_currentSize * 0.5);
			graphics.moveTo(0, 0);
			graphics.lineTo(-_currentSize * 0.5, _currentSize * 0.5);
		}
	}
}