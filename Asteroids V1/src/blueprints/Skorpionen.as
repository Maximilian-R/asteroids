package blueprints {
	import core.Entity;
	import flash.display.Sprite;

	public class Skorpionen extends Entity {
		
		public function Skorpionen(x:Number = 0, y:Number = 0) {
			super(x, y);
			draw();
			
			_xVelocity = 0.08;
			_yVelocity = -0.06;
			_rVelocity = -0.01;
		}
		
		override protected function draw():void {
			graphics.lineStyle(1, 0xFE9898, 1);
			
			graphics.moveTo(0, 0);
			graphics.lineTo(-40, 60);
			graphics.lineTo(-60, 100);
			graphics.lineTo(0, 180);
			graphics.lineTo(120, 180);
			graphics.lineTo(180, 160);
			graphics.lineTo(190, 20);
			graphics.lineTo(186, -80);
			graphics.lineTo(260, -280);
			graphics.lineTo(290, -310);
			graphics.lineTo(450, -500);
			
			graphics.moveTo(290, -310);
			graphics.lineTo(470, -400);
			
			graphics.moveTo(290, -310);
			graphics.lineTo(460, -300);
		
			graphics.beginFill(0xFFFFFF, 1);
			
			graphics.drawCircle(0, 0, 6);
			graphics.drawCircle(-40, 60, 4);
			graphics.drawCircle(-60, 100, 5);
			graphics.drawCircle(0, 180, 6);
			graphics.drawCircle(120, 180, 6);
			graphics.drawCircle(180, 160, 8);
			graphics.drawCircle(190, 20, 6);
			graphics.drawCircle(186, -80, 7);
			graphics.drawCircle(260, -280, 4);
			graphics.drawCircle(290, -310, 6);
			graphics.drawCircle(450, -500, 6);
			graphics.drawCircle(470, -400, 7);
			graphics.drawCircle(460, -300, 5);
			
			width = 265; // 530/2 = 265
			height = 340;  // 680/2 = 340  
		}
	}
}