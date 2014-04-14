package engine.actors {
	import engine.UpdatePool;
	import engine.callbacks.Callback;

	import flash.geom.Vector3D;

	public class Actor {
		protected var _position:Vector3D = new Vector3D();
		protected var _id:int;

		public function Actor(id:int) {
			_id = id;
		}

		public function update(updatePool:UpdatePool):Vector.<Callback> {
			return new Vector.<Callback>();
		}

		public function get id():int {
			return _id;
		}

		public function get position():Vector3D {
			return _position;
		}

		public function set position(position:Vector3D):void {
			_position = position;
		}
	}
}
