package mvc.enums {
	import framework.enums.BaseEnum;

	public class ModelType extends BaseEnum{
		public static const LEVEL:ModelType = new ModelType("engine.level");

		public function ModelType(name:String) {
			super(name);
		}
	}
}
