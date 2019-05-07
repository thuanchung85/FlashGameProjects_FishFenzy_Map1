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
	
	public class CaManager extends MovieClip
	{
		public var arr_Item:Array;
		public var timer:Timer;
		public var isStop:Boolean=false;
		public var music:Sound;
		public var _channel:SoundChannel;
		
		// constructor code
		public function CaManager()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			//khoi tao array chua item
			arr_Item= new Array();
			
			//khoi tao timer goi ca npc
			timer= new Timer(900);
			timer.addEventListener(TimerEvent.TIMER,onTime);
					
			
		}
		//////ONTIME//////
		public function onTime(e:TimerEvent):void
		{
			if(isStop==false)
			{				
				CALLCANPC();				
			}
		}
		///////////HAM TAO ITEM//////
		public function CALLCANPC():void
		{	
			//loaica,strong,speed,hungdu
			var tempvang= new CAMC(NumberUtilities.random(1,39), NumberUtilities.random(10,100), NumberUtilities.random(1,5),NumberUtilities.random(1,10));			
			this.addChild(tempvang);
			arr_Item.push(tempvang);
						
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
						//////DUNG CA NPC///////
						if(arr_Item[i]!=undefined)
						{
							if( arr_Item[i].isDoi==true )
							{
								for(var j:uint=0;j<arr_Item.length;j++)
								{
									if(arr_Item[j]!=undefined)
									{
										if(arr_Item[i].h.hitarea.hitTestObject(arr_Item[j].h.hitarea)==true)
									{
									
										if(Number(arr_Item[i].strong) > Number(arr_Item[j].strong) +10)
										{
										
											
											if(arr_Item[j].h.grum.currentFrame==1)
											{
												arr_Item[j].h.grum.gotoAndPlay(2);
												arr_Item[i].isDoi=false;
												SOUNDGKUM();
											}
										}
									}
									}
								}
							}
							/////DUNG CA PLAYER//////
							if(MovieClip(root).player.h.hitarea.hitTestObject(arr_Item[i].h.hitarea)==true && arr_Item[i].isDie==false)
							{
								
								//neu strong player kem 10 diem strong ca
								if(Number(MovieClip(root).player.strong) < Number(arr_Item[i].strong) -20)
								{
									
									if(MovieClip(root).player.h.grum.currentFrame==1)MovieClip(root).player.h.grum.gotoAndPlay(2);
									SOUNDGKUM();
									
								}
								//neu strong player lon hon 10 ca npc
								else if(Number(MovieClip(root).player.strong) > Number(arr_Item[i].strong) +5)
								{
									//trace("dung " + arr_Item[i].strong);
									if(arr_Item[i].h.grum.currentFrame==1)
									{
										
										arr_Item[i].h.grum.gotoAndPlay(2);
										MovieClip(root).player.PHATTRIEN(1);
										MovieClip(root).gamescore.TANGDIEM(int(arr_Item[i].strong)*20);
										SOUNDGKUM();
									}
								}
								else
								{
									
								}
							}
						}
					}
				}
			}
			////////////
			
			
			
			
			
			
		}
		///////////////
		public function SOUNDGKUM():void
		{
			var r:Number = NumberUtilities.random(1,3);
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
					
					case 3:
						//start music
						music= new gkum4();
						_channel = music.play(0,1,null);
						var transform:SoundTransform = new SoundTransform(  );
						transform.volume = 1;
						_channel.soundTransform = transform;
						break;
				}
		}
		
	}//end class

}