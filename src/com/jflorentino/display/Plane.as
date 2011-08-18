package com.jflorentino.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * @author James Florentino | jamesflorentino.com | j@jamesflorentino.com
	 */
	public class Plane extends Bitmap
	{
		public function Plane ( bitmapData : BitmapData = null , pixelSnapping : String = "auto" , smoothing : Boolean = false )
		{
			super ( bitmapData , pixelSnapping , smoothing );
		}
	}
}
