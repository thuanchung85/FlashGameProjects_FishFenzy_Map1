package 
{
	import flash.display.MovieClip;	
	import flash.events.*;	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.ui.Mouse;
	
	public class QuaTrung extends MovieClip
	{
		public var music:Sound;
		public var _channel:SoundChannel;
		public function QuaTrung()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			
		}
		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			addEventListener(MouseEvent.CLICK,onClick);
			
		}
		//////onClick//////
		public function onClick(e:MouseEvent):void
		{
			
			if( int(MovieClip(root).sothu.text)>0)
			{
				this.nextFrame();
				MovieClip(root).sothu.text= int(MovieClip(root).sothu.text)-1;
				MovieClip(root).formTracNghiem.isShow=1;
				
				//start music
				music= new bongbong1();
				_channel = music.play(0,1,null);
				var transform:SoundTransform = new SoundTransform(  );
				transform.volume = 1;
				_channel.soundTransform = transform;
				
				//start music
				music= new eggsound();
				_channel = music.play(0,1,null);
				var transform:SoundTransform = new SoundTransform(  );
				transform.volume = 1;
				_channel.soundTransform = transform;
			}
			else
			{
				this.gotoAndStop(7);
				MovieClip(root).player.visible=true;
				MovieClip(root).gamestate=1;
				MovieClip(root).itemnguyhiemmanager.timer.start();
				MovieClip(root).logomanager.timer.start();
				MovieClip(root).camanager.timer.start();
				MovieClip(root).gametime.timer.start();
				MovieClip(root).caboss1.timer.start();
				MovieClip(root).caboss2.timer.start();
				MovieClip(root).caboss3.timer.start();
				MovieClip(root).caboss4.timer.start();
				MovieClip(root).caboss5.timer.start();
				
				MovieClip(root)._channel.stop();
				var r:Number = NumberUtilities.random(1,3);
				switch(r)
				{
					case 1:
						//start music
						music= new bgmusic1();
						_channel = music.play(0,99,null);
						var transform:SoundTransform = new SoundTransform(  );
						transform.volume = 1;
						_channel.soundTransform = transform;
						break;
					case 2:
						//start music
						music= new bgmusic4();
						_channel = music.play(0,99,null);
						var transform:SoundTransform = new SoundTransform(  );
						transform.volume = 1;
						_channel.soundTransform = transform;
						break;
					case 3:
						//start music
						music= new bgmusic3();
						_channel = music.play(0,99,null);
						var transform:SoundTransform = new SoundTransform(  );
						transform.volume = 1;
						_channel.soundTransform = transform;
						break;
				}
				//this.x=1000;
				//this.y=1000;
				removeEventListener(MouseEvent.CLICK,onClick);
				MovieClip(root).removeChild(MovieClip(root).formTracNghiem);
				
			} 
		}

	}//end class

}