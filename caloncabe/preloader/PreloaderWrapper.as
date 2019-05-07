package 
{
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	/**
	* @author Anselm Bradford - anselmbradford.com
	*/
	public class PreloaderWrapper extends Sprite 
	{
		/**
		* Alias for content LoaderInfo instance
		*/
		private var _targetLoaderInfo:LoaderInfo;

		/**
		* The percent loaded
		*/
		private var _loadPercent:Number = 0;
		
		/**
		* Constructor
		* Creates Loader instance, adds event listeners and begins loading content SWF.
		*/
		public function PreloaderWrapper() 
		{
			var loader:Loader = new Loader();
			_targetLoaderInfo = loader.contentLoaderInfo;
			_targetLoaderInfo.addEventListener( ProgressEvent.PROGRESS, _loadingData );
			_targetLoaderInfo.addEventListener( Event.COMPLETE , _finishedLoading );
			loader.load( new URLRequest("/upload/games/gamethang1_secure.swf") );
			//loader.load( new URLRequest("gamethang1_secure.swf") );
		}
		
		/**
		* Monitor loading progress and update progress bar.
		*/
		private function _loadingData( evt:ProgressEvent ):void 
		{
			_loadPercent = _targetLoaderInfo.bytesLoaded / _targetLoaderInfo.bytesTotal;
			preloader.progBar.scaleX = _loadPercent;	
		}
		
		/**
		* Remove event listeners and preloader, and attach content SWF to stage.
		*/
		private function _finishedLoading( evt:Event ):void 
		{
			_targetLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, _loadingData );
			_targetLoaderInfo.removeEventListener( Event.COMPLETE , _finishedLoading );
			this.removeChild(preloader);
			this.addChild( DisplayObject(LoaderInfo(evt.target).content) );
		}
	}


}