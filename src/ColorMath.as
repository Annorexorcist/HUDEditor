package
{
	import flash.filters.ColorMatrixFilter;
	import fl.motion.ColorMatrix;
	import fl.motion.AdjustColor;
	/**
	 * ...
	 * @author Bolbman
	 */
	public class ColorMath 
	{
		//Using fl.motion
		public static function getColorChangeFilter(_brightness:Number, _contrast:Number, _saturation:Number, _hue:Number):ColorMatrixFilter
		{
			var tempAdjustColor:AdjustColor = new AdjustColor();
			tempAdjustColor.brightness = _brightness;
			tempAdjustColor.contrast = _contrast;
			tempAdjustColor.saturation = _saturation;
			tempAdjustColor.hue = _hue;
			var tempColorMatrixFilter:ColorMatrixFilter = new ColorMatrixFilter(tempAdjustColor.CalculateFinalFlatArray());
			return tempColorMatrixFilter;
		}
		
		//Hexadecimal to RGB array
		public static function hex2rgb(hex:uint):Array
		{
			var rgb:Array = new Array();
			rgb[0] = hex >> 16;
			rgb[1]= hex >> 8 & 0xFF;
			rgb[2] = hex & 0xFF;
			return rgb;
		}
		
		//RGB array to hexadecimal
		public static function rgb2hex (rgb:Array):uint
		{
			var hex:uint = rgb[0] << 16 ^ rgb[1] << 8 ^ rgb[2];
			return hex;
		}
		
		//HSB array to RGB array
		public static function hsb2rgb(hsb:Array):Array 
		{
			var red:Number, grn:Number, blu:Number, i:Number, f:Number, p:Number, q:Number, t:Number;
			hsb[0]%=360;
			if(hsb[2]==0) {return(new Array(0,0,0));}
			hsb[1]/=100;
			hsb[2]/=100;
			hsb[0]/=60;
			i = Math.floor(hsb[0]);
			f = hsb[0]-i;
			p = hsb[2]*(1-hsb[1]);
			q = hsb[2]*(1-(hsb[1]*f));
			t = hsb[2]*(1-(hsb[1]*(1-f)));
			if (i==0) {red=hsb[2]; grn=t; blu=p;}
			else if (i==1) {red=q; grn=hsb[2]; blu=p;}
			else if (i==2) {red=p; grn=hsb[2]; blu=t;}
			else if (i==3) {red=p; grn=q; blu=hsb[2];}
			else if (i==4) {red=t; grn=p; blu=hsb[2];}
			else if (i==5) {red=hsb[2]; grn=p; blu=q;}
			red = Math.floor(red*255);
			grn = Math.floor(grn*255);
			blu = Math.floor(blu*255);
			return (new Array(red,grn,blu));
		}
		
		//RGB array to HSB array
		public static function rgb2hsb(rgb:Array):Array 
		{
			var x:Number, f:Number, i:Number, hue:Number, sat:Number, val:Number;
			rgb[0]/=255;
			rgb[1]/=255;
			rgb[2]/=255;
			x = Math.min(Math.min(rgb[0], rgb[1]), rgb[2]);
			val = Math.max(Math.max(rgb[0], rgb[1]), rgb[2]);
			if (x==val){
				return(new Array(undefined,0,val*100));
			}
			f = (rgb[0] == x) ? rgb[1]-rgb[2] : ((rgb[1] == x) ? rgb[2]-rgb[0] : rgb[0]-rgb[1]);
			i = (rgb[0] == x) ? 3 : ((rgb[1] == x) ? 5 : 1);
			hue = Math.floor((i-f/(val-x))*60)%360;
			sat = Math.floor(((val-x)/val)*100);
			val = Math.floor(val*100);
			return(new Array(hue,sat,val));
		}
		
		//Hexadecimal to Matrix array
		public static function hex2matrix (hex:uint, alpha:Number):Array
		{
			var matrix:Array = [];
			matrix = matrix.concat([((hex & 0x00FF0000) >>> 16)/255, 0, 0, 0, 0]);// red
			matrix = matrix.concat([0, ((hex & 0x0000FF00) >>> 8)/255, 0, 0, 0]); //green
			matrix = matrix.concat([0, 0, (hex & 0x000000FF)/255, 0, 0]); // blue
			matrix = matrix.concat([0, 0, 0, alpha/100, 0]); // alpha
			return matrix;
		}
		
		//Hexadecimal to HSB array
		public static function hex2hsb(hex:uint):Array
		{
			return rgb2hsb(ColorMath.hex2rgb(hex))
		}
		
		public static function hsb2hex(hsb:Array):uint
		{
			return rgb2hex(ColorMath.hsb2rgb(hsb))
		}

	}
}