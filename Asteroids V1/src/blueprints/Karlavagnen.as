package blueprints {
	import core.Entity;
	import flash.display.Sprite;
	
	public class Karlavagnen extends Entity {
		
		public function Karlavagnen(x:Number = 0, y:Number = 0) {
			super(x, y);
			draw();
			
			_xVelocity = 0.04;
			_yVelocity = 0.07;
			_rVelocity = -0.02;
		}
		
		override protected function draw():void {
			graphics.lineStyle(1, 0x9EF376, 1);
			
			graphics.moveTo(0, 0);
			graphics.lineTo(100, -60);
			graphics.lineTo(160, -54);
			graphics.lineTo(260, -50);
			graphics.lineTo(420, -100);
			graphics.lineTo(420, -20);
			graphics.lineTo(300, 20);
			graphics.lineTo(260, -50);
			
			graphics.beginFill(0xFFFFFF, 1);

			graphics.drawCircle(0, 0, 6);
			graphics.drawCircle(100, -60, 5);
			graphics.drawCircle(160, -54, 5);
			graphics.drawCircle(260, -50, 4);
			graphics.drawCircle(420, -100, 6);
			graphics.drawCircle(420, -20, 4);
			graphics.drawCircle(300, 20, 3);
			
			width = 210; // 420/2 = 210  
			height = 75 // 150/2 = 75
		}
	}
}