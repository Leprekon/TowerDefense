package engine3d.actors.projectiles {
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.entities.ParticleGroup;

	import engine.actors.Actor;
	import engine.actors.moving.projectiles.Projectile;

	import engine3d.actors.Actor3D;

	public class Projectile3D extends Actor3D {
		private var _running:Boolean;

		public function Projectile3D(id:int, asset:ObjectContainer3D) {
			super(id, asset);

			for each(var mesh:Mesh in particle.particleMeshes){
				mesh.castsShadows = false;
			}

			_running = true;
		}

		private function get particle():ParticleGroup {
			return (_asset as ParticleGroup);
		}

		override public function update(actor:Actor):void {
			super.update(actor);
			var projectile:Projectile = Projectile(actor);

			if(!projectile.alive && _running){
				_running = false;
			}
		}
	}
}
