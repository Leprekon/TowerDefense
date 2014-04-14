package engine.callbacks {
	import engine.GameEngine;
	import engine.actors.Actor;


	public class RemoveActorCallback extends Callback {
		private var _actor:Actor;

		public function RemoveActorCallback(actor:Actor) {
			super();
			_actor = actor;
		}

		override public function implement(gameEngine:GameEngine):void {
			super.implement(gameEngine);
			gameEngine.removeActor(_actor);
		}
	}
}
