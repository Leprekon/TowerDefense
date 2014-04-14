package engine.actors.moving {
	import engine.actors.Actor;

	import flash.geom.Vector3D;

	public class MovingActor extends Actor {
		protected var _speed:int;

		public function MovingActor(id:int) {
			super(id);
		}

		protected function updateMovement(elapsedTime:int, direction:Vector3D):void {
			direction.normalize();
			direction.scaleBy(_speed * elapsedTime / 1000);
			_position = _position.add(direction);
		}

		public function set speed(speed:int):void {
			_speed = speed;
		}
	}
}
