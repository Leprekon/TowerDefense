package mvc.enums {
	import framework.enums.BaseEnum;

	public class ViewType extends BaseEnum{
		public static const GAME:ViewType = new ViewType("game");

		public function ViewType(name:String) {
			super(name);
		}
	}
}
