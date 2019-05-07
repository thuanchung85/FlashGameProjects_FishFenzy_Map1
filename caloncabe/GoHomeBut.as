package 
{
	import flash.display.MovieClip;
	import flash.events.*;

	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class GoHomeBut extends MovieClip
	{
		public var music:Sound;
		public var _channel:SoundChannel;
		public function GoHomeBut()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}

		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			visible = false;

			buttonMode = true;
			addEventListener(MouseEvent.CLICK,onClick);
		}
		//////onClick//////
		public function onClick(e:MouseEvent):void
		{

			removeEventListener(MouseEvent.CLICK,onClick);
			MovieClip(root).gamestate = 0;
			if (int(MovieClip(root).gamescore.diem.textvalue.text) < 0)
			{
				MovieClip(root).gamescore.diem.textvalue.text = "0";
			}
			MovieClip(root).formsubmit.isShow = 1;
			MovieClip(root).setChildIndex(MovieClip(root).formsubmit,MovieClip(root).numChildren-1);

			MovieClip(root).gamescore.TANGDIEM(int(MovieClip(root).mpbar.textvalue.text)*1000);
			
			
			//start music
						music= new vangsound();
						_channel = music.play(0,1,null);
						var transform:SoundTransform = new SoundTransform(  );
						transform.volume = 1;
						_channel.soundTransform = transform;
		}

	}//end class

}