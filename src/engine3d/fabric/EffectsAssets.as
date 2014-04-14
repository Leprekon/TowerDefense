package engine3d.fabric {
	import away3d.loaders.misc.AssetLoaderContext;

	public class EffectsAssets {
		[Embed(source="../../../assets/particles/particle_test.awp", mimeType="application/octet-stream")]
		public static var testProjectileClass:Class;

		[Embed(source="../../../assets/particles/particle_texture_1.png")]
		private static var _particleTexture1Class:Class;

		[Embed(source="../../../assets/particles/particle_texture_2.png")]
		private static var _particleTexture2Class:Class;

		[Embed(source="../../../assets/particles/particle_texture_3.png")]
		private static var _particleTexture3Class:Class;

		public static function createLoaderContext():AssetLoaderContext {
			var context:AssetLoaderContext = new AssetLoaderContext();
			context.mapUrlToData("particle_texture_1.png", _particleTexture1Class);
			context.mapUrlToData("particle_texture_2.png", _particleTexture2Class);
			context.mapUrlToData("particle_texture_3.png", _particleTexture3Class);

			return context;
		}
	}
}
