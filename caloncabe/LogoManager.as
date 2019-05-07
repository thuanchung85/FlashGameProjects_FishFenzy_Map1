package 
{
	import flash.display.MovieClip;	
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.LocalConnection;
	import flash.utils.Timer;	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.getQualifiedClassName;
	
	public class LogoManager extends MovieClip
	{
		public var arr_Item:Array;
		public var timer:Timer;
		public var isStop:Boolean=false;
		public var music:Sound;
		public var _channel:SoundChannel;
		// constructor code
		public function LogoManager()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			//khoi tao array chua item
			arr_Item= new Array();
			
			//khoi tao timer goi logo
			timer= new Timer(10000);
			timer.addEventListener(TimerEvent.TIMER,onTime);
					
			
		}
		//////ONTIME//////
		public function onTime(e:TimerEvent):void
		{
			if(isStop==false)
			{				
				CALLLOGO();				
			}
		}
		///////////HAM TAO ITEM//////
		public function CALLLOGO():void
		{			
			
			var r:Number= NumberUtilities.random(1,6);
			switch(r)
			{
				case 1:
					var tempvang= new ManhLOGOT();			
					this.addChild(tempvang);
					tempvang.x=NumberUtilities.random(0,700);
					tempvang.y=NumberUtilities.random(0,500);
					arr_Item.push(tempvang);
					break;
				case 2:
					var tempvang= new ManhLOGOO();			
					this.addChild(tempvang);
					tempvang.x=NumberUtilities.random(0,700);
					tempvang.y=NumberUtilities.random(0,500);
					arr_Item.push(tempvang);
					break;
				case 3:
					var tempvang= new ManhLOGOD();			
					this.addChild(tempvang);
					tempvang.x=NumberUtilities.random(0,700);
					tempvang.y=NumberUtilities.random(0,500);
					arr_Item.push(tempvang);
					break;
				case 4:
					var tempvang= new ManhLOGOA();			
					this.addChild(tempvang);
					tempvang.x=NumberUtilities.random(0,700);
					tempvang.y=NumberUtilities.random(0,500);
					arr_Item.push(tempvang);
					break;
				case 5:
					var tempvang= new ManhLOGOY();			
					this.addChild(tempvang);
					tempvang.x=NumberUtilities.random(0,700);
					tempvang.y=NumberUtilities.random(0,500);
					arr_Item.push(tempvang);
					break;
				case 6:
					var tempvang= new ManhLOGOTG();			
					this.addChild(tempvang);
					tempvang.x=NumberUtilities.random(0,700);
					tempvang.y=NumberUtilities.random(0,500);
					arr_Item.push(tempvang);
					break;
			}
			
			
			
		}
		
		/////////////////UPDATE////////////
		public function Update():void
		{
			if(isStop==false)
			{
				for(var i:uint=0;i<arr_Item.length;i++)
				{
					if(arr_Item[i]!=undefined)
					{
						arr_Item[i].Update();
						
						/////DUNG CA PLAYER//////
						if(MovieClip(root).player.h.hitarea.hitTestObject(arr_Item[i])==true && arr_Item[i].isHit==false)
						{
								trace("hit");
								switch(getQualifiedClassName(arr_Item[i]))
								{
									case "ManhLOGOT":
										logobar.tt.gotoAndPlay(2);										
										break;
									case "ManhLOGOO":
										logobar.oo.gotoAndPlay(2);										
										break;
									case "ManhLOGOD":
										logobar.dd.gotoAndPlay(2);										
										break;
									case "ManhLOGOA":
										logobar.aa.gotoAndPlay(2);										
										break;
									case "ManhLOGOY":
										logobar.yy.gotoAndPlay(2);										
										break;
									case "ManhLOGOTG":
										logobar.tg.gotoAndPlay(2);										
										break;
									case "LOGOSN":
										MovieClip(root).sochiakhoa.textvalue.text = (int(MovieClip(root).sochiakhoa.textvalue.text)+1).toString();
										break;
								}
								arr_Item[i].isHit=true;
								arr_Item[i].isDie=true;
								MovieClip(root).player.PHATTRIEN(1);
								
								//start music
								music= new logosound();
								_channel = music.play(0,1,null);
								var transform:SoundTransform = new SoundTransform(  );
								transform.volume = 1;
								_channel.soundTransform = transform;
			
								
						}
						///////////////////////////////
						if(logobar.tg.currentFrame==21 &&
						   logobar.tt.currentFrame==21 &&
						   logobar.oo.currentFrame==21 &&
						   logobar.dd.currentFrame==21 &&
						    logobar.aa.currentFrame==21 &&
							 logobar.yy.currentFrame==21 )
						{
							trace("tan cong");
							MovieClip(root).player.TANCONG();
							logobar.tg.gotoAndStop(1);
						   logobar.tt.gotoAndStop(1);
						   logobar.oo.gotoAndStop(1);
						   logobar.dd.gotoAndStop(1);
						    logobar.aa.gotoAndStop(1);
							 logobar.yy.gotoAndStop(1);
							 
							 //start music
								music= new vodichsound();
								_channel = music.play(0,1,null);
								var transform:SoundTransform = new SoundTransform(  );
								transform.volume = 1;
								_channel.soundTransform = transform;
						}
						///////////////////////////////
						if(arr_Item[i].isDie==true)
						{
							if(arr_Item[i].visible==false)
							{
								arr_Item[i].x=2000;
								
								removeChild(arr_Item[i]);
								arr_Item.splice(i, 1);
								//trace("arr_Item.length: " + arr_Item.length);
							}
						}
						
						
						
					}
				}
			}
			////////////
			
			
			
			
			
			
		}
		
		
	}//end class

}