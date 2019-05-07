package 
{
	import flash.display.MovieClip;
	import flash.events.*;

	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class KHOBAU extends MovieClip
	{
		public var music:Sound;
		public var _channel:SoundChannel;
		public function KHOBAU()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			visible=false;
			sokg.text = NumberUtilities.random(80,250).toString();
			sologo.text = NumberUtilities.random(1,3).toString();
			buttonMode=true;
			addEventListener(MouseEvent.CLICK,onClick);
		}
		//////onClick//////
		public function onClick(e:MouseEvent):void
		{
			if(int(MovieClip(root).sochiakhoa.textvalue.text)>=int(this.sologo.text))
			{
				MovieClip(root).sochiakhoa.textvalue.text= (int(MovieClip(root).sochiakhoa.textvalue.text)-int(sologo.text)).toString();
				removeEventListener(MouseEvent.CLICK,onClick);
				var r:Number =  NumberUtilities.random(1,2);
				if(false)//(r==1)
				{
					BUM();
				}
				else
				{
					VANG();
				}
			}
		}
		/////BUM////
		public function BUM():void
		{
			gotoAndPlay(27);
			tnt.gotoAndPlay(2);
			//ca player bum
			if(MovieClip(root).player.h.grum.currentFrame==1)MovieClip(root).player.h.grum.gotoAndPlay(2);
			SOUNDGKUM();
			//start music
						music= new bumsound();
						_channel = music.play(0,1,null);
						var transform:SoundTransform = new SoundTransform(  );
						transform.volume = 1;
						_channel.soundTransform = transform;
		}
		//////VANG///////
		public function VANG():void
		{
			gotoAndPlay(2);
			MovieClip(root).gamescore.TANGDIEM(int(sokg.text)*1000);
			
			//start music
						music= new vangsound();
						_channel = music.play(0,1,null);
						var transform:SoundTransform = new SoundTransform(  );
						transform.volume = 1;
						_channel.soundTransform = transform;
		}
		
		///////////////
		public function SOUNDGKUM():void
		{
			var r:Number = NumberUtilities.random(1,2);
				switch(r)
				{
					case 1:
						//start music
						music= new ckum();
						_channel = music.play(0,1,null);
						var transform:SoundTransform = new SoundTransform(  );
						transform.volume = 1;
						_channel.soundTransform = transform;
						break;
					case 2:
						//start music
						music= new gkum1();
						_channel = music.play(0,1,null);
						var transform:SoundTransform = new SoundTransform(  );
						transform.volume = 1;
						_channel.soundTransform = transform;
						break;
				}
		}
	}//end class

}