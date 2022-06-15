package;

class Helpers
{
	public static function hsv2rgb(hsv:HSV) : RGB
	{
		var d:Float = (hsv.h%360) / 60;
		if (d < 0) d += 6;
		var hf:Int = Math.floor(d);
		var hi:Int = hf % 6;
		var f:Float = d - hf;

		var v:Float = hsv.v;
		var p:Float = hsv.v * (1 - hsv.s);
		var q:Float = hsv.v * (1 - f * hsv.s);
		var t:Float = hsv.v * (1 - (1 - f) * hsv.s);

		return switch(hi)
		{
			case 0: { r:v, g:t, b:p };
			case 1: { r:q, g:v, b:p };
			case 2: { r:p, g:v, b:t };
			case 3: { r:p, g:q, b:v };
			case 4: { r:t, g:p, b:v };
			case 5: { r:v, g:p, b:q };
		}
	}


	public static function toInt(rgb:RGB) : Int
	{
		return (Math.round(rgb.r * 255) << 16) | (Math.round(rgb.g * 255) << 8) | Math.round(rgb.b * 255);
	}


	public static inline function toRGB(int:Int) : RGB
	{
		return {
			r: ((int >> 16) & 255) / 255,
			g: ((int >> 8) & 255) / 255,
			b: (int & 255) / 255,
		}
	}
}