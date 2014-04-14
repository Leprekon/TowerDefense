package engine3d.events {
	import framework.events.DataEvent;

	public class Engine3DEvent extends DataEvent {
		public static const CLICK_GROUND:String = "clickGround";
		public static const CLICK_ACTOR:String = "clickActor";

		public function Engine3DEvent(type:String, data:* = null) {
			super(type, data);
		}
	}
}
