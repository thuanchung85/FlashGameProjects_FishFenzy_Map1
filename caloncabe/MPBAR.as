package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;

	public class MPBAR extends MovieClip
	{
		
		public function MPBAR()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}

		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			
			TANGDIEM(0);
		}
		
		

		//////////////////////TANGDIEM/////////////////////////
		public function TANGDIEM(n:int):void
		{
			textvalue.text= (int(textvalue.text)+n).toString();
			if(int(textvalue.text)<300)
			{				
				mp.width = (int(textvalue.text) * 216)/300;
				
				
			}
		}
	}//end class

}