package framework.events {
	import flash.events.Event;

	public class DataEvent extends Event{
		private var _data:*;

		public function DataEvent(type:String, data:* = null) {
			super(type);
			_data = data;
		}

		public function get data():* {
			return _data;
		}
	}
}
