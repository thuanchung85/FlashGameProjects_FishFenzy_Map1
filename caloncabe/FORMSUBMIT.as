package 
{
	import flash.display.MovieClip;
	import flash.external.ExternalInterface;
	import flash.events.*;
	import flash.net.*;
	import flash.net.LocalConnection;
	import flash.utils.Timer;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	

	public class FORMSUBMIT extends MovieClip
	{
		public var isShow:uint = 2;
		public var initScore:int= 123456; 
		public var initTime:int	= 789;   
		public var timer:Timer;
		var ispass:Number=0;
		public var scriptLoader:URLLoader ;
		///////CONSTRUCTOR////////////
		public function FORMSUBMIT()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);

		}
		//////CHECK DIEU KHIEN PASS LEVEL//////
		public function CHECKPASSLEVEL_SCORE(sodiemhientai:Number,sodiempass:Number):void
		{
			if(sodiemhientai>=sodiempass)
			{
				PASSLEVEL();
				trace("qua level: " + MovieClip(root).levelnow.text);
				ispass=1;
				khungthang.visible=true;
			}
			else
			{
				trace("khong qua level: " + MovieClip(root).levelnow.text);
				ispass=0;
				khungthua.visible=true;
			}
			
		}
		
		//////CHUNG NHAN PASS LEVEL//////
		public function PASSLEVEL():void
		{
			//if(int(MovieClip(root).levelnow.text)<int(MovieClip(root).levelgame.text))
				//MovieClip(root).levelnow.text = (int(MovieClip(root).levelnow.text)+1).toString();
		}

		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{
			diemso.text="";
			thoigianchoi.text="";
			//tao timer dung de dung 3s de doc messwin va messlose
			timer= new Timer(10000);
			timer.addEventListener(TimerEvent.TIMER,onTime);
			timer.stop();
			this.gotoAndStop(1);
			okButton.addEventListener(MouseEvent.CLICK,okButtonClick);
			
			//khai bao loader php
			scriptLoader = new URLLoader();
			configureListeners(scriptLoader);
			
			//an form moi vo
			this.visible=false;
			this.isShow=0;
			
			//MovieClip(root).MSCD.text="6";
			//MovieClip(root).MD.text="100000";
			khungthang.visible=false;
			khungthua.visible=false;
			
		}
		
		//////////////////////
		private function configureListeners(dispatcher:IEventDispatcher):void 
		{
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
        }
		//////////////////////
		  private function completeHandler(event:Event):void 
		  {
            var loader:URLLoader = URLLoader(event.target);
            trace("completeHandler: " + loader.data);
    
            var vars:URLVariables = new URLVariables(loader.data);
            trace("The answer is " + vars.answer);
			if(ExternalInterface.available) ExternalInterface.call("reloadGamePage");
			//move to trochoi page
			//navigateToURL(new URLRequest("http://www.todaytv.vn/trochoi/1/29/3/todaytv-phu-song-toan-quoc.html"),"_self");
        }

        private function openHandler(event:Event):void 
		{
            trace("openHandler: " + event);
			//DEBUGER
			
        }

        private function progressHandler(event:ProgressEvent):void 
		{
            trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
			//DEBUGER
			
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void 
		{
            trace("securityErrorHandler: " + event);
			//DEBUGER
			//MovieClip(root).DEBUGER.visible=true;
			//MovieClip(root).DEBUGER.text="securityErrorHandler"+event.text;
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void 
		{
            trace("httpStatusHandler: " + event);
			//DEBUGER
			//MovieClip(root).DEBUGER.visible=true;
			//MovieClip(root).DEBUGER.text="httpStatusHandler" + event.responseURL;
        }

        private function ioErrorHandler(event:IOErrorEvent):void 
		{
            trace("ioErrorHandler: " + event);
			//DEBUGER
			//MovieClip(root).DEBUGER.visible=true;
			//MovieClip(root).DEBUGER.text="ioErrorHandler"+event.text;
        }
		//////////////////////okButtonClick/////////////////////////
		public function okButtonClick(e:MouseEvent):void
		{
			SUBMIT();
		}
		/////////////////////ONTIME TICK  DUNG DE AUTO LUU PHP SAU 10S////////////////////////
		function onTime(e:TimerEvent):void
		{
			SUBMIT();
		}
		//////////////////////SUBMIT/////////////////////////
		public function SUBMIT():void
		{
					//diemso.text= (Number(diemso.text) + Number(MovieClip(root).diemcu.text)).toString();
					//neu dat duoc 1000000 diem thi pass
					
					SUBMIT_PHP(Math.abs(Number(diemso.text)),Number(thoigianchoi.text),Number(MovieClip(root).levelgame.text),ispass,Number(MovieClip(root).socaudung.text));

		}
		//////////////////////SUBMIT_PHP/////////////////////////
		public function SUBMIT_PHP(diem:Number,thoigian:Number,level:Number, isPass:Number,socaudung:Number):void
		{
			timer.stop();
			this.gotoAndStop(2);
			okButton.visible=false;
			okButton.removeEventListener(MouseEvent.CLICK,SUBMIT_PHP);
			
			var myVariables:URLVariables = new URLVariables();
			//data 1
			myVariables.user_score =diem;// int(MovieClip(root).formGhepChu.ketquadiem.text);			
			myVariables.user_keyscore = Encryption.encrypt((myVariables.user_score + initScore).toString(),Encryption.CRYPTO_MD5);
			
			//data 2
			myVariables.user_time = thoigian;
			myVariables.user_keytime = Encryption.encrypt((myVariables.user_time + initTime).toString(),Encryption.CRYPTO_MD5);
						
			//data 3
			myVariables.user_level=level;
			
			//data 4
			myVariables.user_isPass=isPass;
			
			//data 5
			myVariables.user_correct=socaudung;
			
			//send data to php
			var phpUrl: String = MovieClip(root).filesave;
			/*phpUrl.replace("?","%3F");
			phpUrl.replace("=","%3D");
			phpUrl.replace("&","%26");*/
			var r1:RegExp = /%3F/g;
			var r2:RegExp = /%3D/g;
			var r3:RegExp = /%26/g;
			
			phpUrl=phpUrl.replace(r1, "?" );
			phpUrl=phpUrl.replace(r2, "=" );
			phpUrl=phpUrl.replace(r3, "&" );
			trace("phpUrl:" +phpUrl);
			//debugtext.text = socaudung.toString();
			var myURLRequest:URLRequest = new URLRequest(phpUrl);
			myURLRequest.data = myVariables;
			myURLRequest.method = URLRequestMethod.POST;
			scriptLoader.load(myURLRequest);
			
			
			
		}
		
		
			
		//////////////////////SHOW/////////////////////////
		public function SHOW():void
		{
			MovieClip(root).setChildIndex(this,MovieClip(root).numChildren-1);
			this.visible = true;
			if (this.alpha < 1)
			{
				this.alpha +=  0.1;
			}
			if (this.alpha >= 1)
			{
				isShow = 2;
				
				diemso.text=MovieClip(root).gamescore.diem.textvalue.text;
				
				thoigianchoi.text= (int(MovieClip(root).gametime.mainTimeGoc.text) - int(MovieClip(root).gametime.mainTime.text)).toString();
				MovieClip(root).gametime.timer.stop();
				
				CHECKPASSLEVEL_SCORE(Number(diemso.text),50000);
			}
			timer.start();
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
		//////////////////////Update/////////////////////////
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

		}
	}//end class

}