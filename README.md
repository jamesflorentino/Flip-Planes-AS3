# FlipPlane.as
An Actionscript3 class that converts a bitmap image into multiple planes

### Dependencies
- [TweenMax](http://www.greensock.com/tweenmax/)

### Example
- http://flipplanes.jamesflorentino.com/

## Sample Code
    var flipPlane : FlipPlane;
    function createFlipCanvas () : void
    {
        flipPlane = new FlipPlane ( 10 , 10 );
        flipPlane.addPattern ( new lib_bmp_intro as Bitmap );
        flipPlane.addPattern ( new lib_bmp as Bitmap );
        flipPlane.addPattern ( new lib_bmp2 as Bitmap );
        flipPlane.addPattern ( new lib_bmp3 as Bitmap );
        flipPlane.finished.add ( onPlaneTransition );
        flipPlane.doNextTransition ();
        addChild ( flipPlane );
    }
    
    function onPlaneTransition () : void
    {
        flipPlane.setNextPattern ();
        flipPlane.doNextTransition ();
    }
    