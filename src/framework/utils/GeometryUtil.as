package framework.utils {
	import away3d.tools.utils.GeomUtil;

	import flash.geom.Point;

	import flash.geom.Vector3D;

	public class GeometryUtil {
		public static function calcVectorAngle(vector:Vector3D):Number {
			return Math.atan2(vector.x, vector.z);
		}

		public static function degreeToRads(degreeValue:Number):Number {
			return degreeValue * Math.PI / 180;
		}

		public static function radsToDegree(degreeValue:Number):Number {
			return degreeValue * 180 / Math.PI;
		}

		public static function rotatePoint(point:Point, angle:Number):Point {
			var result:Point = new Point();
			result.x = point.x * Math.cos(angle) - point.y * Math.sin(angle);
			result.y = point.x * Math.sin(angle) + point.y * Math.cos(angle);
			return result;
		}

		public static function lineIntersectLine(A:Point,B:Point,E:Point,F:Point):Point {
			var ip:Point;
			var a1:Number;
			var a2:Number;
			var b1:Number;
			var b2:Number;
			var c1:Number;
			var c2:Number;

			a1= B.y-A.y;
			b1= A.x-B.x;
			c1= B.x*A.y - A.x*B.y;
			a2= F.y-E.y;
			b2= E.x-F.x;
			c2= F.x*E.y - E.x*F.y;

			var denom:Number=a1*b2 - a2*b1;
			if (denom == 0) {
				return null;
			}
			ip=new Point();
			ip.x=(b1*c2 - b2*c1)/denom;
			ip.y=(a2*c1 - a1*c2)/denom;
			return ip;
		}

		public static function calcDistance(point1:Vector3D, point2:Vector3D):Number {
			return point1.subtract(point2).length;
		}
	}
}
