package engine3d.level {
	import framework.events.DataEvent;

	public class Level3DEvent extends DataEvent {
		public static const CLICK_GROUND:String = "clickGround";
		public static const LEVEL_CREATED:String = "levelCreated";

		public function Level3DEvent(name:String, data:* = null) {
			super(name, data);
		}
	}
}
