package engine.callbacks {
	import engine.GameEngine;
	import engine.actors.Actor;

	import flash.geom.Vector3D;

	public class SpawnActorCallback extends Callback {
		private var _actor:Actor;
		private var _position:Vector3D;

		public function SpawnActorCallback(actor:Actor, position:Vector3D) {
			super();
			_actor = actor;
			_position = position;
		}

		override public function implement(gameEngine:GameEngine):void {
			super.implement(gameEngine);

			_actor.position = _position;
			gameEngine.addActor(_actor);
		}
	}
}
