package gameobjects.gfx {
	import core.Entity;
	
	public class GFX extends Entity {
		public function GFX(x:Number=0, y:Number=0) {
			super(x, y);
		}
		
		override public function isColliding(that:Entity):Boolean {
			return false;
		}
		
		override public function update():void {
			super.update();
		}
	}
}