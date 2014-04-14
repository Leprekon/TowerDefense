package mvc {
	public class BaseView {
		protected var _isShowed:Boolean = false;

		public function BaseView() {

		}

		public function show():void {
			_isShowed = true;
		}

		public function hide():void {
			_isShowed = false;
		}
	}
}
