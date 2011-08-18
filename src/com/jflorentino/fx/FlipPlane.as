package com.jflorentino.fx
{
	import com.jflorentino.fx.FlipPlaneCanvas;

	/**
	 * @author James Florentino | jamesflorentino.com | j@jamesflorentino.com
	 */
	public class FlipPlane extends FlipPlaneCanvas  implements IFlipCanvas
	{
		public function FlipPlane ( columns : uint = 10 , rows : uint = 10 )
		{
			super ( columns , rows );
			behaviors.push ( random );
			behaviors.push ( linearTopLeft );
			behaviors.push ( linearTopRight );
			behaviors.push ( linearBottomLeft );
			behaviors.push ( linearBottomRight );
			flipY ();
		}

		public function random () : void
		{
			for (var i : uint = 0 ; i < planes.length; i ++ )
			{
				var delay : Number = Math.random () * .5;
				super.animateItem ( planes[i] , delay );
			}
		}

		public function linearBottomRight () : void
		{
			for (var i : uint = 0 ; i < planes.length; i ++ )
			{
				var delay : Number = ( _canvasColumns - planes[i]['tileX']) / _canvasColumns / 2;
				delay += (_canvasRows - planes[i]['tileY']) / _canvasRows / 2;
				super.animateItem ( planes[i] , delay );
			}
		}

		public function linearBottomLeft () : void
		{
			for (var i : uint = 0 ; i < planes.length; i ++ )
			{
				var delay : Number = planes[i]['tileX'] / _canvasColumns / 2;
				delay += (_canvasRows - planes[i]['tileY']) / _canvasRows / 2;
				super.animateItem ( planes[i] , delay );
			}
		}

		public function linearTopRight () : void
		{
			for (var i : uint = 0 ; i < planes.length; i ++ )
			{
				var delay : Number = ( _canvasColumns - planes[i]['tileX']) / _canvasColumns / 2;
				delay += planes[i]['tileY'] / _canvasRows / 2;
				super.animateItem ( planes[i] , delay );
			}
		}

		public function linearTopLeft () : void
		{
			for (var i : uint = 0 ; i < planes.length; i ++ )
			{
				var delay : Number = planes[i]['tileX'] / _canvasColumns / 2;
				delay += planes[i]['tileY'] / _canvasRows / 2;
				super.animateItem ( planes[i] , delay );
			}
		}
	}
}
