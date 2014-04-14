package framework.errors {
	public class AssetLoadError extends Error {
		public function AssetLoadError(message:String = "unknown") {
			super("Asset load error: " + message);
		}
	}
}
