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

	public class FormCauHoi extends MovieClip
	{
		public var xmlURL:String = "";
		public var xmlLoader:URLLoader;
		public var xmlFile:XML;
		
		public var Arr_CauHoi:Array;
		public var cauDangActive:uint=0;
		public var isShow:uint=2;
		public var DA:String="oooo";
		
		public var timer:Timer;
		public var timer2:Timer;
		public var music:Sound;
		public var _channel:SoundChannel;
		
		///////CONSTRUCTOR////////////
		public function FormCauHoi()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);

		}


		
		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			if(stage.loaderInfo.parameters.datafile!=null)
			{
				this.khungnoidung.textfield.text=stage.loaderInfo.parameters.datafile;
				xmlURL=stage.loaderInfo.parameters.datafile + "&qwertyuiopzm=11";
			}
			else
			{
				xmlURL="data.xml";
				
			}
			
			//tao XML loader
			xmlLoader= new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, showXML);
			xmlLoader.load(new URLRequest(xmlURL));
			
			//khoi tao array cau hoi
			Arr_CauHoi= new Array();
			
			//an form moi vo
			this.visible=false;
			this.isShow=0;
			
			//gan event cho okbutton
			okbutton.addEventListener(MouseEvent.CLICK,onButClick);
			
			//an messwin messlose
			messwin.visible=false;
			messlose.visible=false;
			
			//tao timer dung de dung 3s de doc messwin va messlose
			timer= new Timer(5000);
			timer.addEventListener(TimerEvent.TIMER,onTime);
			timer.stop();
			
			//tao timer2 time nay dung de goi formsubmit
			timer2= new Timer(3000);
			timer2.addEventListener(TimerEvent.TIMER,onTime2);
			timer2.stop();
			
			//bat key press
			stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
		}
		
		////////////BAM CHUYEN SCREEN DE TEST/////////
		public function keyHandler(event:KeyboardEvent):void 
		{
			
			if(event.keyCode==Keyboard.BACKSPACE || event.keyCode==Keyboard.DELETE)
			 {	
			 ;
			 }
			 else
			 {
				//an het cac o ky tu tra loi ben duoi
				for(var i:int=1;i<=26;i++)
				{
					trace(stage.focus.parent.name);
					if( this["KT"+i].textIn.text.length==0)
					{						
						stage.focus = this["KT"+i].textIn;
						break;
					}					
				}
				/*//an het cac o ky tu tra loi ben duoi
				for(var i:int=1;i<=25;i++)
				{					
					if( this["KT"+i].textIn.text.length==0)
					{						
						stage.focus = this["KT"+(i+1)].textIn;
						break;
					}					
				}*/
			 }
		}
		/////////////////////ONTIME TICK  DUNG DE DUNG 3s DOC MESSWIN OR MESSLOSE////////////////////////
		function onTime(e:TimerEvent):void
		{
			timer.stop();
			this.isShow=0;
		}
		/////////////////////ONTIME TICK 2 DUNG DE DUNG 3s truoc khi show FORMSUBMIT////////////////////////
		function onTime2(e:TimerEvent):void
		{
			timer2.stop();
			MovieClip(root).formsubmit.isShow=1;
		}
		
		/////////////////////KHI CLICK OK BUTTON////////////////////////
		function onButClick(e:MouseEvent):void
		{
			okbutton.removeEventListener(MouseEvent.CLICK,onButClick);
					
			
			//check ket qua tra loi
			CheckAnswer();
			
			
		}
		
		/////////////////////KHI LOAD XML XONG////////////////////////
		function showXML(e:Event):void
		{
			trace("showXML");

			XML.ignoreWhitespace = true;
			xmlFile = new XML(e.target.data);		
			
			//lay data tu xml			
			MovieClip(root).filesave=xmlFile.@filesave;
			
			
			///duyet qua xml duyet question
			for each (var object:XML in xmlFile.question)
			{
				//trace(object.@answer);
				//trace(object);
				var cauhoiTemp:CauTrucCauHoi= new CauTrucCauHoi();
				cauhoiTemp.kqTraLoi=object.@answer;
				cauhoiTemp.noidungCauHoi=object;
				
				Arr_CauHoi.push(cauhoiTemp);
				
			}
			
			/////trace array de test
			for(var i=0;i<Arr_CauHoi.length;i++)
			{
				trace(Arr_CauHoi[i].noidungCauHoi);
				trace(Arr_CauHoi[i].kqTraLoi);	
				
			}
			
			
		}
		
		
		//////////////////////HAM BOC CAU HOI/////////////////////////
		public function BocCauHoi():void
		{
			//reset cac o ky tu tra loi
			for(var k:int=1;k<=26;k++)
			{
				this["KT"+k].textIn.text="";				
				this["KT"+k].textIn.tabIndex=k;
			}
			
			
			var r:uint=  NumberUtilities.random(0,Arr_CauHoi.length);
			
			//gan noi dung len text
			this.khungnoidung.textfield.text=Arr_CauHoi[r].noidungCauHoi;
			//lay dap an
			this.DA=Arr_CauHoi[r].kqTraLoi;
			trace(this.DA );
			
			//xoa cau hoi da ra roi
			Arr_CauHoi.splice(r, 1);
			
			//an het cac o ky tu tra loi ben duoi
			for(var i:int=1;i<=26;i++)
			{
				this["KT"+i].visible=false;
			}
			//hien cac o ky tu theo chiu dai dap dan
			for(var j:int=1;j<=this.DA.length;j++)
			{
				this["KT"+j].visible=true;
			}
		}
		
		//////////////////////SHOW/////////////////////////
		public function SHOW():void
		{
			MovieClip(root).setChildIndex(this,MovieClip(root).numChildren-1);
			//an messwin messlose
			messwin.visible=false;
			messlose.visible=false;
			this.visible=true;
			okbutton.addEventListener(MouseEvent.CLICK,onButClick);
			
				
			if(this.alpha<1)this.alpha+=0.1;
			if(this.alpha>=1)
			{
				BocCauHoi();
				isShow=2;
				stage.focus = this.KT1.textIn;
			}
			textHD.visible=true;				
				
			
			
		}
		
		//////////////////////HIDE/////////////////////////
		public function HIDE():void
		{
			if(this.alpha>0)
				this.alpha-=0.1;
			if(this.alpha<=0)
			{	
				this.visible=false;
				isShow=2;
				
				
			}		
			
			
		}
		
		///////HAM CHECK TRA LOI TRUNG SAI//////
		public function CheckAnswer():void
		{
			var kqtl:String="";
			for(var i:int=1;i<=26;i++)
			{
				if(this["KT"+i].visible==true)
				
					kqtl=kqtl+this["KT"+i].textIn.text;
			}
			trace("ket qua tra loi:"+kqtl);
			
			//tinh diem
			if(kqtl.toUpperCase()==DA) //tra loi trung
			{
				MovieClip(root).gamescore.TANGDIEM(100000);
				messwin.visible=true;				
				timer.start();
				MovieClip(root).socaudung.text = (int(MovieClip(root).socaudung.text)+1).toString();
				//start music
				music= new soundtrung();
				_channel = music.play(0,1,null);
				var transform:SoundTransform = new SoundTransform(  );
				transform.volume = 1;
				_channel.soundTransform = transform;
			}
			else//tra loi sai
			{				
				messlose.visible=true;					
				timer.start();
				//start music
				music= new soundsai();
				_channel = music.play(0,1,null);
				var transform:SoundTransform = new SoundTransform(  );
				transform.volume = 1;
				_channel.soundTransform = transform;
			}
			
			
			timer2.start();
				
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