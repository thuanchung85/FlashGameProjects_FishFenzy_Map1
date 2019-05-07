package 
{

	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;
	import flash.utils.getQualifiedClassName;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import ascb.util.NumberUtilities;

	public class CauhoiMC extends MovieClip
	{
		public var isShow:uint = 2;
		public var picked:Boolean = false;
		public var isHit:Boolean = false;
		public var isDie:Boolean=false;
		public var LiveTime:Number;
		public var timer:Timer;
		
		
		
		public var music:Sound;
		public var _channel:SoundChannel;
		
//////////////////////////////		
		public function CauhoiMC()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
			
		}
	//////////////////////////////
		public function init(e:Event):void
		{
			
			LiveTime= NumberUtilities.random(2,5);
			timer= new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,onTime);
			timer.start();
			this.visible=false;
			this.alpha=0;
			isShow=1;
			
			
			
		}
		//////////////////////////////
		public function onTime(e:TimerEvent):void
		{
			if(LiveTime>0)
			{
				LiveTime--;
			}
			if(LiveTime<=0)
			{
				timer.stop();
				timer=null;
				isDie=true;
				isShow=0;
			}
		}
		//////////////////////SHOW/////////////////////////
		public function SHOW():void
		{
			this.visible = true;
			if (this.alpha < 1)
			{
				this.alpha +=  0.1;
			}
			if (this.alpha >= 1)
			{
				isShow = 2;
				
			}
			
		}
		
		//////////////////////HIDE/////////////////////////
		public function HIDE():void
		{
			if (this.alpha > 0)
			{
				this.alpha -=  0.1;
			}
			if (this.alpha <= 0)
			{
				this.visible = false;
				isShow = 2;
				isDie=true;
			}
			
		}
/////////////////////////////////////////
		public function Update():void
		{
			if (isShow == 1)
			{
				SHOW();
			}
			else if (isShow==0)
			{
				HIDE();
			}
			
			if(isDie==false)
			{
				if(MovieClip(root).playernamdam.hitarea.hitTestObject(this)==true)
				{
					isHit=true;
				}
				if(isHit==true)
				{			
					gotoAndPlay(2);
					timer.stop();
					isDie=true;
					isHit=false;
					MovieClip(root).sothu.textvalue.text = int(MovieClip(root).sothu.textvalue.text)+1;
				}
			
			
			}
			
		}

		
	}//end class
}