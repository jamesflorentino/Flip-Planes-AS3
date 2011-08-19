package com.jflorentino.fx
{
	import com.jflorentino.utils.Signal;

	import flash.display.MovieClip;
	import flash.display.DisplayObject;

	import com.greensock.easing.Back;
	import com.greensock.TweenMax;

	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Sprite;

	/**
	 * @author James Florentino | jamesflorentino.com | j@jamesflorentino.com
	 */
	public class FlipPlaneCanvas extends Sprite
	{
		protected var _planeWidth : int;
		protected var _planeHeight : int;
		protected var _canvasHeight : int;
		protected var _canvasWidth : int;
		private var _planes : Vector.<DisplayObject>;
		private var _patterns : Vector.<BitmapData>;
		private var _behaviors : Vector.<Function>;
		protected var staticPoint : Point;
		protected var _canvasRows : int;
		protected var _canvasColumns : int;
		protected var _current_pattern : uint = 0;
		protected var _current_behavior : uint = 0;
		protected var _flipX : Number = 0;
		protected var _flipY : Number = 0;
		protected var animation_complete : int;
		public var finished : Signal;

		public function FlipPlaneCanvas ( columns : uint = 10 , rows : uint = 10 )
		{
			_canvasWidth = 1122;
			_canvasHeight = 721;
			_flipX = 1;
			_flipY = 1;
			staticPoint = new Point ();
			_behaviors = new Vector.<Function>;
			finished = new Signal ();
			generatePlanes ( columns , rows );
		}

		public function doRandomTransition () : void
		{
			if (! patterns || ! patterns.length)
				throw new Error ( '[FlipPlaneCanvas] no patterns defined' );

			animation_complete = 0;
			_current_behavior = int ( Math.floor ( Math.random () * behaviors.length - 1 ) );
			behaviors[_current_behavior].call ();
		}

		public function doNextTransition () : void
		{
			if (! patterns || ! patterns.length)
				throw new Error ( '[FlipPlaneCanvas] no patterns defined' );

			animation_complete = 0;
			behaviors[_current_behavior].call ();

			_current_behavior ++;
			if (_current_behavior >= behaviors.length)
				_current_behavior = 0;
		}

		public function setNextPattern () : void
		{
			_current_pattern ++;
			if (_current_pattern >= patterns.length)
				_current_pattern = 0;
		}

		protected function onAnimateInComplete ( plane : MovieClip ) : void
		{
			var bmp : Bitmap = plane.getChildAt ( 0 ) as Bitmap;
			bmp.bitmapData.copyPixels ( _patterns[_current_pattern] , _patterns[_current_pattern].rect , new Point ( -_planeWidth * plane['tileX'] , -_planeHeight * plane['tileY'] ) );
			TweenMax.to ( plane , .5 , { removeTint : true , scaleX : 1 , scaleY : 1 , ease : Back.easeOut , onComplete : onAnimateOutComplete } );
		}

		protected function onAnimateOutComplete () : void
		{
			animation_complete ++;
			if (animation_complete < _planes.length)
				return;

			onAnimateComplete ();
		}

		private function onAnimateComplete () : void
		{
			finished.dispatch ();
		}

		private function generatePlanes ( cols : int , rows : int ) : void
		{
			_planeWidth = _canvasWidth / cols;
			_planeHeight = _canvasHeight / rows;
			_canvasColumns = cols;
			_canvasRows = rows;
			_planes = new Vector.<DisplayObject> ();
			for ( var yy : uint = 0 ; yy < _canvasRows ; yy ++ )
			{
				for ( var xx : uint = 0 ; xx < _canvasColumns ; xx ++ )
				{
					// create the bitmapdata
					var bmd : BitmapData = new BitmapData ( _planeWidth , _planeHeight , false , 0xff000000 );

					// create the bitmap
					var bmp : Bitmap = new Bitmap ( bmd );
					bmp.smoothing = true;
					bmp.x -= bmp.width / 2;
					bmp.y -= bmp.height / 2;

					// create the plane
					var plane : MovieClip = new MovieClip ();
					plane.addChild ( bmp );
					plane.x = _planeWidth * xx + _planeWidth / 2;
					plane.y = _planeHeight * yy + _planeHeight / 2;
					plane['tileX'] = xx;
					plane['tileY'] = yy;

					// add to the pool for transition reference
					_planes.push ( plane );

					// add to the display list
					addChild ( plane );
				}
			}
		}

		public function addPattern ( bitmap : Bitmap ) : void
		{
			if (! _patterns) _patterns = new Vector.<BitmapData>;
			var bmd : BitmapData = new BitmapData ( _canvasWidth , _canvasHeight );
			bmd.copyPixels ( bitmap.bitmapData , bitmap.bitmapData.rect , staticPoint );
			_patterns.push ( bmd );
		}

		public function setRandomPattern () : void
		{
			if (! _patterns || ! _patterns.length)
				throw new Error ( '[FlipPlaneCanvas] no patterns defined' );
			_current_pattern = int ( Math.random () * _patterns.length - 1 );
		}

		public function flipY ( bool : Boolean = true ) : void
		{
			_flipY = int ( bool );
			_flipX = int ( ! bool );
		}

		public function flipX ( bool : Boolean = true ) : void
		{
			_flipX = int ( bool );
			_flipY = int ( ! bool );
		}

		public function get patterns () : Vector.<BitmapData>
		{
			return _patterns;
		}

		public function get planes () : Vector.<DisplayObject>
		{
			return _planes;
		}

		public function get behaviors () : Vector.<Function>
		{
			return _behaviors;
		}

		protected function animateItem ( plane : DisplayObject , delay : Number ) : void
		{
			TweenMax.to ( plane , .25 , { tint : 0x000000 , delay : delay , scaleX : _flipX , scaleY : _flipY , ease : Back.easeIn , onComplete : onAnimateInComplete , onCompleteParams : [ plane ] } );
		}
	}
}
