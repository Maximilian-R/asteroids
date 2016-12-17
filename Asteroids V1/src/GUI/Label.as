package GUI {
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	
	public class Label extends TextField {
		
		public function Label(text:String = null, font:String = null, embeddedFont:Boolean = false, 
		size:Number = 20, color:uint = 0xFFFFFF, centerText:Boolean = true) {
			
			var format:TextFormat = new TextFormat();
			format.font = font;
			format.size = size; 
			format.color = color;
			if (centerText) {
				format.align = TextFormatAlign.CENTER;
			}
			
			defaultTextFormat = format;
			embedFonts = embeddedFont;
			this.text = text;
			selectable = false;
			this.autoSize = TextFieldAutoSize.CENTER;
		}
	}
}