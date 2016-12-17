package blueprints {
	import flash.display.Sprite;
	import core.Config;

	public class RocketFlame extends Sprite {
		
		public var _isAdded:Boolean = false;
		private var _innerColor:uint;
		private var _middleColor:uint;
		private var _outerColor:uint;
		private var _baseLength:Number;
		private var _varyLength:Number;
		private var _width:Number;
		
		
		public function RocketFlame() {
			super();
			_innerColor = Config.getColor("inner_color", "flame");
			_middleColor = Config.getColor("middle_color", "flame");
			_outerColor = Config.getColor("outer_color", "flame");
			_baseLength = Config.getNumber("base_length", "flame");
			_varyLength = Config.getNumber("vary_length", "flame");
			_width = Config.getNumber("width", "flame");
			drawThrust();
		}
		
		public function drawThrust():void {
			graphics.clear();
			this.visible = true;
			
			var lenght:Number = 0;
			var width:Number = 0;
			
			// Outer fire
			lenght = _baseLength + Math.random() * _varyLength;
			width = _width * 0.5;
			graphics.lineStyle(2, _outerColor);
			graphics.moveTo( -width, 0);
			graphics.lineTo( -width * 0.6, lenght - _baseLength * 0.5);
			graphics.lineTo( -width * 0.4, lenght - _baseLength * 0.7);
			graphics.lineTo( 0, lenght);
			graphics.lineTo( width * 0.4, lenght - _baseLength * 0.7);
			graphics.lineTo( width * 0.6, lenght - _baseLength * 0.5);
			graphics.lineTo( width, 0);
			
			// Middle fire
			lenght = (_baseLength * 0.5) + Math.random() * (_varyLength * 0.6);
			width = width * 0.75;
			graphics.lineStyle(2, _middleColor);
			graphics.moveTo( -width, 0);
			graphics.lineTo( -width * 0.8, lenght - _baseLength * 0.25);
			graphics.lineTo( -width * 0.55, lenght - _baseLength * 0.4);
			graphics.lineTo( 0, lenght);
			graphics.lineTo( width * 0.55, lenght - _baseLength * 0.4);
			graphics.lineTo( width * 0.8, lenght - _baseLength * 0.25);
			graphics.lineTo( width, 0);
			
			// Inner fire
			lenght = (_baseLength * 0.2) + Math.random() * (_varyLength * 0.4);
			width = width * 0.7;
			graphics.lineStyle(2, _innerColor);
			graphics.moveTo( -width, 0);
			graphics.lineTo( 0, lenght);
			graphics.lineTo( width, 0); 
		}
	}
}