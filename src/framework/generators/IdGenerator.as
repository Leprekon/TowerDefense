package framework.generators {
	public class IdGenerator {
		private var _nextId:int = 0;
		public function IdGenerator() {
		}

		public function generate():int {
			return ++_nextId;
		}
	}
}
