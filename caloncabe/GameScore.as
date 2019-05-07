package 
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;
	public class GameScore extends MovieClip
	{
		
		// constructor code
		public function GameScore()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		//////////////////////////////
		public function init(e:Event):void
		{
			
		}
		////////////TANGDIEM//////////////////
		public function TANGDIEM(giatri:int):void
		{
				
				diem.textvalue.text = (int(diem.textvalue.text) + giatri).toString();
				//diem.textvalue.text = (int(diem.textvalue.text) + MovieClip(root).dode).toString();
				
			
			
		}
		////////////GIAMDIEM//////////////////
		public function GIAMDIEM(giatri:int):void
		{
			
				diem.textvalue.text = (int(diem.textvalue.text) - giatri).toString();
				if(int(diem.textvalue.text)<0)
					diem.textvalue.text="0";
				
			
			
		}
		
	}//end class

}