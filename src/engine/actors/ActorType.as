package engine.actors {
	import framework.enums.BaseEnum;

	public class ActorType extends BaseEnum {
		public static const TOWER:ActorType = new ActorType("tower");
		public static const UNIT:ActorType = new ActorType("unit");
		public static const CONSTRUCTION:ActorType = new ActorType("construction");

		public function ActorType(name:String) {
			super(name);
		}
	}
}
