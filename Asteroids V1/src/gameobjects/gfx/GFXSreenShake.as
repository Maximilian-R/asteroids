package gameobjects.gfx {
	import core.Entity;
	import core.Config;
	
	public class GFXSreenShake extends GFX {
		private var _shakeSize:Number = 0;
		
		public function GFXSreenShake() {
			super();
			_shakeSize = Config.getNumber("shake_size", "gfxshake");
		}
		
		override public function update():void {
			if (_shakeSize < 0) {
				_isAlive = false;
				return;
			}
			var odd:int = _shakeSize % 2;
			var moveTo:Number = (odd) ? _shakeSize : -_shakeSize;
			parent.x = moveTo;
			parent.y = moveTo;
			_shakeSize--;
		}
	}
}