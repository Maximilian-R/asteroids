package blueprints {
	import flash.display.Sprite;
	
	public interface IRocketDesign {
		function getFlamePosition():Number;
		function draw(ship:Sprite):void;
		function getWidth():Number;
		function getHeight():Number;
	}
}