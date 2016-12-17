package blueprints {
	import core.Entity;
	import flash.display.Sprite;
	
	public class Lejonet extends Entity {
		
		public function Lejonet(x:Number = 0, y:Number = 0) {
			super(x, y);
			draw();
			
			_xVelocity = -0.02;
			_yVelocity = 0.05;
			_rVelocity = 0.02;
		}
		
		override protected function draw():void {
			graphics.lineStyle(1, 0xFFFF82, 1);
			
			graphics.moveTo(0, 0);
			graphics.lineTo(-40, -60);
			graphics.lineTo(-160, 10);
			graphics.lineTo(-170, 100);
			graphics.lineTo(-100, 170);
			graphics.lineTo(-100, 280);
			graphics.lineTo(-400, 220);
			graphics.lineTo(-560, 220);
			graphics.lineTo(-400, 80);
			graphics.lineTo( -400, 220);
			
			graphics.moveTo(-400, 80);
			graphics.lineTo(-170, 100);
			
			graphics.beginFill(0xFBFDCE, 1);
			
			graphics.drawCircle(0, 0, 6);
			graphics.drawCircle(-40, -60, 4);
			graphics.drawCircle(-160, 10, 7);
			graphics.drawCircle(-170, 100, 6);
			graphics.drawCircle(-100, 170, 6);
			graphics.drawCircle(-100, 280, 5);
			graphics.drawCircle(-400, 220, 6);
			graphics.drawCircle(-560, 220, 7);
			graphics.drawCircle( -400, 80, 6);
			
			width = 280; // 560/2 = 280  
			height = 140; // 280/2 = 140
		}
	}
}