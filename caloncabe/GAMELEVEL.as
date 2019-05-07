package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class GAMELEVEL extends MovieClip
	{
		public var timer:Timer;
		// constructor code
		public function GAMELEVEL()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			
			
			
		}
		///////////////ACTIVE ITEM/////////////////////
		public function ActiveItem():void
		{
			itemDungYenManager.timer.start();
			itemMoveManager.timer.start();	
		}
			
		//////Update//////
		public function Update():void
		{
			player.Update();
			itemDungYenManager.Update();
			itemMoveManager.Update();
		}
	}// emd class

}