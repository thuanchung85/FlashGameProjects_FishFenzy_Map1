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
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.ui.Mouse;
	import flash.utils.getQualifiedClassName;


	public class Main extends MovieClip
	{
		public var gamestate:uint=0;
		public var filesave:String = "";
		public var music:Sound;
		public var _channel:SoundChannel;
		public var dode:int=1;
		public var music2:Sound;
		public var _channel2:SoundChannel;
		
		//loader XML file
		public var xmlURL:String = "";
		public var xmlLoader:URLLoader;
		public var xmlFile:XML;
		
		///////CONSTRUCTOR////////////
		public function Main()
		{

			////Context menu
			var myMenu_cm:ContextMenu = new ContextMenu();
			myMenu_cm.hideBuiltInItems();
			var my_notice = new ContextMenuItem("Version 1.0.1");
			myMenu_cm.customItems.push(my_notice);
			contextMenu = myMenu_cm;

			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);

		}


		/////////HAM CHI CHO PHEP CAC DOMAIN NAY CHAY///////////
		private function isDomainAllowed( allowed:Array ):Boolean
		{
			var lc:LocalConnection = new LocalConnection();
			var domain:String = lc.domain;

			for (var i:Number = 0; i < allowed.length; ++i)
			{
				if (domain == allowed[i])
				{
					trace("domain hien tai:" + domain);
					return true;
				}
			}
			for (var i:Number = 0; i < allowed.length; ++i)
			{
				if ( domain.substr(-( allowed[i].length + 1 ))== "." + allowed[i] )
				{
					trace("domain hien tai:" + domain);
					return true;
				}
			}
			trace("domain hien tai:" + domain);
			return false;
		}

		//////KHI LOAD HET LEN STAGE//////
		public function onAddToStage(e:Event):void
		{

			//Array cac domain cho phep chay
			var domains:Array = new Array("todaytv.vn","localhost","today.tv");
			if (isDomainAllowed(domains))
			//if(true)
			{
				trace( "cho phep" );

				//add event UPDATE GAME
				addEventListener(Event.ENTER_FRAME,Update);
				var r:Number = NumberUtilities.random(1,4);
				switch(r)
				{
					case 1:
						BGgame.gotoAndStop(1);
						break;
					case 2:
						BGgame.gotoAndStop(2);
						break;
					case 3:
						BGgame.gotoAndStop(3);
						break;
					case 4:
						BGgame.gotoAndStop(4);
						break;
				}
				
				
				
				player.visible=false;
				
				
				CallXML();
			}
			else
			{
				trace( "tu choi" );
			}

		}
		//////HAM CallXML//////
		public function CallXML():void
		{
			huongdanmc.debugtext.text = String(loaderInfo.parameters.datafile) + ":" +
										loaderInfo.parameters.playername + ":" +
										loaderInfo.parameters.playername1 + ":" +
										loaderInfo.parameters.playername2 + ":" +
										loaderInfo.parameters.playername3 + ":" +
										loaderInfo.parameters.playername4 + ":" +
										loaderInfo.parameters.playername5 + ":" +
										loaderInfo.parameters.avatarpic + ":" +
										loaderInfo.parameters.avatarpic1 + ":" +
										loaderInfo.parameters.avatarpic2 + ":" +
										loaderInfo.parameters.avatarpic3 + ":" +
										loaderInfo.parameters.avatarpic4 + ":" +
										loaderInfo.parameters.avatarpic5 + ":" +
										loaderInfo.parameters.levelnow ;
										
										
			if(loaderInfo.parameters.datafile!=null)
			{
				//huongdanmc.debugtext.text = stage.loaderInfo.parameters.datafile;
				xmlURL=loaderInfo.parameters.datafile + "&qwertyuiopzm=11";
				//xmlURL=stage.loaderInfo.parameters.datafile;
				MovieClip(root).levelnow.text=String(loaderInfo.parameters.levelnow);
				//chay tu 0 den levelopen
				//do de ap dung cho nguoi choi level thap hon 2 so voi level dang mo
				var tt:int =int(loaderInfo.parameters.levelopen)-int(loaderInfo.parameters.levelnow);
				trace(tt);
				if(tt>2)
				{
					dode=100;
				}
				else dode=0;
			}
			else
			{
				xmlURL="data.xml";
				//huongdanmc.debugtext.text = "no datafile";
			}
			
			//tao XML loader
			xmlLoader= new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, showXML);
			xmlLoader.load(new URLRequest(xmlURL));
			
			
		}
		/////////////////////KHI LOAD XML XONG////////////////////////
		function showXML(e:Event):void
		{
			trace("showXML main");

			XML.ignoreWhitespace = true;
			xmlFile = new XML(e.target.data);		
			
			MovieClip(root).filesave=xmlFile.@filesave;
			
			///duyet qua xml duyet question
			for each (var object:XML in xmlFile.question)
			{
				//trace(object.@answer);
				//trace(object);
				var cauhoiTemp:CauTrucTracNghiem= new CauTrucTracNghiem();
				cauhoiTemp.answer1=object.@answer1;
				cauhoiTemp.answer2=object.@answer2;
						
				cauhoiTemp.da=object.@da;
				cauhoiTemp.noidung=object;
				
				formTracNghiem.Arr_CauHoi.push(cauhoiTemp);
				
			}
				
				//maintime
				MovieClip(root).gametime.ACTIVE(xmlFile.@maxtime);
				
				
				//kick hoat nut ok tren huong dan
				huongdanmc.okbut.addEventListener(MouseEvent.CLICK,okbutClick);
				if(int(xmlFile.@lifesnow) == 0)huongdanmc.okbut.visible=false;
				else huongdanmc.okbut.visible=true;
			
			
		}
		
		/////////////////////OKBUT CLICK/////////////////////////
		public function okbutClick(e:Event):void
		{
			
			//lay data avatar tu xml			
			
				MovieClip(root).avatar.nameplayer.text=String(loaderInfo.parameters.playername);
				MovieClip(root).avatar.hinh.LOADHINH(String(loaderInfo.parameters.avatarpic));
				
				//lay data avatar playername1 tu xml			
				MovieClip(root).avatarH1.nameplayer.text=String(loaderInfo.parameters.playername1);
				MovieClip(root).avatarH1.hinh.LOADHINH(String(loaderInfo.parameters.avatarpic1));
				MovieClip(root).caboss1.strong="180";
				MovieClip(root).caboss1.scaleToFit(int(MovieClip(root).caboss1.strong),0);
				//lay data avatar playername2 tu xml			
				MovieClip(root).avatarH2.nameplayer.text=String(loaderInfo.parameters.playername2);
				MovieClip(root).avatarH2.hinh.LOADHINH(String(loaderInfo.parameters.avatarpic2));
				MovieClip(root).caboss2.strong="170";
				MovieClip(root).caboss2.scaleToFit(int(MovieClip(root).caboss2.strong),0);
				//lay data avatar playername3 tu xml			
				MovieClip(root).avatarH3.nameplayer.text=String(loaderInfo.parameters.playername3);
				MovieClip(root).avatarH3.hinh.LOADHINH(String(loaderInfo.parameters.avatarpic3));
				MovieClip(root).caboss3.strong="160";
				MovieClip(root).caboss3.scaleToFit(int(MovieClip(root).caboss3.strong),0);
				//lay data avatar playername4 tu xml			
				MovieClip(root).avatarH4.nameplayer.text=String(loaderInfo.parameters.playername4);
				MovieClip(root).avatarH4.hinh.LOADHINH(String(loaderInfo.parameters.avatarpic4));
				MovieClip(root).caboss4.strong="150";
				MovieClip(root).caboss4.scaleToFit(int(MovieClip(root).caboss4.strong),0);
				//lay data avatar playername5 tu xml			
				MovieClip(root).avatarH5.nameplayer.text=String(loaderInfo.parameters.playername5);
				MovieClip(root).avatarH5.hinh.LOADHINH(String(loaderInfo.parameters.avatarpic5));
				MovieClip(root).caboss5.strong="140";
				MovieClip(root).caboss5.scaleToFit(int(MovieClip(root).caboss5.strong),0);
			
			huongdanmc.visible=false;
			egg.buttonMode=true;
			//gamestate=0;
			//logomanager.timer.start();
			//camanager.timer.start();
			//gametime.timer.start();
			
			removeChild(huongdanmc);
			
			//start music
			music= new bgmusic();
			_channel = music.play(0,99,null);
			var transform:SoundTransform = new SoundTransform(  );
			transform.volume = 1;
			_channel.soundTransform = transform;
			
			music2= new bongbong2();
			_channel2 = music2.play(0,99,null);
			var transform:SoundTransform = new SoundTransform(  );
			transform.volume = 1;
			_channel2.soundTransform = transform;
		}



		//////////////////////Update/////////////////////////
		public function Update(e:Event):void
		{
			
			if(gamestate==1)
			{
				itemnguyhiemmanager.Update();
				camanager.Update();
				logomanager.Update();
				player.Update();
			}
			else
			{
				if(formTracNghiem!=null)formTracNghiem.Update();
				formsubmit.Update();
			}
		}
	}//end class

}