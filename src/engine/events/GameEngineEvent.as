package engine.events {
	import framework.events.DataEvent;

	public class GameEngineEvent extends DataEvent {
		public static const UPDATED:String = "engineUpdated";
		public function GameEngineEvent(type:String, data:* = null) {
			super(type, data);
		}
	}
}
