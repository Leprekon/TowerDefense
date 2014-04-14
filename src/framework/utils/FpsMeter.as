package framework.utils {
	import flash.events.Event;
	import flash.utils.getTimer;

	public class FpsMeter {
		private const INTERVAL_TIME:int = 500;

		private var _fps:int;
		private var _frames:int;
		private var _lastUpdateTime:int;
		private var _timeToNextInterval:int;

		public function FpsMeter() {
		}

		public function start(startValue:int):void {
			_fps = startValue;
			_frames = 0;
			_lastUpdateTime = getTimer();
			_timeToNextInterval = INTERVAL_TIME;
		}

		public function update():void {
			var curTime:int = getTimer();
			var elapsedTime:int = curTime - _lastUpdateTime;
			_lastUpdateTime = curTime;
			_frames++;
			_timeToNextInterval -= elapsedTime;
			if(_timeToNextInterval <= 0){
				_fps = _frames / ((INTERVAL_TIME - _timeToNextInterval) / 1000);
				_frames = 0;
				_timeToNextInterval = INTERVAL_TIME + _timeToNextInterval;
			}
		}

		public function get fps():int {
			return _fps;
		}
	}
}
