package engine3d.actors.constructions {
	import away3d.entities.Mesh;

	import engine3d.actors.Actor3D;

	public class Construction3D extends Actor3D {
		public function Construction3D(id:int, asset:Mesh) {
			super(id, asset);

			this.mouseEnabled = asset.mouseEnabled = true;
		}
	}
}
