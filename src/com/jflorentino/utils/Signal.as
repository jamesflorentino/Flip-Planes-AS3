package com.jflorentino.utils
{
	/**
	 * @author James Florentino | jamesflorentino.com | j@jamesflorentino.com
	 */
	public class Signal
	{
		private var _callbacks : Vector.<Function>;

		public function Signal ()
		{
		}

		public function add ( callback : Function ) : void
		{
			if (! _callbacks)
				_callbacks = new Vector.<Function>;
			_callbacks.push ( callback );
		}

		public function dispatch () : void
		{
			if (! _callbacks.length || ! _callbacks)
				return;

			for (var i : uint = 0 ; i < _callbacks.length; i ++ )
			{
				_callbacks[i].call ();
			}
		}
	}
}
