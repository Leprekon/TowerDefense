package framework.enums {
	public class BaseEnum {
		private var _name:String;

		public function BaseEnum(name:String) {
			_name = name;
		}

		public function get name():String {
			return _name;
		}
	}
}
