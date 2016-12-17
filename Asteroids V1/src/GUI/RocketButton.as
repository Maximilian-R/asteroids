package GUI {
	import blueprints.IRocketDesign;
	import flash.display.Sprite;
	
	public class RocketButton extends Sprite {
		public var _bluePrint:IRocketDesign;
		
		public function RocketButton(rocketDesign:IRocketDesign) {
			_bluePrint = rocketDesign;
			_bluePrint.draw(this);
		}
	}
}