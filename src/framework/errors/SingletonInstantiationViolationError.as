package framework.errors {
	public class SingletonInstantiationViolationError extends Error{
		public function SingletonInstantiationViolationError() {
			super("Can not instantiate singleton class. Use instance property instead.");
		}
	}
}
