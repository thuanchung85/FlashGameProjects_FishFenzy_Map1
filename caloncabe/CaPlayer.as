package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.ui.Mouse;
	import flash.utils.getQualifiedClassName;

	public class CaPlayer extends MovieClip
	{
		public var isDie:Boolean = false;
		public var nhanhNhen:String="5";
		public var vx:Number;
		public var vy:Number;
		public var hungdu:Number=5;
		//min 1 max 150
		public var strong:String="20";
		public var strongCu:String="20";
		public var timerEndStrong:Timer;
		public var timerDelayStrong:Timer;
		
		public function CaPlayer()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			
		}
		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			//random hinh ca
			gotoAndStop(NumberUtilities.random(1,36));
			
			//random nhanh nhen
			nhanhNhen=(NumberUtilities.random(7,15)).toString();
			
			h.hitarea.addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			h.hitarea.addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
			
			timerEndStrong= new Timer(10000);
			timerEndStrong.addEventListener(TimerEvent.TIMER,ontimerEndStrong);
			
			timerDelayStrong= new Timer(2000);
			timerDelayStrong.addEventListener(TimerEvent.TIMER,ontimerDelayEndStrong);
		}
		//////////TANCONG/////////
		public function TANCONG():void
		{
			strongCu=strong;
			tancong.gotoAndStop(2);
			strong="200";
			timerEndStrong.start();
		}
		/////////ontimerEndStrong//////
		public function ontimerEndStrong(e:TimerEvent):void
		{
			//strong=strongCu;
			tancong.gotoAndStop(1);
			timerEndStrong.stop();
			timerDelayStrong.start();
		}
		/////////ontimerDelayEndStrong//////
		public function ontimerDelayEndStrong(e:TimerEvent):void
		{trace(Number(strong)-180);
			strong=(Number(strongCu)+(Number(strong)-180)).toString();
			
			timerDelayStrong.stop();
		}
		/////////MOUSE_OVER//////
		public function onMouseOver(e:MouseEvent):void
		{
			MovieClip(root).avatar.visible=true;
		}
		/////////MOUSE_OUT//////
		public function onMouseOut(e:MouseEvent):void
		{
			MovieClip(root).avatar.visible=false;
		}
		/////////DI CHUYEN THEO CHUOT//////
		public function FollowMouse():void
		{
			//move ca
			var dx:int = x - MovieClip(root).vungchuot.mouseX;
			var dy:int = y - MovieClip(root).vungchuot.mouseY;
			vx=dx / int(nhanhNhen);
			vy=dy / int(nhanhNhen);
			x -= vx ;
			y -= vy ;
			
			//quay đau ca
			if(stage.mouseX>x)
			{
				scaleX=- Math.abs(scaleX);
				
			}
			else
			{
				scaleX= Math.abs(scaleX);
				
			}
			
		}
		//TANG TRUONG////
		public function PHATTRIEN(n:Number):void
		{
			strong = (Number(strong)+n).toString();
			if(Number(strong)>200) strong="200";
			MovieClip(root).mpbar.TANGDIEM(n);
		}
		
		//////RESIZE CA//////////////
		function scaleToFit(maxW:int, maxH:int):void
		{
			maxH = maxH == 0 ? maxW : maxH;
			this.width = maxW;
			this.height = maxH;
			
			this.scaleX < this.scaleY ? this.scaleY = this.scaleX : this.scaleX = this.scaleY;
			
			
		}
		/////////Update//////
		public function Update():void
		{
			
			if(isDie==false)
			{
				scaleToFit(Number(strong),0);
				FollowMouse();
				if(this.h.grum.currentFrame==10)isDie=true;
				
				MovieClip(root).avatar.x=this.x;
				MovieClip(root).avatar.y=this.y-this.height/2;
			}
			else // ca player die
			{
				x=1000;
				y=1000;
				MovieClip(root).avatar.visible=false;
				
				MovieClip(root).gamestate=0;
				MovieClip(root).gametime.timer.stop();
				
				if(int(MovieClip(root).gamescore.diem.textvalue.text)<0)
				{
					MovieClip(root).gamescore.diem.textvalue.text="0";
				}
				MovieClip(root).formsubmit.isShow=1;
				MovieClip(root).setChildIndex(MovieClip(root).formsubmit,MovieClip(root).numChildren-1);

			}
			
		}
	}//end class

}