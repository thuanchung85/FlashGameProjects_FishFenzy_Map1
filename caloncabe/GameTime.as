package 
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;

	public class GameTime extends MovieClip
	{
		public var timer:Timer;
		
		// constructor code
		public function GameTime()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		//////////////////////////////
		public function init(e:Event):void
		{
			
			timer= new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,onTime);
			
		}
		
		
		//////////////////////////////
		public function onTime(e:TimerEvent):void
		{
			if(int(this.mainTime.text)>0)
			{
				
				this.mainTime.text= (int(this.mainTime.text)-1).toString();
			}
			else//het time
			{
				MovieClip(root).camanager.timer.stop();
				MovieClip(root).logomanager.timer.stop();
				
				
					MovieClip(root).gamestate=0;
				timer.stop();
				
				MovieClip(root).formsubmit.isShow=1;
				
				
			}
		}
		
		//HAM ACTIVE TIMER
		public function ACTIVE(n:uint):void
		{
			this.mainTime.text=n.toString();
			this.mainTimeGoc.text=this.mainTime.text;
			
		}

	}//end class

}