package framework.utils {
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class CoordUtil {

		public static function pointToVector(point:Point):Vector3D {
			return new Vector3D(point.x, 0, point.y);
		}
	}
}
