package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
    import flash.events.*;
    import flash.net.*;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.LoaderInfo;


	public class ImageHolder extends MovieClip
	{
		
		
		public var imageLoader:Loader;
		
		var videoURL:String;
		var pictureURL:String;
		
		
		///////CONSTRUCTOR////////////
		public function ImageHolder() 
		{ 
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			
		}
		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			 imageLoader = new Loader();
			 imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadImageComplete);
			
			
			
			
		}
		
		
		
		/////EVENT HANDLER/////////////
		public function LOADHINH(pictureURL:String):void 
		{
			
			var image:URLRequest = new URLRequest (pictureURL);
			imageLoader.load(image);
			
			
			
		}
		//////////////EVENT HANDLE KHi LOAD HINH XONG//
		function loadImageComplete (e:Event):void
		{
			//trace("Loading Image Completed");
			
			this.addChild(imageLoader);
			
			
		}
		
		
		
		
		
		
	}//end class
	
}