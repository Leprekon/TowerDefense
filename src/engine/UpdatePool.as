package engine {
	import engine.actors.Actor;

	import flash.utils.getTimer;

	import framework.generators.IdGenerator;

	public class UpdatePool {
		private var _time:int;
		private var _lastTimer:int;
		private var _elapsedTime:int;
		private var _actors:Vector.<Actor>;
		private var _idGenerator:IdGenerator = new IdGenerator();
		public function UpdatePool() {

		}


		public function get idGenerator():IdGenerator {
			return _idGenerator;
		}

		public function get time():int {
			return _time;
		}

		public function reset():void {
			_time = 0;
			_lastTimer = getTimer();
		}

		public function update(actors:Vector.<Actor>):void {
			updateTime();
			_actors = actors;
		}

		private function updateTime():void {
			var curTimer:int = getTimer();
			_elapsedTime = curTimer - _lastTimer;
			if(_elapsedTime > 200){
				_elapsedTime = 200;
			}
			_lastTimer = curTimer;
		}

		public function get elapsedTime():int {
			return _elapsedTime;
		}

		public function get actors():Vector.<Actor> {
			return _actors;
		}
	}
}
