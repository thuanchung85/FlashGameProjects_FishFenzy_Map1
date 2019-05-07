package 
{

	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;
	import flash.utils.getQualifiedClassName;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;


	public class Caboss extends MovieClip
	{
		
		public var music:Sound;
		public var _channel:SoundChannel;
		public var isHit:Boolean = false;
		public var isStop:Boolean = true;
		
		public var timer:Timer;
		public var timerDoi:Timer;
		public var isDoi:Boolean=false;
		public var moveLR:Boolean;
		
	
		
		public var strong:String;
		public var speedX:Number;
		public var speedY:Number;
		public var hungdu:Number;
		public var vx:Number=0;
		public var vy:Number=0;
		//////////////////////////////
		public function Caboss()
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
			gotoAndStop(NumberUtilities.random(1,39));
			strong="100";
			speedX=5;
			speedY=NumberUtilities.random(-speedX,speedX)/4;
			hungdu=NumberUtilities.random(5,10);
		}
		
		//////RESIZE CA//////////////
		function scaleToFit(maxW:int, maxH:int):void
		{
			maxH = maxH == 0 ? maxW : maxH;
			this.width = maxW;
			this.height = maxH;
			
			this.scaleX < this.scaleY ? this.scaleY = this.scaleX : this.scaleX = this.scaleY;
			
			
		}
		
		/////////////INIT/////////////////
		public function init(e:Event):void
		{
			
			
			timer = new Timer(20000);
			timer.addEventListener(TimerEvent.TIMER,onTime);
			timerDoi = new Timer(10000);
			timerDoi.addEventListener(TimerEvent.TIMER,onTimeDoi);
			timerDoi.start();
			
			

			
			
			// apply ratio your sprite's original dimensions:
			
			scaleToFit(int(strong),0);

			var r:uint = NumberUtilities.random(0,1);
			if (r == 1)
			{
				this.x = NumberUtilities.random(-300,-100);
				this.y = NumberUtilities.random(0,500);
				moveLR = true;
				scaleX=-Math.abs(scaleX);
				
			}
			if (r == 0)
			{
				this.x = NumberUtilities.random(900,1050);
				this.y = NumberUtilities.random(0,500);
				moveLR = false;
				scaleX=Math.abs(scaleX);
				
			}
			addEventListener(Event.ENTER_FRAME,Update);
		}
		//////////////////////////////
		public function onTimeDoi(e:TimerEvent):void
		{
			isDoi=true;
		}
		////////////RESET//////////////////
		public function onTime(e:TimerEvent):void
		{
			trace("goi ca boss");
			var c:Number = NumberUtilities.random(0,1);
			if(c==1)
				isStop=false;
			//timer.stop();
			var r:uint = NumberUtilities.random(0,1);
			if (r == 1)
			{
				this.x = NumberUtilities.random(-300,-100);
				this.y = NumberUtilities.random(0,500);
				moveLR = true;
				scaleX=-Math.abs(scaleX);
				
			}
			if (r == 0)
			{
				this.x = NumberUtilities.random(900,1050);
				this.y = NumberUtilities.random(0,500);
				moveLR = false;
				scaleX=Math.abs(scaleX);
				
			}
		}
		
		
		//////////AI///////
		public function AI():void
		{
			if( MovieClip(root).player.hungdu>this.hungdu)
			{
				//di player
				if ((Math.abs(x - MovieClip(root).player.x) < 60)   )
				{				
				
					if (Math.abs(y -  MovieClip(root).player.y) < 60)
					{
						//move ca
						var dx:int = x - MovieClip(root).player.x;
						var dy:int = y - MovieClip(root).player.y;
						vx=dx / 50;
						vy=dy / 50;
						x -= vx ;
						y -= vy ;
					}
				}
			
			}
			else
			{
				//Ne Player
				if ((Math.abs(x - MovieClip(root).player.x) < 60)   )
				{				
				
					if (Math.abs(y -  MovieClip(root).player.y) < 60)
					{
							
						vy +=  MovieClip(root).player.vy ;
						vx +=  MovieClip(root).player.vx ;
							
							y += -vy/50;
							x += -vx/50;
							
					}
				}
			}
		}
		
		/////////////////////////////////////////
		public function Update(e:Event):void
		{ 
			
			if (isStop == false)
			{
				if(this.name=="caboss1")
				{
					MovieClip(root).avatarH1.x=this.x;
					MovieClip(root).avatarH1.y=this.y-h.height/2;
				}
				else if(this.name=="caboss2")
				{
					MovieClip(root).avatarH2.x=this.x;
					MovieClip(root).avatarH2.y=this.y-h.height/2;
				} 
				else if(this.name=="caboss3")
				{
					MovieClip(root).avatarH3.x=this.x;
					MovieClip(root).avatarH3.y=this.y-h.height/2;
				} 
				else if(this.name=="caboss4")
				{
					MovieClip(root).avatarH4.x=this.x;
					MovieClip(root).avatarH4.y=this.y-h.height/2;
				} 
				else if(this.name=="caboss5")
				{
					MovieClip(root).avatarH5.x=this.x;
					MovieClip(root).avatarH5.y=this.y-h.height/2;
				} 
			
				//////DUNG CA NPC///////
				
				for(var j:uint=0;j<MovieClip(root).camanager.arr_Item.length;j++)
								{
									if(MovieClip(root).camanager.arr_Item[j]!=undefined)
									{
										if(h.hitarea.hitTestObject(MovieClip(root).camanager.arr_Item[j].h.hitarea)==true)
										{
									
											if(Number(this.strong) > Number(MovieClip(root).camanager.arr_Item[j].strong) +10)
											{
											
												
												if(MovieClip(root).camanager.arr_Item[j].h.grum.currentFrame==1)
												{
													MovieClip(root).camanager.arr_Item[j].h.grum.gotoAndPlay(2);
													this.isDoi=false;
													
													SOUNDGKUM();
												}
											}
										}
									}
								}
							
						
				/////DUNG CA PLAYER//////
				if(MovieClip(root).player.h.hitarea.hitTestObject(h.hitarea)==true)
				{
								//trace("aaa boss: " + this.strong); 
						//neu strong player kem 10 diem strong ca
						if(Number(MovieClip(root).player.strong) < Number(this.strong) -10)
								{
									
									trace(this.strong);
									
									if(MovieClip(root).player.h.grum.currentFrame==1)MovieClip(root).player.h.grum.gotoAndPlay(2);
									SOUNDGKUM();
								}
						//neu strong player lon hon 10 ca npc
						else if(Number(MovieClip(root).player.strong) > Number(this.strong) +10)
								{
									//trace("aaa me: " +MovieClip(root).player.strong); 
									if(h.grum.currentFrame==1)
									{
										
										h.grum.gotoAndPlay(2);
										MovieClip(root).player.PHATTRIEN(1);
										MovieClip(root).gamescore.TANGDIEM(int(this.strong)*10);
										SOUNDGKUM();
										
										if(this.name=="caboss1")
										{
											MovieClip(root).avatarH1.visible=false;
											MovieClip(root).avatarH1.x=1000;
											MovieClip(root).avatarH1.y=1000;
										}
										else if(this.name=="caboss2")
										{
											MovieClip(root).avatarH2.visible=false;
											MovieClip(root).avatarH2.x=1000;
											MovieClip(root).avatarH2.y=1000;
										} 
										else if(this.name=="caboss3")
										{
											MovieClip(root).avatarH3.visible=false;
											MovieClip(root).avatarH3.x=1000;
											MovieClip(root).avatarH3.y=1000;
										} 
										else if(this.name=="caboss4")
										{
											MovieClip(root).avatarH4.visible=false;
											MovieClip(root).avatarH4.x=1000;
											MovieClip(root).avatarH4.y=1000;
										} 
										else if(this.name=="caboss5")
										{
											MovieClip(root).avatarH5.visible=false;
											MovieClip(root).avatarH5.x=1000;
											MovieClip(root).avatarH5.y=1000;
										} 
									}
								}
								
				}
				
				AI();
				
				if (moveLR == true)
				{
					this.x+=speedX;
					this.y+=speedY;
					
					if(x>900){isStop=true;timer.reset();timer.start();}
					
					
				}
				else
				{
					this.x-=speedX;
					this.y-=speedY;
					if(x<-200){ isStop=true;timer.reset();timer.start();}
				}
				
				if(this.h.grum.currentFrame==10)
				{
					isStop=true;
					visible=false;
					x=10000;
					timer.stop();
					MovieClip(root).removeChild(this);
				}
				
				

			}


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