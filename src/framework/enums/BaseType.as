package framework.enums {
	public class BaseType extends BaseEnum{
		private var _id:int;

		public function BaseType(id:int, name:String) {
			super(name);
			_id = id;
		}

		public function get id():int {
			return _id;
		}
	}
}
