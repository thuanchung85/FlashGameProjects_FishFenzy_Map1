package 
{
	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	import flash.events.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.LocalConnection;
	import flash.utils.Timer;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class FormTracNghiem extends MovieClip
	{
		
		
		
		public var Arr_CauHoi:Array;
		public var DA:String="";
		public var isShow:uint=2;
		
		
		//timer chay thoi gian main
		
		public var music:Sound;
		public var _channel:SoundChannel;
		
		///////CONSTRUCTOR////////////
		public function FormTracNghiem()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);

		}
		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			this.visible=false;
			//an form moi vo
			
			this.isShow=0;
			this.noidung.textfield.text="";
			this.DA1.textfield.text="";
			this.DA2.textfield.text="";
			
			
			this.DA1.buttonMode=true;
			this.DA2.buttonMode=true;
			//khoi tao array cau hoi
			Arr_CauHoi= new Array();
						
			thongbaokqtn.visible=false;
			thongbaokqtn.okBut.addEventListener(MouseEvent.CLICK,onThongbaokqtnOkButClick);
			
		}

		
		
		
		/////////////////////CLICK NUT OK THONG BAO KQTN////////////////////////
		function onThongbaokqtnOkButClick(e:Event):void
		{
			thongbaokqtn.okBut.visible=false;
			thongbaokqtn.okBut.removeEventListener(MouseEvent.CLICK,onThongbaokqtnOkButClick);
			
			
			
			this.isShow=0;
			
			
		}
		/////////////////////CLICK DA1////////////////////////
		function onClickDA1(e:Event):void
		{
			this.DA1.removeEventListener(MouseEvent.CLICK,onClickDA1);
			this.DA2.removeEventListener(MouseEvent.CLICK,onClickDA2);
			
			
			DA1.bg.gotoAndPlay(3);
			
			if("1"==this.DA)
			{
				trace("trung");
				thongbaokqtn.visible=true;				
				thongbaokqtn.gotoAndStop(1);
				music= new soundTrung();
			_channel= music.play(0,1,null);
				MovieClip(root).socaudung.text = int(MovieClip(root).socaudung.text)+1;
				MovieClip(root).player.PHATTRIEN(15 + MovieClip(root).dode/10);
			}
			else
			{
				thongbaokqtn.visible=true;
				trace("trat!");
				
				thongbaokqtn.gotoAndStop(2);
				music= new soundSai();
				_channel= music.play(0,1,null);
				
			}
		}
		/////////////////////CLICK DA2////////////////////////
		function onClickDA2(e:Event):void
		{
			this.DA1.removeEventListener(MouseEvent.CLICK,onClickDA1);
			this.DA2.removeEventListener(MouseEvent.CLICK,onClickDA2);
			
			
			DA2.bg.gotoAndPlay(3);
			
			if("2"==this.DA)
			{
				trace("trung");
				thongbaokqtn.visible=true;
				
				thongbaokqtn.gotoAndStop(1);
				music= new soundTrung();
				_channel= music.play(0,1,null);
				MovieClip(root).socaudung.text = int(MovieClip(root).socaudung.text)+1;
				MovieClip(root).player.PHATTRIEN(15 + MovieClip(root).dode/10);
			}
			else
			{
				thongbaokqtn.visible=true;
				trace("trat!");
				
				thongbaokqtn.gotoAndStop(2);
				music= new soundSai();
				_channel= music.play(0,1,null);
			}
		}
		
		/////////////////////OVER DA1////////////////////////
		function onOverDA1(e:Event):void
		{
			DA1.bg.gotoAndStop(2);
		}
		
		/////////////////////OVER DA2////////////////////////
		function onOverDA2(e:Event):void
		{
			DA2.bg.gotoAndStop(2);
		}
		
		
		/////////////////////OUT DA1////////////////////////
		function onOutDA1(e:Event):void
		{
			DA1.bg.gotoAndStop(1);
		}
		
		/////////////////////OUT DA2////////////////////////
		function onOutDA2(e:Event):void
		{
			DA2.bg.gotoAndStop(1);
		}
		
		
		
		
		
		
		//////////////////////HAM BOC CAU HOI/////////////////////////
		public function BocCauHoi():void
		{
			//reset cac o ky tu tra loi
			this.noidung.textfield.text="";
			this.DA1.textfield.text="";
			this.DA2.textfield.text="";
						
			var r:uint=  NumberUtilities.random(0,Arr_CauHoi.length-1);
			
			//gan noi dung len text
			this.noidung.textfield.text=Arr_CauHoi[r].noidung;
			//lay dap an			
			this.DA1.textfield.text=Arr_CauHoi[r].answer1;
			this.DA2.textfield.text=Arr_CauHoi[r].answer2;
			
			this.DA=Arr_CauHoi[r].da;
			//trace("boc cau:" + r + ":"+this.DA);
			//xoa cau hoi da ra roi
			Arr_CauHoi.splice(r, 1);
			//trace("hey");
			//kick hoat nut dap an
			this.DA1.addEventListener(MouseEvent.MOUSE_OVER,onOverDA1);
			this.DA2.addEventListener(MouseEvent.MOUSE_OVER,onOverDA2);
			
				
			this.DA1.addEventListener(MouseEvent.MOUSE_OUT,onOutDA1);
			this.DA2.addEventListener(MouseEvent.MOUSE_OUT,onOutDA2);
			
			
				
			this.DA1.addEventListener(MouseEvent.CLICK,onClickDA1);
			this.DA2.addEventListener(MouseEvent.CLICK,onClickDA2);
			
			
				
			thongbaokqtn.okBut.visible=true;
			thongbaokqtn.okBut.addEventListener(MouseEvent.CLICK,onThongbaokqtnOkButClick);

		}
		
		//////////////////////SHOW/////////////////////////
		public function SHOW():void
		{
			
			this.visible = true;
			thongbaokqtn.visible=false;
			if (this.alpha < 1)
			{
				this.alpha +=  0.1;
			}
			if (this.alpha >= 1)
			{
				isShow = 2;
				BocCauHoi();
				
				
				
				//MovieClip(root).sothu.textvalue.text=int(MovieClip(root).sothu.textvalue.text)-1;
				MovieClip(root).setChildIndex(this,MovieClip(root).numChildren-1);
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
				//thongbaokqtn.visible=false;
				isShow = 2;
				
				
				
				/*//thuong trung
				if(thongbaokqtn.currentFrame==1  && thongbaokqtn.visible==true)
				{
					MovieClip(root).hesonhan.textvalue.text = int(MovieClip(root).hesonhan.textvalue.text)+1;
				}
				//thuong sai
				if(thongbaokqtn.currentFrame==2)
				{
				}*/
				
				//resume game
				//MovieClip(root).gamestate=1;
			}
			
			
		}
		
		
		
		//////////////////////Update/////////////////////////
		public function Update():void
		{
			if(isShow==1)
				SHOW();
			else if(isShow==0)
					HIDE();
				
			
		}

	}//end class

}