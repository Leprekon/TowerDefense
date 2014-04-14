package engine3d.actors.towers {
	import away3d.entities.Mesh;

	import engine.actors.Actor;

	import engine3d.actors.Actor3D;

	public class Tower3D extends Actor3D {
		public function Tower3D(id:int, asset:Mesh) {
			super(id, asset);
		}

		override public function update(actor:Actor):void {
			super.update(actor);
		}
	}
}
