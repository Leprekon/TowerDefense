package framework.events {
	import flash.events.Event;

	public class TimelineEvent extends Event {
		public static const UPDATE:String = "timelineUpdate";

		private var _elapsedTime:int;

		public function TimelineEvent(type:String, elapsedTime:int) {
			super(type);
			_elapsedTime = elapsedTime;
		}

		public function get elapsedTime():int {
			return _elapsedTime;
		}
	}
}
