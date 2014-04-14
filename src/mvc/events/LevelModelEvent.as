package mvc.events {
	public class LevelModelEvent extends ModelEvent {
		public static const LEVEL_LOADED:String = "levelLoaded";
		public function LevelModelEvent(type:String, data:* = null) {
			super(type, data);
		}
	}
}
