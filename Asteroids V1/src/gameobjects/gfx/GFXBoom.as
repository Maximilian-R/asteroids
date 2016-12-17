package gameobjects.gfx {
	import SFX.SoundManager;
	import core.Entity;
	import core.Config;
	
	public class GFXBoom extends GFX {
		private var _endSize:Number = 0;
		private var _currentSize:Number = 0;
		private var _growingSpeed:Number = 0;
		
		public function GFXBoom(x:Number, y:Number) {
			super(x, y);
			_endSize = Config.getNumber("end_radius", "gfxboom")
			_growingSpeed = Config.getNumber("growing_speed", "gfxboom");
			SFX.SoundManager.sharedInstance()._boom.playSound();
		}
		
		override public function update():void {
			if (_currentSize >= _endSize ) {
				_isAlive = false;
				return;
			}
			_currentSize += _growingSpeed;
			alpha *= 0.8;
			draw();
		}
		
		override protected function draw():void {
			graphics.clear();
			graphics.lineStyle(4, Config.getColor("color", "gfxboom"), 1);
			graphics.drawCircle(0, 0, _currentSize);
		}
	}
}