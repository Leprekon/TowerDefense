package framework.timeline {
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	import framework.events.TimelineEvent;

	public class Timeline extends EventDispatcher{
		private var _timer:Timer;
		private var _interval:int = 1000;
		private var _lastTimer:int;

		public function Timeline() {
			_timer = new Timer(_interval);
			_timer.addEventListener(TimerEvent.TIMER, handleTick);
		}

		private function handleTick(event:TimerEvent):void {
			var curTimer:int = getTimer();
			var elapsedTime:int = curTimer - _lastTimer;
			_lastTimer = curTimer;

			dispatchEvent(new TimelineEvent(TimelineEvent.UPDATE, elapsedTime));
		}

		public function start():void {
			_timer.start();
			_lastTimer = getTimer();
		}

		public function stop():void {
			_timer.stop();
		}

		public function set interval(value:int):void {
			_interval = value;
			_timer.delay = _interval;
		}

		public function get interval():int {
			return _interval;
		}
	}
}
