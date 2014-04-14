package canvas {
	import flash.display.Sprite;

	public class BaseCanvas extends Sprite{
		private var _width:int = 1280;
		private var _height:int = 720;

		public function BaseCanvas() {
		}

		public function clear():void {

		}

		protected function resize():void {

		}

		public function render():void {

		}

		override public function get width():Number {
			return _width;
		}

		override public function get height():Number {
			return _height;
		}

		override public function set width(value:Number):void {
			_width = value;
			resize();
		}

		override public function set height(value:Number):void {
			_height = value;
			resize();
		}
	}
}
