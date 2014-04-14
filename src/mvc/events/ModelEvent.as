package mvc.events {
	import flash.events.Event;

	public class ModelEvent extends Event{
		private var _data:*;

		public function ModelEvent(type:String, data:* = null) {
			super(type)
			_data = data;
		}

		public function get data():* {
			return _data;
		}
	}
}
