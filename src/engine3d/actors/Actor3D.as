package engine3d.actors {
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;

	import engine.actors.Actor;

	public class Actor3D extends ObjectContainer3D{
		protected var _actorId:int;
		protected var _asset:ObjectContainer3D;

		public function Actor3D(id:int, asset:ObjectContainer3D) {
			_actorId = id;
			_asset = asset;
			addChild(_asset);
		}

		public function get actorId():int {
			return _actorId;
		}

		public function update(actor:Actor):void {
			x = actor.position.x;
			y = actor.position.y;
			z = actor.position.z;
		}

		public function updateAnimation(elapsedTime:int):void {

		}
	}
}
