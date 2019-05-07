package 
{

	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;
	import flash.utils.getQualifiedClassName;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;


	public class CAMC extends MovieClip
	{
		public var isShow:uint = 2;
		public var picked:Boolean = false;
		public var isHit:Boolean = false;
		public var isDie:Boolean = false;
		public var LiveTime:Number;
		public var timer:Timer;
		public var timerDoi:Timer;
		public var isDoi:Boolean=false;
		public var moveLR:Boolean;
		public var area:MovieClip;
		public var area2:MovieClip;
		public var scoreMC:MovieClip;
		public var music:Sound;
		public var _channel:SoundChannel;
		public var strong:String;
		public var speedX:Number;
		public var speedY:Number;
		public var hungdu:Number;
		public var vx:Number=0;
		public var vy:Number=0;
		//////////////////////////////
		public function CAMC(r:int,st:Number,sp:Number,hd:Number)
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
			gotoAndStop(r);
			strong=st.toString();
			speedX=sp;
			speedY=NumberUtilities.random(-speedX,speedX)/4;
			hungdu=hd + st/8;
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
			
			LiveTime = 30;
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,onTime);
			timerDoi = new Timer(10000);
			timerDoi.addEventListener(TimerEvent.TIMER,onTimeDoi);
			timerDoi.start();
			this.visible = false;
			this.alpha = 0;
			isShow = 1;

			
			
			// apply ratio your sprite's original dimensions:
			
			scaleToFit(Number(strong),0);

			var r:uint = NumberUtilities.random(0,1);
			if (r == 1)
			{
				this.x = NumberUtilities.random(-300,0);
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
		//////////////////////////////
		public function onTimeDoi(e:TimerEvent):void
		{
			isDoi=true;
		}
		//////////////////////////////
		public function onTime(e:TimerEvent):void
		{
			if (LiveTime > 0)
			{
				LiveTime--;
			}
			if (LiveTime <= 0)
			{
				timer.stop();
				timer = null;
				isDie = true;
				isShow = 0;
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

			if (isDie == false)
			{
				if(this.h.grum.currentFrame==10)
				{
					isDie=true;
					visible=false;
					x=10000;
				}
				AI();
				if (moveLR == true)
				{
					this.x+=speedX;
					this.y+=speedY;
					
					if(x>800){isDie=true; visible=false;}
					
					
				}
				else
				{
					this.x-=speedX;
					this.y-=speedY;
					if(x<-100){isDie=true; visible=false;}
				}

			}


		}
	}//end class
}