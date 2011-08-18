package
{
	import com.jflorentino.fx.FlipPlane;

	import flash.events.Event;
	import flash.display.Bitmap;
	import flash.display.Sprite;

	[SWF(backgroundColor="#000000", frameRate="31", width="640", height="480")]
	public class Main extends Sprite
	{
		[Embed(source="../libs/intro.jpg")]
		private var lib_bmp_intro : Class;
		[Embed(source="../libs/zion_army_pose.jpg")]
		private var lib_bmp : Class;
		[Embed(source="../libs/lemurian_army_pose.jpg")]
		private var lib_bmp2 : Class;
		[Embed(source="../libs/seraph_army_pose.jpg")]
		private var lib_bmp3 : Class;
		[Embed(source="../libs/vignette.png")]
		private var lib_vignette : Class;
		private var flipPlane : FlipPlane;
		private var background : Sprite;
		private var vignette : Sprite;

		public function Main ()
		{
			createBackground ();
			createFlipCanvas ();
			createVignette ();
			addEventListener ( Event.ADDED_TO_STAGE , addedToStage );
		}

		private function createFlipCanvas () : void
		{
			// -- TODO -- //
			flipPlane = new FlipPlane ( 10 , 10 );
			flipPlane.addPattern ( new lib_bmp_intro as Bitmap );
			flipPlane.addPattern ( new lib_bmp as Bitmap );
			flipPlane.addPattern ( new lib_bmp2 as Bitmap );
			flipPlane.addPattern ( new lib_bmp3 as Bitmap );
			flipPlane.finished.add ( onPlaneTransition );
			flipPlane.doNextTransition ();
			addChild ( flipPlane );
		}

		private function onPlaneTransition () : void
		{
			flipPlane.setNextPattern ();
			flipPlane.doNextTransition ();
			// get a random direction for the plane animation
			Math.random () > .5 ? flipPlane.flipX () : flipPlane.flipY ();
		}

		// / DOCUMENT-RELATED CODE
		private function addedToStage ( event : Event ) : void
		{
			resize ();
			stage.addEventListener ( Event.RESIZE , onResize );
		}

		private function onResize ( event : Event ) : void
		{
			resize ();
		}

		private function resize () : void
		{
			background.width = flipPlane.width = stage.stageWidth;
			background.height = stage.stageHeight;
			flipPlane.scaleY = flipPlane.scaleX;
			vignette.x = flipPlane.x = stage.stageWidth / 2 - flipPlane.width / 2;
			vignette.y = flipPlane.y = stage.stageHeight / 2 - flipPlane.height / 2;
			vignette.width = flipPlane.width;
			vignette.height = flipPlane.height;
		}

		private function createBackground () : void
		{
			background = new Sprite ();
			background.graphics.beginFill ( 0x000000 );
			background.graphics.drawRect ( 0 , 0 , 1 , 1 );
			addChild ( background );
		}

		private function createVignette () : void
		{
			var bmp : Bitmap = new lib_vignette as Bitmap;
			vignette = new Sprite ();
			vignette.graphics.beginBitmapFill ( bmp.bitmapData );
			vignette.graphics.drawRect ( 0 , 0 , bmp.width , bmp.height );
			addChild ( vignette );
		}
	}
}
