package engine.callbacks {
	import engine.GameEngine;

	public class AddMoneyCallback extends Callback {
		private var _money:int;
		public function AddMoneyCallback(money:int) {
			super();
			_money = money;
		}

		override public function implement(gameEngine:GameEngine):void {
			super.implement(gameEngine);
			gameEngine.money += _money;
		}
	}
}
