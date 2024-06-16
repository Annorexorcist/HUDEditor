package
{
   import Shared.AS3.Data.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.text.*;
   import flash.utils.*;
   import Shared.GlobalFunc;
   import scaleform.gfx.*;
  

	/**
	 * ...
	 * @author Bolbman
	 * Modified for HUDEditor mod by Annorexorcist
	 * 
	 * Code is licensed under the GNU GPL
	 */
	
	public class HUDEditor extends MovieClip 
	{
		[Embed(source = "hudmenu2.swf", symbol = "HUDMessageItemBox")]
		private var HUDMessageItemBox:Class;
		
		[Embed(source="hudmenu2.swf", symbol="FlashLightWidget")]
		private var FlashLightWidget:Class;
		
		private const PercentMax:Number = 1.0;
		
		private var topLevel:* = null;
		private var xmlConfigHC:XML;
		private var xmlLoaderHC:URLLoader;
		private var textURL:URLRequest;
		private var textLoader:URLLoader;
		private var updateTimerHC:Timer;

		private var debugTextHC:TextField;
		private var watermark:TextField;
		private var thirst:TextField;
		private var hunger:TextField;
		private var showHealthText:TextField;
		
		private var rightmetersBrightness:Number = 0;
		private var rightmetersContrast:Number = 0;
		private var rightmetersSaturation:Number = 0;
		private var rightmetersRGB1:* = "00ff00";
		public var hudHUErightmeters:Number = 0;
		
		private var leftmetersBrightness:Number = 0;
		private var leftmetersContrast:Number = 0;
		private var leftmetersSaturation:Number = 0;
		private var leftmetersRGB1:* = "00ff00";
		public var hudHUEleftmeters:Number = 0;
		
		private var notiBrightness:Number = 0;
		private var notiContrast:Number = 0;
		private var notiSaturation:Number = 0;
		private var notiRGB1:* = "00ff00";
		public var hudHUEnoti:Number = 0;
		
		private var frobberBrightness:Number = 0;
		private var frobberContrast:Number = 0;
		private var frobberSaturation:Number = 0;
		private var frobberRGB1:* = "00ff00";
		public var hudHUEfrobber:Number = 0;
		
		private var trackerBrightness:Number = 0;
		private var trackerContrast:Number = 0;
		private var trackerSaturation:Number = 0;
		private var trackerRGB1:* = "00ff00";
		public var hudHUEtracker:Number = 0;
		
		private var topcenterBrightness:Number = 0;
		private var topcenterContrast:Number = 0;
		private var topcenterSaturation:Number = 0;
		private var topcenterRGB1:* = "00ff00";
		public var hudHUEtopcenter:Number = 0;
		
		private var bottomcenterBrightness:Number = 0;
		private var bottomcenterContrast:Number = 0;
		private var bottomcenterSaturation:Number = 0;
		private var bottomcenterRGB1:* = "00ff00";
		public var hudHUEbottomcenter:Number = 0;
		
		private var bccompassBrightness:Number = 0;
		private var bccompassContrast:Number = 0;
		private var bccompassSaturation:Number = 0;
		private var bccompassRGB1:* = "00ff00";
		public var hudHUEbccompass:Number = 0;
		
		private var radsbarBrightness:Number = 0;
		private var radsbarContrast:Number = 0;
		private var radsbarSaturation:Number = 0;
		private var radsbarRGB:* = "00ff00";
		public var hudHUEradsbar:Number = 0;
		
		private var announceBrightness:Number = 0;
		private var announceContrast:Number = 0;
		private var announceSaturation:Number = 0;
		private var announceRGB1:* = "00ff00";
		public var hudHUEannounce:Number = 0;
		
		private var centerBrightness:Number = 0;
		private var centerContrast:Number = 0;
		private var centerSaturation:Number = 0;
		private var centerRGB1:* = "00ff00";
		public var hudHUEcenter:Number = 0;
	
		private var teamBrightness:Number = 0;
		private var teamContrast:Number = 0;
		private var teamSaturation:Number = 0;
		private var teamRGB1:* = "00ff00";
		private var teamRadsBrightness:Number = 0;
		private var teamRadsContrast:Number = 0;
		private var teamRadsSaturation:Number = 0;
		private var teamRadsRGB:* = "ff0000";
		public var hudHUEteamrads:Number = 0;
		public var hudHUEteam:Number = 0;
		
		private var floatingBrightness:Number = 0;
		private var floatingContrast:Number = 0;
		private var floatingSaturation:Number = 0;
		private var floatingRGB1:* = "00ff00";
		public var hudHUEfloating:Number = 0;
		
		private var hmBrightness:Number = 0;
		private var hmContrast:Number = 0;
		private var hmSaturation:Number = 0;
		private var hudRGBHM:* = "00ff00";
		public var hudHUEHM:Number = 0;
		
		public var teamNum:Number;
		
		public var SneakMeterScale:* = 1;
		public var SneakMeterPos:Point = new Point();
		public var QuestScale:Number = 1;
		public var QuestPos:Point = new Point ();
		public var NotificationScale:Number = 1;
		public var NotificationPos:Point = new Point ();
		public var LeftMeterScale:Number = 1;
		public var LeftMeterPos:Point = new Point ();
		public var APMeterScale:Number = 1;
		public var APMeterPos:Point = new Point ();
		public var ActiveEffectsScale:Number = 1;
		public var ActiveEffectsPos:Point = new Point ();
		public var HungerMeterScale:Number = 1;
		public var HungerMeterPos:Point = new Point ();
		public var ThirstMeterScale:Number = 1;
		public var ThirstMeterPos:Point = new Point ();
		public var AmmoCountScale:Number = 1;
		public var AmmoCountPos:Point = new Point ();
		public var ExplosiveAmmoCountScale:Number = 1;
		public var ExplosiveAmmoCountPos:Point = new Point ();
		public var FlashLightWidgetScale:Number = 1;
		public var FlashLightWidgetPos:Point = new Point ();
		public var EmoteScale:Number = 1;
		public var EmotePos:Point = new Point ();
		public var FusionScale:Number = 1;
		public var FusionPos:Point = new Point ();
		public var CompassScale:Number = 1;
		public var CompassPos:Point = new Point ();
		public var AnnounceScale:Number = 1;
		public var AnnouncePos:Point = new Point ();
		public var QuickLootScale:Number = 1;
		public var QuickLootPos:Point = new Point ();
		public var TeamPanelScale:Number = 1;
		public var TeamPanelPos:Point = new Point ();
		public var FrobberScale:Number = 1;
		public var FrobberPos:Point = new Point ();
		public var RollOverScale:Number = 1;
		public var RollOverPos:Point = new Point ();
		public var SubtitlesScale:Number = 1;
		public var SubtitlesPos:Point = new Point ();
		public var EnemyHealthScale:Number = 1;
		public var EnemyHealthPos:Point = new Point ();
		public var XPBarScale:Number = 1;
		public var XPBarPos:Point = new Point ();
		public var CritMeterScale:Number = 1;
		public var CritMeterPos:Point = new Point ();
		public var CurrencyScale:Number = 1;
		public var CurrencyPos:Point = new Point ();
		public var LevelUpAnimScale:Number = 1;
		public var LevelUpAnimPos:Point = new Point ();
		public var RepUpdatesScale:Number = 1;
		public var RepUpdatesPos:Point = new Point ();
		public var HitMarkerScale:Number = 1;
		public var HitMarkerPos:Point = new Point ();
		
		public var TeamPanelPosPA:Point = new Point ();
		public var HungerMeterPosPA:Point = new Point ();
		public var ThirstMeterPosPA:Point = new Point ();
		public var ExplosiveAmmoCountPosPA:Point = new Point ();
		
		public var TeamPanelScalePA:Number = 1;
		public var HungerMeterScalePA:Number = 1;
		public var ThirstMeterScalePA:Number = 1;
		public var ExplosiveAmmoCountScalePA:Number = 1;
		
		private var reloadCount:int = 0;
		
		private static var rightmetersColorMatrix:ColorMatrixFilter = null;
		private static var rightmetersInvColorMatrix:ColorMatrixFilter = null;
		private static var leftmetersColorMatrix:ColorMatrixFilter = null;
		private static var leftmetersInvColorMatrix:ColorMatrixFilter = null;
		private static var notiColorMatrix:ColorMatrixFilter = null;
		private static var frobberColorMatrix:ColorMatrixFilter = null;
		private static var topcenterColorMatrix:ColorMatrixFilter = null;
		private static var bottomcenterColorMatrix:ColorMatrixFilter = null;
		private static var bottomcenterInvColorMatrix:ColorMatrixFilter = null;
		private static var announceColorMatrix:ColorMatrixFilter = null;
		private static var announceInvColorMatrix:ColorMatrixFilter = null;
		private static var centerColorMatrix:ColorMatrixFilter = null;
		private static var trackerColorMatrix:ColorMatrixFilter = null;
		private static var teamColorMatrix:ColorMatrixFilter = null;
		private static var teamInvColorMatrix:ColorMatrixFilter = null;
		private static var teamradsColorMatrix:ColorMatrixFilter = null;
		private static var floatingColorMatrix:ColorMatrixFilter = null;
		private static var floatingInvColorMatrix:ColorMatrixFilter = null;
		private static var radsbarColorMatrix:ColorMatrixFilter = null;
		private static var sneakDangerColorMatrix:ColorMatrixFilter = null;
		private static var bccompassColorMatrix:ColorMatrixFilter = null;
		private static var bccompassInvColorMatrix:ColorMatrixFilter = null;
		
		private static var hudColorHitMarkerMatrix:ColorMatrixFilter = null;
		
		private var oLeftMeterPos:Point = new Point();
		private var oAPMeterPos:Point = new Point();
		private var oActiveEffectsPos:Point = new Point();
		private var oHungerMeterPos:Point = new Point();
		private var oThirstMeterPos:Point = new Point();
		private var oAmmoCountPos:Point = new Point();
		private var oExplosiveAmmoCountPos:Point = new Point();
		private var oFlashLightWidgetPos:Point = new Point();
		private var oEmotePos:Point = new Point();
		private var oCompassPos:Point = new Point();
		private var oAnnouncePos:Point = new Point();
		private var oNotificationPos:Point = new Point();
		private var oQuestPos:Point = new Point();
		private var oSneakPos:Point = new Point();
		private var oQuickLootPos:Point = new Point();
		private var oFrobberPos:Point = new Point();
		private var oTeamPanelPos:Point = new Point();
		private var oFusionPos:Point = new Point();
		private var oRollOverPos:Point = new Point();
		private var oSubtitlePos:Point = new Point();
		private var oEnemyHealthPos:Point = new Point();
		private var oXPBarPos:Point = new Point();
		private var oCritMeterPos:Point = new Point();
		private var oCurrencyPos:Point = new Point();
		private var oLevelUpAnimPos:Point = new Point();
		private var oRepUpdatesPos:Point = new Point();
		private var VisibilityChanged:int = 0;
		private var oHitMarkerPos:Point = new Point();
		private var iniLoader:URLLoader;
		
		private var _CharInfo:Object;
		
		private var thpShow:String = "";
		
		private var thirstPC:Number = 0;
		private var hungerPC:Number = 0;
		
		private var inPowerArmor:Boolean = false;
		private var powerArmorHUDEnabled:Boolean = false;
		
		private const maxScale:Number = 1.5;
		
		private var HUDNotification_mc:Object = new HUDMessageItemBox;
		private var FlashLightRestored_mc:Object = new FlashLightWidget;
		private var EventCloseTimer:Timer;
		private var reloadCountNukeCodes:Number = 0;
		
		public function HUDEditor() 
		{
			updateTimerHC = new Timer(20, 0);
			EventCloseTimer = new Timer(15000,0);
			initDebugText();
			initWatermarkText();
			initThirstText();
			initHungerText();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			trace("HUDEditor Started");
			
		}
		
		private function addedToStageHandler(e:Event):void
		{
			topLevel = stage.getChildAt(0);
			if(topLevel != null && getQualifiedClassName(topLevel) == "HUDMenu")
			{
				this.initShowHealthText();
				
				oLeftMeterPos.x = topLevel.LeftMeters_mc.x;
				oLeftMeterPos.y = topLevel.LeftMeters_mc.y;
				
				oRepUpdatesPos.x = topLevel.ReputationUpdates_mc.x;
				oRepUpdatesPos.y = topLevel.ReputationUpdates_mc.y;
				
				oLevelUpAnimPos.x = topLevel.LevelUpAnimation_mc.x;
				oLevelUpAnimPos.y = topLevel.LevelUpAnimation_mc.y;
				
				oAPMeterPos.x = topLevel.RightMeters_mc.ActionPointMeter_mc.x;
				oAPMeterPos.y = topLevel.RightMeters_mc.ActionPointMeter_mc.y;
				
				oActiveEffectsPos.x = topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.x;
				oActiveEffectsPos.y = topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.y;
				
				oHungerMeterPos.x = topLevel.RightMeters_mc.HUDHungerMeter_mc.x;
				oHungerMeterPos.y = topLevel.RightMeters_mc.HUDHungerMeter_mc.y;
				
				oThirstMeterPos.x = topLevel.RightMeters_mc.HUDThirstMeter_mc.x;
				oThirstMeterPos.y = topLevel.RightMeters_mc.HUDThirstMeter_mc.y;
				
				oAmmoCountPos.x = topLevel.RightMeters_mc.AmmoCount_mc.x;
				oAmmoCountPos.y = topLevel.RightMeters_mc.AmmoCount_mc.y;
				
				oExplosiveAmmoCountPos.x = topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.x;
				oExplosiveAmmoCountPos.y = topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.y;
				
				oFlashLightWidgetPos.x = topLevel.RightMeters_mc.FlashLightWidget_mc.x;
				oFlashLightWidgetPos.y = topLevel.RightMeters_mc.FlashLightWidget_mc.y;
				
				oEmotePos.x = topLevel.RightMeters_mc.LocalEmote_mc.x;
				oEmotePos.y = topLevel.RightMeters_mc.LocalEmote_mc.y;

				oCompassPos.x = topLevel.BottomCenterGroup_mc.CompassWidget_mc.x;
				oCompassPos.y = topLevel.BottomCenterGroup_mc.CompassWidget_mc.y;

				oAnnouncePos.x = topLevel.AnnounceEventWidget_mc.x;
				oAnnouncePos.y = topLevel.AnnounceEventWidget_mc.y;

				oNotificationPos.x = topLevel.HUDNotificationsGroup_mc.Messages_mc.x;
				oNotificationPos.y = topLevel.HUDNotificationsGroup_mc.Messages_mc.y;

				oQuestPos.x = topLevel.TopRightGroup_mc.NewQuestTracker_mc.x;
				oQuestPos.y = topLevel.TopRightGroup_mc.NewQuestTracker_mc.y;

				oSneakPos.x = topLevel.TopCenterGroup_mc.StealthMeter_mc.x;
				oSneakPos.y = topLevel.TopCenterGroup_mc.StealthMeter_mc.y;

				oQuickLootPos.x = topLevel.CenterGroup_mc.QuickContainerWidget_mc.x;
				oQuickLootPos.y = topLevel.CenterGroup_mc.QuickContainerWidget_mc.y;
				
				oTeamPanelPos.x = topLevel.getChildAt(17).x;
				oTeamPanelPos.y = topLevel.getChildAt(17).y;
				
				oFrobberPos.x = topLevel.FrobberWidget_mc.x;
				oFrobberPos.y = topLevel.FrobberWidget_mc.y;
				
				oRollOverPos.x = topLevel.CenterGroup_mc.RolloverWidget_mc.x;
				oRollOverPos.y = topLevel.CenterGroup_mc.RolloverWidget_mc.y;
				
				oFusionPos.x = topLevel.RightMeters_mc.HUDFusionCoreMeter_mc.x;
				oFusionPos.y = topLevel.RightMeters_mc.HUDFusionCoreMeter_mc.y;
				
				oSubtitlePos.x = topLevel.BottomCenterGroup_mc.SubtitleText_mc.x;
				oSubtitlePos.y = topLevel.BottomCenterGroup_mc.SubtitleText_mc.y;
				
				oXPBarPos.x = topLevel.HUDNotificationsGroup_mc.XPMeter_mc.x;
				oXPBarPos.y = topLevel.HUDNotificationsGroup_mc.XPMeter_mc.y;
				
				oCritMeterPos.x = topLevel.BottomCenterGroup_mc.CritMeter_mc.x;
				oCritMeterPos.y = topLevel.BottomCenterGroup_mc.CritMeter_mc.y;
				
				oCurrencyPos.x = topLevel.HUDNotificationsGroup_mc.CurrencyUpdates_mc.x;
				oCurrencyPos.y = topLevel.HUDNotificationsGroup_mc.CurrencyUpdates_mc.y;
				
				oEnemyHealthPos.x = topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.x;
				oEnemyHealthPos.y = topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.y;
				
				oHitMarkerPos.x = topLevel.CenterGroup_mc.HitIndicator_mc.x;
				oHitMarkerPos.y = topLevel.CenterGroup_mc.HitIndicator_mc.y;
				
				topLevel.RightMeters_mc.HUDThirstMeter_mc.addChild(thirst);
				topLevel.RightMeters_mc.HUDHungerMeter_mc.addChild(hunger);
				
				topLevel.HUDNotificationsGroup_mc.Messages_mc.addChild(HUDNotification_mc);
				topLevel.RightMeters_mc.FlashLightWidget_mc.addChild(FlashLightRestored_mc);
				topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.addChild(showHealthText);
				
				HUDNotification_mc.y += 150;
				HUDNotification_mc.addFrameScript(0, frame1, 5, frame2, 15, frame3, 16, frame3, 170, frame4);
				HUDNotification_mc.gotoAndStop("Reset");
				
				hunger.x = 240;
				thirst.x = 240;
				
				Shared.AS3.Data.BSUIDataManager.Subscribe("HUDRightMetersData", onCharInfoUpd);
				BSUIDataManager.Subscribe("HUDModeData",this.onHudModeDataChange);

				
				init();
			}
			else if(topLevel != null && getQualifiedClassName(topLevel) == "MainMenu")
			{
				init();
			}
			else
			{
				
				displayText("Not injected into supported SWF. Current: " + getQualifiedClassName(topLevel));
			}
		}
		
		private function init():void
		{
			stage.addChild(debugTextHC);
			stage.addChild(watermark);
			xmlLoaderHC = new URLLoader();
			xmlLoaderHC.addEventListener(Event.COMPLETE, onFileLoad);
			loadConfig();
		}
		
		private function initDebugText():void
		{
			var debugTextHCShadow:DropShadowFilter = new DropShadowFilter(1, 45, 0x000000, 0.75, 4, 4, 1, BitmapFilterQuality.HIGH, false, false, false);
			debugTextHC = new TextField();
			var debugTextHCFormat:TextFormat = new TextFormat("$MAIN_Font_Light", 10, 0xF0F0F0); //color: 16777163
			debugTextHCFormat.align = "left";
			debugTextHC.defaultTextFormat = debugTextHCFormat;
			debugTextHC.setTextFormat(debugTextHCFormat);
			debugTextHC.multiline = true;
			debugTextHC.width = 1920;
			debugTextHC.height = 1080;
			debugTextHC.name = "debugTextHC";
			debugTextHC.text = "";
			debugTextHC.filters = [debugTextHCShadow];
			debugTextHC.visible = true;
		}
		
		private function initShowHealthText():void
		{
			var showHealthTextShadow:DropShadowFilter = new DropShadowFilter(2, 45, 0, 1, 0, 0, 1, 1);
			showHealthText = new TextField();
			showHealthText.setTextFormat(topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.DisplayText_tf.getTextFormat());
			showHealthText.defaultTextFormat = topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.DisplayText_tf.getTextFormat();
			showHealthText.width = 1920;
			showHealthText.height = 1080;
			showHealthText.name = "showHealthText";
			showHealthText.filters = [showHealthTextShadow];
			showHealthText.visible = true;
			showHealthText.text = "HEALTH TEXT ERROR";
			TextFieldEx.setTextAutoSize(showHealthText, TextFieldEx.TEXTAUTOSZ_SHRINK);
			showHealthText.autoSize = TextFieldAutoSize.CENTER;
			showHealthText.embedFonts = true;
			showHealthText.mouseEnabled = false;
		}
		
		private function initWatermarkText():void
		{
			var watermarkShadow:DropShadowFilter = new DropShadowFilter(1, 45, 0x000000, 0.75, 4, 4, 1, BitmapFilterQuality.HIGH, false, false, false);
			var watermarkFormat:TextFormat = new TextFormat("$Typewriter_Font", 18, 0xF0F0F0); //color: 16777163
			watermark = new TextField();
			watermarkFormat.align = "left";
			watermark.name = "watermark";
			watermark.defaultTextFormat = watermarkFormat;
			watermark.setTextFormat(watermarkFormat);
			watermark.filters = [watermarkShadow];
			watermark.autoSize = TextFieldAutoSize.LEFT;
			watermark.alpha = 0.65;
		}
		
		private function initThirstText():void
		{
			var thirstShadow:DropShadowFilter = new DropShadowFilter(1, 45, 0x000000, 0.9, 3, 3, 1, BitmapFilterQuality.HIGH, false, false, false);
			var thirstFormat:TextFormat = new TextFormat("$MAIN_Font_Bold", 20, 0xFFFFCB); //color: 16777163
			thirst = new TextField();
			thirstFormat.align = "center";
			thirst.name = "thirst";
			thirst.defaultTextFormat = thirstFormat;
			thirst.setTextFormat(thirstFormat);
			thirst.filters = [thirstShadow];
			thirst.autoSize = TextFieldAutoSize.CENTER;
		}
		
		private function initHungerText():void 
		{
			var hungerShadow:DropShadowFilter = new DropShadowFilter(1, 45, 0x000000, 0.9, 3, 3, 1, BitmapFilterQuality.HIGH, false, false, false);
			var hungerFormat:TextFormat = new TextFormat("$MAIN_Font_Bold", 20, 0xFFFFCB); //color: 16777163
			hunger = new TextField();
			hungerFormat.align = "center";
			hunger.name = "hunger";
			hunger.defaultTextFormat = hungerFormat;
			hunger.setTextFormat(hungerFormat);
			hunger.filters = [hungerShadow];
			hunger.autoSize = TextFieldAutoSize.CENTER;
		}
		

		private function loadConfig():void
		{
			try
			{
				xmlLoaderHC.load(new URLRequest("../HUDEditor.xml"));
				return;
			}
			catch (error:Error)
			{
				displayText("Error finding HUDEditor configuration file. " + error.message.toString());
				return;
			}
		}
		
		private function onFileLoad(e:Event):void
		{
			initCommands(e.target.data);
			updateTimerHC.addEventListener(TimerEvent.TIMER_COMPLETE, update);
			updateTimerHC.start();
			xmlLoaderHC.removeEventListener(Event.COMPLETE, onFileLoad);
		}
		
		
		private function onCharInfoUpd(_arg1:FromClientDataEvent):*
		{
			_CharInfo = _arg1.data;
		}
		
		private function findChildrenOf(mc:MovieClip):Array
		{
			var children:Array = new Array();
			for (var i:int = 0; i < mc.numChildren; i++)
			{
				children.push(mc.getChildAt(i));
			}
			return children;
		}


		
		private function update(event:TimerEvent):void
		{/*
			debugTextHC.text = "";
			
		   displayText("TopRightGroup_mc");
		   for (var debugi:int = 0; debugi < topLevel.TopRightGroup_mc.numChildren; debugi++ )
		   {
			   var child:DisplayObject = topLevel.TopRightGroup_mc.getChildAt(debugi);
			   displayText(debugi.toString() + " - " + child.name);
			   for (var debugii:int = 0; debugii < topLevel.TopRightGroup_mc.getChildAt(debugi).numChildren; debugii++ )
			   {
				   var child2:DisplayObject = topLevel.TopRightGroup_mc.getChildAt(debugi).getChildAt(debugii);
				   displayText("-  " + debugii.toString() + " - " + child2.name);
				   for (var debugiii:int = 0; debugiii < topLevel.TopRightGroup_mc.getChildAt(debugi).getChildAt(debugii).numChildren; debugiii++ )
				   {
						var child3:DisplayObject = topLevel.TopRightGroup_mc.getChildAt(debugi).getChildAt(debugii).getChildAt(debugiii);
						displayText("- -  " + debugiii.toString() + " - " + child3.name);
						for (var debugiiii:int = 0; debugiiii < topLevel.TopRightGroup_mc.getChildAt(debugi).getChildAt(debugii).getChildAt(debugiii).numChildren; debugiiii++ )
					   {
							var child4:DisplayObject = topLevel.TopRightGroup_mc.getChildAt(debugi).getChildAt(debugii).getChildAt(debugiii).getChildAt(debugiiii);
							displayText("- - -  " + debugiiii.toString() + " - " + child4.name);
							for (var debugiiiii:int = 0; debugiiiii < topLevel.TopRightGroup_mc.getChildAt(debugi).getChildAt(debugii).getChildAt(debugiii).getChildAt(debugiiii).numChildren; debugiiiii++ )
						   {
								var child5:DisplayObject = topLevel.TopRightGroup_mc.getChildAt(debugi).getChildAt(debugii).getChildAt(debugiii).getChildAt(debugiiii).getChildAt(debugiiiii);
								displayText("- - - -  " + debugiiiii.toString() + " - " + child5.name);
						   }
					   }
				   }
			   }
		   }
			*/
			/*
			debugTextHC.text = "";
			displayText("DEBUG MODE");
			displayText("----------");
			displayText("inPowerArmor: " + inPowerArmor.toString() + " powerArmorHUDEnabled: " + powerArmorHUDEnabled.toString());
			displayText("ThirstMeterPosPA.x: " + ThirstMeterPosPA.x.toString() + " ThirstMeterPosPA.y: " + ThirstMeterPosPA.y.toString());
			displayText("HungerMeterPosPA.x: " + HungerMeterPosPA.x.toString() + " HungerMeterPosPA.y: " + HungerMeterPosPA.y.toString());
			displayText("topLevel.RightMeters_mc.HUDThirstMeter_mc.x: " + topLevel.RightMeters_mc.HUDThirstMeter_mc.x.toString() + " HUDThirstMeter_mc.y: " + topLevel.RightMeters_mc.HUDThirstMeter_mc.y.toString());
			displayText("topLevel.RightMeters_mc.HUDHungerMeter_mc.x: " + topLevel.RightMeters_mc.HUDHungerMeter_mc.x.toString() + " HUDHungerMeter_mc.y: " + topLevel.RightMeters_mc.HUDHungerMeter_mc.y.toString());
			displayText("----------");
			
			
			for (var debugi:int = 0; debugi < topLevel.ReputationUpdates_mc.numChildren; debugi++ )
			{
				topLevel.ReputationUpdates_mc.getChildAt(debugi).visible = true;
				for (var debugii:int = 0; debugii < topLevel.ReputationUpdates_mc.getChildAt(debugi).numChildren; debugii++ )
				{
					topLevel.ReputationUpdates_mc.getChildAt(debugi).getChildAt(debugii).visible = true;
				}
			}
			*/
			
			//topLevel.LevelUpAnimation_mc.gotoAndStop(80);
			
				if (xmlConfigHC.Elements.LeftMeter.ShowHPLabel == "false")
					topLevel.LeftMeters_mc.HPMeter_mc.DisplayText_mc.DisplayText_tf.text = "";
				else if (xmlConfigHC.Elements.LeftMeter.ShowHPLabel == "true")
					topLevel.LeftMeters_mc.HPMeter_mc.DisplayText_mc.DisplayText_tf.text = "HP";
					
				if (xmlConfigHC.Elements.RightMeter.Parts.APMeter.ShowAPLabel == "false")
					topLevel.RightMeters_mc.ActionPointMeter_mc.DisplayText_mc.DisplayText_tf.text = "";
				else if (xmlConfigHC.Elements.RightMeter.Parts.APMeter.ShowAPLabel == "true")
					topLevel.RightMeters_mc.ActionPointMeter_mc.DisplayText_mc.DisplayText_tf.text = "AP";
					
				if (xmlConfigHC.Elements.LeftMeter.ShowBarBG == "false")
					topLevel.LeftMeters_mc.HPMeter_mc.getChildAt(0).visible = false;
				else if (xmlConfigHC.Elements.LeftMeter.ShowBarBG == "true")
					topLevel.LeftMeters_mc.HPMeter_mc.getChildAt(0).visible = true;
					
				if (xmlConfigHC.Elements.RightMeter.Parts.APMeter.ShowBarBG == "false")
					topLevel.RightMeters_mc.ActionPointMeter_mc.APBarFrame_mc.visible = false;
				else if (xmlConfigHC.Elements.RightMeter.Parts.APMeter.ShowBarBG == "true")
					topLevel.RightMeters_mc.ActionPointMeter_mc.APBarFrame_mc.visible = true;
					
				if (xmlConfigHC.Elements.LeftMeter.HPLabelSide == "left")
					topLevel.LeftMeters_mc.HPMeter_mc.DisplayText_mc.x = -45;
				else if (xmlConfigHC.Elements.LeftMeter.HPLabelSide == "right")
					topLevel.LeftMeters_mc.HPMeter_mc.DisplayText_mc.x = 325;
					
				if (xmlConfigHC.Elements.RightMeter.Parts.APMeter.APLabelSide == "left")
					topLevel.RightMeters_mc.ActionPointMeter_mc.DisplayText_mc.x = -321;
				else if (xmlConfigHC.Elements.RightMeter.Parts.APMeter.APLabelSide == "right")
					topLevel.RightMeters_mc.ActionPointMeter_mc.DisplayText_mc.x = 43;
			
			if (xmlConfigHC.dbg.e != undefined && xmlConfigHC.dbg.e == "191x7")
			{
				debugTextHC.text = "";
				displayText("DEBUG MODE");
				displayText("----------");
				displayText("reloadCount: " + reloadCount.toString());
				displayText("----------");
			}
			topLevel.BottomCenterGroup_mc.CompassWidget_mc.filters = [bccompassColorMatrix];
			
			this.ShowHealth(0);
			
			if (xmlConfigHC.Colors.HUD.TZMapMarkers == "true")
			{
				topLevel.BottomCenterGroup_mc.CompassWidget_mc.QuestMarkerHolder_mc.filters = [bccompassInvColorMatrix];
				for (var jj:int = 5; jj < topLevel.BottomCenterGroup_mc.CompassWidget_mc.OtherMarkerHolder_mc.numChildren; jj++ )
				{
					topLevel.BottomCenterGroup_mc.CompassWidget_mc.OtherMarkerHolder_mc.getChildAt(jj).filters = [bccompassInvColorMatrix];
				}
			}
			else if (xmlConfigHC.Colors.HUD.TZMapMarkers == "false")
			{
				topLevel.BottomCenterGroup_mc.CompassWidget_mc.QuestMarkerHolder_mc.filters = null;
				for (var jjj:int = 5; jjj < topLevel.BottomCenterGroup_mc.CompassWidget_mc.OtherMarkerHolder_mc.numChildren; jjj++ )
				{
					if (topLevel.BottomCenterGroup_mc.CompassWidget_mc.OtherMarkerHolder_mc.getChildAt(jjj).currentFrameLabel == "Enemy")
					{
						topLevel.BottomCenterGroup_mc.CompassWidget_mc.OtherMarkerHolder_mc.getChildAt(jjj).filters = [bccompassInvColorMatrix];
					}
					else
					{
						topLevel.BottomCenterGroup_mc.CompassWidget_mc.OtherMarkerHolder_mc.getChildAt(jjj).filters = null;
					}
				}
			}

			
			thpShow = xmlConfigHC.Colors.HUD.ThirstHungerPercentShow;
				
			if (xmlConfigHC.Colors.HUD.AlwaysShowThirstHunger == "true") 
			{
				topLevel.RightMeters_mc.HUDThirstMeter_mc.gotoAndStop(7);
				topLevel.RightMeters_mc.HUDHungerMeter_mc.gotoAndStop(7);
				VisibilityChanged = 1;
			}
			else if (xmlConfigHC.Colors.HUD.AlwaysShowThirstHunger == "false" && VisibilityChanged == 1)
			{
				topLevel.RightMeters_mc.HUDThirstMeter_mc.gotoAndStop("rollOff");
				topLevel.RightMeters_mc.HUDHungerMeter_mc.gotoAndStop("rollOff");
				VisibilityChanged = 0;
			}
			
			var linenum:*= 0;
			try
			{
				
				if (thpShow == "true")
				{
					linenum = 1;
					thirstPC = _CharInfo.thirstPercent;
					
					linenum = 2;
					hungerPC = _CharInfo.hungerPercent;
					
					linenum = 3;
					var thirstFinal:Number = GlobalFunc.Clamp(thirstPC,0,this.PercentMax) / this.PercentMax;
					
					linenum = 4;
					var hungerFinal:Number = GlobalFunc.Clamp(hungerPC,0,this.PercentMax) / this.PercentMax;
					
					linenum = 5;
					var thirTemp:Number = Math.round((Math.ceil(thirstPC * topLevel.RightMeters_mc.HUDThirstMeter_mc.Meter_mc.totalFrames) * 2) / 10);
					thirst.text = thirTemp.toString() + "%";
					
					linenum = 6;
					var hungTemp:Number = Math.round((Math.ceil(hungerPC * topLevel.RightMeters_mc.HUDHungerMeter_mc.Meter_mc.totalFrames) * 2) / 10);
					hunger.text = hungTemp.toString() + "%";
					
					linenum = 7;
					if (topLevel.RightMeters_mc.HUDThirstMeter_mc.currentFrame == 11)
					{
						thirst.visible = false;
					}
					
					linenum = 8;
					if (topLevel.RightMeters_mc.HUDHungerMeter_mc.currentFrame == 11)
					{
						hunger.visible = false;
					}
					
					linenum = 9;
					if (topLevel.RightMeters_mc.HUDThirstMeter_mc.currentFrame == 12)
					{
						thirst.visible = false;
					}
					
					linenum = 10;
					if (topLevel.RightMeters_mc.HUDHungerMeter_mc.currentFrame == 12)
					{
						hunger.visible = false;
					}
					
					linenum = 11;
					if (topLevel.RightMeters_mc.HUDThirstMeter_mc.currentFrame == 13)
					{
						thirst.visible = false;
					}
					
					linenum = 12;
					if (topLevel.RightMeters_mc.HUDHungerMeter_mc.currentFrame == 13)
					{
						hunger.visible = false;
					}
					
					linenum = 13;
					if (topLevel.RightMeters_mc.HUDThirstMeter_mc.currentFrame == 5)
					{
						thirst.visible = true;
					}
					
					linenum = 14;
					if (topLevel.RightMeters_mc.HUDHungerMeter_mc.currentFrame == 5)
					{
						hunger.visible = true;
					}
					
					linenum = 15;
					if (topLevel.RightMeters_mc.HUDThirstMeter_mc.currentFrame == 6)
					{
						thirst.visible = true;
					}
					
					linenum = 16;
					if (topLevel.RightMeters_mc.HUDHungerMeter_mc.currentFrame == 6)
					{
						hunger.visible = true;
					}
					
					linenum = 17;
					if (topLevel.RightMeters_mc.HUDThirstMeter_mc.currentFrame == 7)
					{
						thirst.visible = true;
					}
					
					linenum = 18;
					if (topLevel.RightMeters_mc.HUDHungerMeter_mc.currentFrame == 7)
					{
						hunger.visible = true;
					}
				}
				else if (thpShow == "false")
				{
					thirst.visible = false;
					hunger.visible = false;
					thirst.text = "";
					hunger.text = "";
				}
			}
			catch (e:Error)
			{
				if (e.toString() != "TypeError: Error #1009")
					displayText("XML problem (resourcemeters): " + e.toString() + "," + linenum);
			}


			if (xmlConfigHC.Colors.HUD.EnableRecoloring == "true")
			{
				for (var ii:int = 0; ii < topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.numChildren; ii++)
				{
					if (topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(2).currentFrame == 50)
					{
						topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(0).filters = [rightmetersInvColorMatrix];
						topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(1).filters = [rightmetersInvColorMatrix];
					}
					else if (topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(2).currentFrame == 2)
					{
						topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(0).filters = [rightmetersInvColorMatrix];
						topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(1).filters = [rightmetersInvColorMatrix];
					}
					else if (topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(2).currentFrame == 43)
					{
						topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(0).filters = [rightmetersInvColorMatrix];
						topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(1).filters = [rightmetersInvColorMatrix];
					}
					else if (topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(2).currentFrame == 66)
					{
						topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(0).filters = [rightmetersInvColorMatrix];
						topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(1).filters = [rightmetersInvColorMatrix];
					}
					else
					{
						topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(0).filters = null;
						topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(1).filters = null;
					}
				}
				
				if (topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.currentFrame < 5)
				{
					topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.OwnerInfo_mc.AccountIcon_mc.filters = null;
					topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.filters = [sneakDangerColorMatrix];
				}
				else if (topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.currentFrame > 5)
				{
					topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.OwnerInfo_mc.AccountIcon_mc.filters = [sneakDangerColorMatrix];
					topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.filters = null;
				}
				
				
				if (topLevel.TopCenterGroup_mc.getChildAt(0).getChildAt(0).getChildAt(0).getChildAt(0).getChildAt(0).text == "CAUTION"
				|| topLevel.TopCenterGroup_mc.getChildAt(0).getChildAt(0).getChildAt(0).getChildAt(0).getChildAt(0).text == "DANGER")
				{
					topLevel.TopCenterGroup_mc.getChildAt(0).filters = [sneakDangerColorMatrix];
				}
				else if (topLevel.TopCenterGroup_mc.getChildAt(0).getChildAt(0).getChildAt(0).getChildAt(0).getChildAt(0).text == "HIDDEN"
				|| topLevel.TopCenterGroup_mc.getChildAt(0).getChildAt(0).getChildAt(0).getChildAt(0).getChildAt(0).text == "DETECTED")
				{
					topLevel.TopCenterGroup_mc.getChildAt(0).filters = null;
				}

				//Team Panel
				teamNum = topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).numChildren;

				if (teamNum == 1)
				{
					topLevel.PartyResolutionContainer_mc.filters = [teamColorMatrix];
					topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(0).textColor = 0xF5CB5B;
					topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(1).textColor = 0xF5CB5B;
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(9).filters = [teamradsColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(3).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(7).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(15).filters = [teamInvColorMatrix];
				}
				else if (teamNum == 2)
				{
					topLevel.PartyResolutionContainer_mc.filters = [teamColorMatrix];
					topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(0).textColor = 0xF5CB5B;
					topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(1).textColor = 0xF5CB5B;
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(9).filters = [teamradsColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(3).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(7).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(15).filters = [teamInvColorMatrix];
					
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(9).filters = [teamradsColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(3).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(7).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(15).filters = [teamInvColorMatrix];
				}
				else if (teamNum == 3)
				{
					topLevel.PartyResolutionContainer_mc.filters = [teamColorMatrix];
					topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(0).textColor = 0xF5CB5B;
					topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(1).textColor = 0xF5CB5B;
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(9).filters = [teamradsColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(3).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(7).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(15).filters = [teamInvColorMatrix];
					
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(9).filters = [teamradsColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(3).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(7).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(15).filters = [teamInvColorMatrix];
					
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(9).filters = [teamradsColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(3).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(7).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(15).filters = [teamInvColorMatrix];
				}
				else if (teamNum == 4)
				{
					topLevel.PartyResolutionContainer_mc.filters = [teamColorMatrix];
					topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(0).textColor = 0xF5CB5B;
					topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(1).textColor = 0xF5CB5B;
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(9).filters = [teamradsColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(3).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(7).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(15).filters = [teamInvColorMatrix];
					
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(9).filters = [teamradsColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(3).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(7).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(15).filters = [teamInvColorMatrix];
					
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(9).filters = [teamradsColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(3).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(7).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(15).filters = [teamInvColorMatrix];
					
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(3).getChildAt(9).filters = [teamradsColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(3).getChildAt(3).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(3).getChildAt(7).filters = [teamInvColorMatrix];
					topLevel.getChildAt(17).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(3).getChildAt(15).filters = [teamInvColorMatrix];
				}
				else
				{
					//do nothing here, fixes performance issues relating to no team panel showing
				}
				
				topLevel.TeammateMarkerBase.filters = [floatingColorMatrix];
				if (topLevel.TeammateMarkerBase.numChildren > 1)
				{
					for (var i:int = 1; i < topLevel.TeammateMarkerBase.numChildren; i++)
					{
						topLevel.TeammateMarkerBase.getChildAt(i).getChildAt(3).filters = [floatingInvColorMatrix];
					}
				}
			}
			if (xmlConfigHC.Elements != undefined)
			{
				if (inPowerArmor == true && powerArmorHUDEnabled == true)
				{
					topLevel.RightMeters_mc.HUDHungerMeter_mc.x = (oHungerMeterPos.x + HungerMeterPosPA.x);
					topLevel.RightMeters_mc.HUDHungerMeter_mc.y = (oHungerMeterPos.y + HungerMeterPosPA.y);

					topLevel.RightMeters_mc.HUDThirstMeter_mc.x = (oThirstMeterPos.x + ThirstMeterPosPA.x);
					topLevel.RightMeters_mc.HUDThirstMeter_mc.y = (oThirstMeterPos.y + ThirstMeterPosPA.y);
					
					topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.x = (oExplosiveAmmoCountPos.x + ExplosiveAmmoCountPosPA.x);
					topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.y = (oExplosiveAmmoCountPos.y + ExplosiveAmmoCountPosPA.y);
					
					topLevel.getChildAt(17).x = (oTeamPanelPos.x + TeamPanelPosPA.x);
					topLevel.getChildAt(17).y = (oTeamPanelPos.y + TeamPanelPosPA.y);
				}
				else
				{
					topLevel.RightMeters_mc.HUDHungerMeter_mc.x = (oHungerMeterPos.x + HungerMeterPos.x);
					topLevel.RightMeters_mc.HUDHungerMeter_mc.y = (oHungerMeterPos.y + HungerMeterPos.y);

					topLevel.RightMeters_mc.HUDThirstMeter_mc.x = (oThirstMeterPos.x + ThirstMeterPos.x);
					topLevel.RightMeters_mc.HUDThirstMeter_mc.y = (oThirstMeterPos.y + ThirstMeterPos.y);
					
					topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.x = (oExplosiveAmmoCountPos.x + ExplosiveAmmoCountPos.x);
					topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.y = (oExplosiveAmmoCountPos.y + ExplosiveAmmoCountPos.y);
					
					topLevel.getChildAt(17).x = (oTeamPanelPos.x + TeamPanelPos.x);
					topLevel.getChildAt(17).y = (oTeamPanelPos.y + TeamPanelPos.y);
				}
				
				if (inPowerArmor == true && powerArmorHUDEnabled == true)
				{
					if (HungerMeterScalePA <= maxScale)
					{
						topLevel.RightMeters_mc.HUDHungerMeter_mc.scaleX = HungerMeterScalePA;
						topLevel.RightMeters_mc.HUDHungerMeter_mc.scaleY = HungerMeterScalePA;
					}
					else
					{
						topLevel.RightMeters_mc.HUDHungerMeter_mc.scaleX = 1;
						topLevel.RightMeters_mc.HUDHungerMeter_mc.scaleY = 1;
					}
					
					if (ThirstMeterScalePA <= maxScale)
					{
						topLevel.RightMeters_mc.HUDThirstMeter_mc.scaleX = ThirstMeterScalePA;
						topLevel.RightMeters_mc.HUDThirstMeter_mc.scaleY = ThirstMeterScalePA;
					}
					else
					{
						topLevel.RightMeters_mc.HUDThirstMeter_mc.scaleX = 1;
						topLevel.RightMeters_mc.HUDThirstMeter_mc.scaleY = 1;
					}
					
					if (ExplosiveAmmoCountScalePA <= maxScale)
					{
						topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.scaleX = ExplosiveAmmoCountScalePA;
						topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.scaleY = ExplosiveAmmoCountScalePA;
					}
					else
					{
						topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.scaleX = 1;
						topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.scaleY = 1;
					}
					
					if (TeamPanelScalePA <= maxScale)
					{
						topLevel.getChildAt(17).scaleX = TeamPanelScalePA;
						topLevel.getChildAt(17).scaleY = TeamPanelScalePA;
					}
					else
					{
						topLevel.getChildAt(17).scaleX = 1;
						topLevel.getChildAt(17).scaleY = 1;
					}
				}
				else
				{
					if (HungerMeterScale <= maxScale)
					{
						topLevel.RightMeters_mc.HUDHungerMeter_mc.scaleX = HungerMeterScale;
						topLevel.RightMeters_mc.HUDHungerMeter_mc.scaleY = HungerMeterScale;
					}
					else
					{
						topLevel.RightMeters_mc.HUDHungerMeter_mc.scaleX = 1;
						topLevel.RightMeters_mc.HUDHungerMeter_mc.scaleY = 1;
					}
					
					if (ThirstMeterScale <= maxScale)
					{
						topLevel.RightMeters_mc.HUDThirstMeter_mc.scaleX = ThirstMeterScale;
						topLevel.RightMeters_mc.HUDThirstMeter_mc.scaleY = ThirstMeterScale;
					}
					else
					{
						topLevel.RightMeters_mc.HUDThirstMeter_mc.scaleX = 1;
						topLevel.RightMeters_mc.HUDThirstMeter_mc.scaleY = 1;
					}
					
					if (ExplosiveAmmoCountScale <= maxScale)
					{
						topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.scaleX = ExplosiveAmmoCountScale;
						topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.scaleY = ExplosiveAmmoCountScale;
					}
					else
					{
						topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.scaleX = 1;
						topLevel.RightMeters_mc.ExplosiveAmmoCount_mc.scaleY = 1;
					}
					
					if (TeamPanelScale <= maxScale)
					{
						topLevel.getChildAt(17).scaleX = TeamPanelScale;
						topLevel.getChildAt(17).scaleY = TeamPanelScale;
					}
					else
					{
						topLevel.getChildAt(17).scaleX = 1;
						topLevel.getChildAt(17).scaleY = 1;
					}
					
				}
				
				//Sneak
				topLevel.TopCenterGroup_mc.getChildAt(0).x = (oSneakPos.x + SneakMeterPos.x);
				topLevel.TopCenterGroup_mc.getChildAt(0).y = (oSneakPos.y + SneakMeterPos.y);
				
				//LeftMeter
				topLevel.LeftMeters_mc.x = (oLeftMeterPos.x + LeftMeterPos.x);
				topLevel.LeftMeters_mc.y = (oLeftMeterPos.y + LeftMeterPos.y);
				

					
				//RightMeters

				topLevel.RightMeters_mc.ActionPointMeter_mc.x = (oAPMeterPos.x + APMeterPos.x);
				topLevel.RightMeters_mc.ActionPointMeter_mc.y = (oAPMeterPos.y + APMeterPos.y);

				topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.x = (oActiveEffectsPos.x + ActiveEffectsPos.x);
				topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.y = (oActiveEffectsPos.y + ActiveEffectsPos.y);

				topLevel.RightMeters_mc.AmmoCount_mc.x = (oAmmoCountPos.x + AmmoCountPos.x);
				topLevel.RightMeters_mc.AmmoCount_mc.y = (oAmmoCountPos.y + AmmoCountPos.y);

				topLevel.RightMeters_mc.FlashLightWidget_mc.x = (oFlashLightWidgetPos.x + FlashLightWidgetPos.x);
				topLevel.RightMeters_mc.FlashLightWidget_mc.y = (oFlashLightWidgetPos.y + FlashLightWidgetPos.y);

				topLevel.RightMeters_mc.LocalEmote_mc.x = (oEmotePos.x + EmotePos.x);
				topLevel.RightMeters_mc.LocalEmote_mc.y = (oEmotePos.y + EmotePos.y);
				
				topLevel.LevelUpAnimation_mc.x = (oLevelUpAnimPos.x + LevelUpAnimPos.x);
				topLevel.LevelUpAnimation_mc.y = (oLevelUpAnimPos.y + LevelUpAnimPos.y);
				
				topLevel.ReputationUpdates_mc.x = (oRepUpdatesPos.x + RepUpdatesPos.x);
				topLevel.ReputationUpdates_mc.y = (oRepUpdatesPos.y + RepUpdatesPos.y);
				
				topLevel.CenterGroup_mc.HitIndicator_mc.x = (oHitMarkerPos.x + HitMarkerPos.x);
				topLevel.CenterGroup_mc.HitIndicator_mc.y = (oHitMarkerPos.y + HitMarkerPos.y);
				
				//QuickLoot
				var tfTemp:* = topLevel.CenterGroup_mc.QuickContainerWidget_mc.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf.getTextFormat();
				if (tfTemp.align == "left")
				{
					topLevel.CenterGroup_mc.QuickContainerWidget_mc.x = (oQuickLootPos.x + QuickLootPos.x);
					topLevel.CenterGroup_mc.QuickContainerWidget_mc.y = (oQuickLootPos.y + QuickLootPos.y);
				}
				else if (tfTemp.align == "center")
				{
					topLevel.CenterGroup_mc.QuickContainerWidget_mc.x = ((oQuickLootPos.x - 50) + QuickLootPos.x);
					topLevel.CenterGroup_mc.QuickContainerWidget_mc.y = ((oQuickLootPos.y - 100) + QuickLootPos.y);
				}
				
				topLevel.FrobberWidget_mc.x = (oFrobberPos.x + FrobberPos.x);
				topLevel.FrobberWidget_mc.y = (oFrobberPos.y + FrobberPos.y);
				
				topLevel.CenterGroup_mc.RolloverWidget_mc.x = (oRollOverPos.x + RollOverPos.x);
				topLevel.CenterGroup_mc.RolloverWidget_mc.y = (oRollOverPos.y + RollOverPos.y);
				
				//Compass
				topLevel.BottomCenterGroup_mc.CompassWidget_mc.x = (oCompassPos.x + CompassPos.x);
				topLevel.BottomCenterGroup_mc.CompassWidget_mc.y = (oCompassPos.y + CompassPos.y);
				
				//Announce
				topLevel.AnnounceEventWidget_mc.x = (oAnnouncePos.x + AnnouncePos.x);
				topLevel.AnnounceEventWidget_mc.y = (oAnnouncePos.y + AnnouncePos.y);
				
				//Notification
				topLevel.HUDNotificationsGroup_mc.Messages_mc.x = (oNotificationPos.x + NotificationPos.x);
				topLevel.HUDNotificationsGroup_mc.Messages_mc.y = (oNotificationPos.y + NotificationPos.y);
				
				topLevel.HUDNotificationsGroup_mc.CurrencyUpdates_mc.x = (oCurrencyPos.x + CurrencyPos.x);
				topLevel.HUDNotificationsGroup_mc.CurrencyUpdates_mc.y = (oCurrencyPos.y + CurrencyPos.y);
				
				//topRightQuest
				topLevel.TopRightGroup_mc.NewQuestTracker_mc.x = (oQuestPos.x + QuestPos.x);
				topLevel.TopRightGroup_mc.NewQuestTracker_mc.y = (oQuestPos.y + QuestPos.y);
				
				//Fusion Core Meter (part of HUDRightMeters for some ungodly reason)
				topLevel.RightMeters_mc.HUDFusionCoreMeter_mc.x = (oFusionPos.x + FusionPos.x);
				topLevel.RightMeters_mc.HUDFusionCoreMeter_mc.y = (oFusionPos.y + FusionPos.y);
				
				topLevel.BottomCenterGroup_mc.SubtitleText_mc.x = (oSubtitlePos.x + SubtitlesPos.x);
				topLevel.BottomCenterGroup_mc.SubtitleText_mc.y = (oSubtitlePos.y + SubtitlesPos.y);
				
				topLevel.HUDNotificationsGroup_mc.XPMeter_mc.x = (oXPBarPos.x + XPBarPos.x);
				topLevel.HUDNotificationsGroup_mc.XPMeter_mc.y = (oXPBarPos.y + XPBarPos.y);
				
				topLevel.BottomCenterGroup_mc.CritMeter_mc.x = (oCritMeterPos.x + CritMeterPos.x);
				topLevel.BottomCenterGroup_mc.CritMeter_mc.y = (oCritMeterPos.y + CritMeterPos.y);
				
				topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.x = (oEnemyHealthPos.x + EnemyHealthPos.x);
				topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.y = (oEnemyHealthPos.y + EnemyHealthPos.y);
			}
				
			if (xmlConfigHC.Colors.HUD.EditMode != undefined)
			{
				watermark.x = stage.stageWidth - (watermark.width + 4);
				watermark.y = 0;
				var color1:* = "0x" + rightmetersRGB1;
				watermark.textColor = color1;
				if (xmlConfigHC.Colors.HUD.EditMode == "true" && reloadCount == 150)
				{
					reloadXML();
					watermark.visible = true;
					CONFIG::debug
					{
						watermark.text = "HUDEditor ***BETA*** EDIT MODE";
					}
					CONFIG::release
					{
						watermark.text = "HUDEditor v2.6.1.5 EDIT MODE";
					}
				}
				else if (xmlConfigHC.Colors.HUD.EditMode == "false")
				{
					CONFIG::debug
					{
						watermark.visible = true;
						watermark.text = "HUDEditor ***BETA*** TEST BUILD";
						watermark.alpha = 0.30;
						reloadCount = 0;
					}
					CONFIG::release
					{
						watermark.visible = false;
						watermark.text = "";
						watermark.alpha = 0;
						reloadCount = 0;
					}
				}
				else
				{
					reloadCount++;
				}
			}
			
		}
		
		private function initCommands(wholeFileStr:String):void
		{
			//Read the whole configuration string and assign values to our actionscript variables
			XML.ignoreComments = true;
			xmlConfigHC = new XML(wholeFileStr);
			
			rightmetersBrightness = Number(xmlConfigHC.Colors.RightMeters.Brightness);
			rightmetersContrast = Number(xmlConfigHC.Colors.RightMeters.Contrast);
			rightmetersSaturation = Number(xmlConfigHC.Colors.RightMeters.Saturation);
			rightmetersRGB1 = xmlConfigHC.Colors.RightMeters.RGB;
			
			leftmetersBrightness = Number(xmlConfigHC.Colors.LeftMeters.Brightness);
			leftmetersContrast = Number(xmlConfigHC.Colors.LeftMeters.Contrast);
			leftmetersSaturation = Number(xmlConfigHC.Colors.LeftMeters.Saturation);
			leftmetersRGB1 = xmlConfigHC.Colors.LeftMeters.RGB;
			
			radsbarBrightness = Number(xmlConfigHC.Colors.LeftMeters.RadsBarBrightness);
			radsbarContrast = Number(xmlConfigHC.Colors.LeftMeters.RadsBarContrast);
			radsbarSaturation = Number(xmlConfigHC.Colors.LeftMeters.RadsBarSaturation);
			radsbarRGB = xmlConfigHC.Colors.LeftMeters.RadsBarRGB;
			
			notiBrightness = Number(xmlConfigHC.Colors.Noti.Brightness);
			notiContrast = Number(xmlConfigHC.Colors.Noti.Contrast);
			notiSaturation = Number(xmlConfigHC.Colors.Noti.Saturation);
			notiRGB1 = xmlConfigHC.Colors.Noti.RGB;
			
			frobberBrightness = Number(xmlConfigHC.Colors.HudFrobber.Brightness);
			frobberContrast = Number(xmlConfigHC.Colors.HudFrobber.Contrast);
			frobberSaturation = Number(xmlConfigHC.Colors.HudFrobber.Saturation);
			frobberRGB1 = xmlConfigHC.Colors.HudFrobber.RGB;
			
			trackerBrightness = Number(xmlConfigHC.Colors.QuestTracker.Brightness);
			trackerContrast = Number(xmlConfigHC.Colors.QuestTracker.Contrast);
			trackerSaturation = Number(xmlConfigHC.Colors.QuestTracker.Saturation);
			trackerRGB1 = xmlConfigHC.Colors.QuestTracker.RGB;
			
			topcenterBrightness = Number(xmlConfigHC.Colors.TopCenter.Brightness);
			topcenterContrast = Number(xmlConfigHC.Colors.TopCenter.Contrast);
			topcenterSaturation = Number(xmlConfigHC.Colors.TopCenter.Saturation);
			topcenterRGB1 = xmlConfigHC.Colors.TopCenter.RGB;
			
			bottomcenterBrightness = Number(xmlConfigHC.Colors.BottomCenter.Brightness);
			bottomcenterContrast = Number(xmlConfigHC.Colors.BottomCenter.Contrast);
			bottomcenterSaturation = Number(xmlConfigHC.Colors.BottomCenter.Saturation);
			bottomcenterRGB1 = xmlConfigHC.Colors.BottomCenter.RGB;
			
			if (xmlConfigHC.Colors.BottomCenter.CompassRGB != undefined)
			{
				bccompassBrightness = Number(xmlConfigHC.Colors.BottomCenter.CompassBrightness);
				bccompassContrast = Number(xmlConfigHC.Colors.BottomCenter.CompassContrast);
				bccompassSaturation = Number(xmlConfigHC.Colors.BottomCenter.CompassSaturation);
				bccompassRGB1 = xmlConfigHC.Colors.BottomCenter.CompassRGB;
			}
			else
			{
				bccompassBrightness = Number(xmlConfigHC.Colors.BottomCenter.Brightness);
				bccompassContrast = Number(xmlConfigHC.Colors.BottomCenter.Contrast);
				bccompassSaturation = Number(xmlConfigHC.Colors.BottomCenter.Saturation);
				bccompassRGB1 = xmlConfigHC.Colors.BottomCenter.RGB;
			}
			
			announceBrightness = Number(xmlConfigHC.Colors.Announce.Brightness);
			announceContrast = Number(xmlConfigHC.Colors.Announce.Contrast);
			announceSaturation = Number(xmlConfigHC.Colors.Announce.Saturation);
			announceRGB1 = xmlConfigHC.Colors.Announce.RGB;
			
			centerBrightness = Number(xmlConfigHC.Colors.Center.Brightness);
			centerContrast = Number(xmlConfigHC.Colors.Center.Contrast);
			centerSaturation = Number(xmlConfigHC.Colors.Center.Saturation);
			centerRGB1 = xmlConfigHC.Colors.Center.RGB;
			
			teamBrightness = Number(xmlConfigHC.Colors.Team.Brightness);
			teamContrast = Number(xmlConfigHC.Colors.Team.Contrast);
			teamSaturation = Number(xmlConfigHC.Colors.Team.Saturation);
			teamRGB1 = xmlConfigHC.Colors.Team.RGB;
			teamRadsBrightness = Number(xmlConfigHC.Colors.Team.RadsBarBrightness);
			teamRadsContrast = Number(xmlConfigHC.Colors.Team.RadsBarContrast);
			teamRadsSaturation = Number(xmlConfigHC.Colors.Team.RadsBarSaturation);
			teamRadsRGB = xmlConfigHC.Colors.Team.RadsBarRGB;
			

			teamRGB1 = xmlConfigHC.Colors.Team.RGB;
			teamRadsRGB = xmlConfigHC.Colors.Team.RadsBarRGB;
			
			floatingBrightness = Number(xmlConfigHC.Colors.Floating.Brightness);
			floatingContrast = Number(xmlConfigHC.Colors.Floating.Contrast);
			floatingSaturation = Number(xmlConfigHC.Colors.Floating.Saturation);
			floatingRGB1 = xmlConfigHC.Colors.Floating.RGB;
			
			hmBrightness = Number(xmlConfigHC.Colors.HitMarkerTint.Brightness);
			hmContrast = Number(xmlConfigHC.Colors.HitMarkerTint.Contrast);
			hmSaturation = Number(xmlConfigHC.Colors.HitMarkerTint.Saturation);
			hudRGBHM = xmlConfigHC.Colors.HitMarkerTint.RGB;
			
			hudHUErightmeters = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.RightMeters.RGB))[0];
			hudHUEleftmeters = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.LeftMeters.RGB))[0];
			hudHUEnoti = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.Notifications.RGB))[0];
			hudHUEfrobber = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.HudFrobber.RGB))[0];
			hudHUEtracker = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.QuestTracker.RGB))[0];
			hudHUEtopcenter = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.TopCenter.RGB))[0];
			hudHUEbottomcenter = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.BottomCenter.RGB))[0];
			
			hudHUEbccompass = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.BottomCenter.CompassRGB))[0];
			
			hudHUEannounce = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.AnnounceAvailable.RGB))[0];
			hudHUEcenter = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.Center.RGB))[0];
			hudHUEteam = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.Team.RGB))[0];
			hudHUEfloating = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.Floating.RGB))[0];
			hudHUEteamrads = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.Team.RadsBarRGB))[0];
			hudHUEradsbar = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.LeftMeters.RadsBarRGB))[0];
			hudHUEHM = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.HitMarkerTint.RGB))[0];
			
			///////////////////////////
			// Positions and scaling //
			///////////////////////////
			if (xmlConfigHC.Elements != undefined)
			{
				//SneakMeter
				SneakMeterScale = xmlConfigHC.Elements.StealthMeter.Scale;
				SneakMeterPos.x = xmlConfigHC.Elements.StealthMeter.X;
				SneakMeterPos.y = xmlConfigHC.Elements.StealthMeter.Y;
				
				//QuestTracker
				QuestScale = xmlConfigHC.Elements.QuestTracker.Scale;
				QuestPos.x = xmlConfigHC.Elements.QuestTracker.X;
				QuestPos.y = xmlConfigHC.Elements.QuestTracker.Y;
				
				//LeftMeter
				LeftMeterScale = xmlConfigHC.Elements.LeftMeter.Scale;
				LeftMeterPos.x = xmlConfigHC.Elements.LeftMeter.X;
				LeftMeterPos.y = xmlConfigHC.Elements.LeftMeter.Y;
				
				//RightMeter
				
				APMeterScale = xmlConfigHC.Elements.RightMeter.Parts.APMeter.Scale;
				APMeterPos.x = xmlConfigHC.Elements.RightMeter.Parts.APMeter.X;
				APMeterPos.y = xmlConfigHC.Elements.RightMeter.Parts.APMeter.Y;
				
				ActiveEffectsScale = xmlConfigHC.Elements.RightMeter.Parts.ActiveEffects.Scale;
				ActiveEffectsPos.x = xmlConfigHC.Elements.RightMeter.Parts.ActiveEffects.X;
				ActiveEffectsPos.y = xmlConfigHC.Elements.RightMeter.Parts.ActiveEffects.Y;
				
				HungerMeterScale = xmlConfigHC.Elements.RightMeter.Parts.HungerMeter.Scale;
				HungerMeterPos.x = xmlConfigHC.Elements.RightMeter.Parts.HungerMeter.X;
				HungerMeterPos.y = xmlConfigHC.Elements.RightMeter.Parts.HungerMeter.Y;
				
				ThirstMeterScale = xmlConfigHC.Elements.RightMeter.Parts.ThirstMeter.Scale;
				ThirstMeterPos.x = xmlConfigHC.Elements.RightMeter.Parts.ThirstMeter.X;
				ThirstMeterPos.y = xmlConfigHC.Elements.RightMeter.Parts.ThirstMeter.Y;
				
				HungerMeterPosPA.x = xmlConfigHC.Elements.RightMeter.Parts.HungerMeter.PowerArmor.X;
				HungerMeterPosPA.y = xmlConfigHC.Elements.RightMeter.Parts.HungerMeter.PowerArmor.Y;
				
				ThirstMeterPosPA.x = xmlConfigHC.Elements.RightMeter.Parts.ThirstMeter.PowerArmor.X;
				ThirstMeterPosPA.y = xmlConfigHC.Elements.RightMeter.Parts.ThirstMeter.PowerArmor.Y;
				
				ExplosiveAmmoCountPosPA.x = xmlConfigHC.Elements.RightMeter.Parts.ExplosiveAmmoCount.PowerArmor.X;
				ExplosiveAmmoCountPosPA.y = xmlConfigHC.Elements.RightMeter.Parts.ExplosiveAmmoCount.PowerArmor.Y;
				
				TeamPanelPosPA.x = xmlConfigHC.Elements.TeamPanel.PowerArmor.X;
				TeamPanelPosPA.y = xmlConfigHC.Elements.TeamPanel.PowerArmor.Y;
				
				HungerMeterScalePA = xmlConfigHC.Elements.RightMeter.Parts.HungerMeter.PowerArmor.Scale;
				
				ThirstMeterScalePA = xmlConfigHC.Elements.RightMeter.Parts.ThirstMeter.PowerArmor.Scale;
				
				ExplosiveAmmoCountScalePA = xmlConfigHC.Elements.RightMeter.Parts.ExplosiveAmmoCount.PowerArmor.Scale;
				
				TeamPanelScalePA = xmlConfigHC.Elements.TeamPanel.PowerArmor.Scale;
				
				AmmoCountScale = xmlConfigHC.Elements.RightMeter.Parts.AmmoCount.Scale;
				AmmoCountPos.x = xmlConfigHC.Elements.RightMeter.Parts.AmmoCount.X;
				AmmoCountPos.y = xmlConfigHC.Elements.RightMeter.Parts.AmmoCount.Y;
				
				ExplosiveAmmoCountScale = xmlConfigHC.Elements.RightMeter.Parts.ExplosiveAmmoCount.Scale;
				ExplosiveAmmoCountPos.x = xmlConfigHC.Elements.RightMeter.Parts.ExplosiveAmmoCount.X;
				ExplosiveAmmoCountPos.y = xmlConfigHC.Elements.RightMeter.Parts.ExplosiveAmmoCount.Y;
				
				FlashLightWidgetScale = xmlConfigHC.Elements.RightMeter.Parts.FlashLightWidget.Scale;
				FlashLightWidgetPos.x = xmlConfigHC.Elements.RightMeter.Parts.FlashLightWidget.X;
				FlashLightWidgetPos.y = xmlConfigHC.Elements.RightMeter.Parts.FlashLightWidget.Y;
				
				EmoteScale = xmlConfigHC.Elements.RightMeter.Parts.Emote.Scale;
				EmotePos.x = xmlConfigHC.Elements.RightMeter.Parts.Emote.X;
				EmotePos.y = xmlConfigHC.Elements.RightMeter.Parts.Emote.Y;
				
				//Announce
				AnnounceScale = xmlConfigHC.Elements.Announce.Scale;
				AnnouncePos.x = xmlConfigHC.Elements.Announce.X;
				AnnouncePos.y = xmlConfigHC.Elements.Announce.Y;
				
				HitMarkerScale = xmlConfigHC.Elements.HitMarker.Scale;
				HitMarkerPos.x = xmlConfigHC.Elements.HitMarker.X;
				HitMarkerPos.y = xmlConfigHC.Elements.HitMarker.Y;
				
				//Compass
				CompassScale = xmlConfigHC.Elements.Compass.Scale;
				CompassPos.x = xmlConfigHC.Elements.Compass.X;
				CompassPos.y = xmlConfigHC.Elements.Compass.Y;
				
				//Notification
				NotificationScale = xmlConfigHC.Elements.Notification.Scale;
				NotificationPos.x = xmlConfigHC.Elements.Notification.X;
				NotificationPos.y = xmlConfigHC.Elements.Notification.Y;
				
				//QuickLoot
				QuickLootScale = xmlConfigHC.Elements.QuickLoot.Scale;
				QuickLootPos.x = xmlConfigHC.Elements.QuickLoot.X;
				QuickLootPos.y = xmlConfigHC.Elements.QuickLoot.Y;
				
				TeamPanelScale = xmlConfigHC.Elements.TeamPanel.Scale;
				TeamPanelPos.x = xmlConfigHC.Elements.TeamPanel.X;
				TeamPanelPos.y = xmlConfigHC.Elements.TeamPanel.Y;
				
				FusionScale = xmlConfigHC.Elements.FusionCoreMeter.Scale;
				FusionPos.x = xmlConfigHC.Elements.FusionCoreMeter.X;
				FusionPos.y = xmlConfigHC.Elements.FusionCoreMeter.Y;
				
				FrobberScale = xmlConfigHC.Elements.Frobber.Scale;
				FrobberPos.x = xmlConfigHC.Elements.Frobber.X;
				FrobberPos.y = xmlConfigHC.Elements.Frobber.Y;
				
				RollOverScale = xmlConfigHC.Elements.RollOver.Scale;
				RollOverPos.x = xmlConfigHC.Elements.RollOver.X;
				RollOverPos.y = xmlConfigHC.Elements.RollOver.Y;
				
				RepUpdatesScale = xmlConfigHC.Elements.ReputationUpdates.Scale;
				RepUpdatesPos.x = xmlConfigHC.Elements.ReputationUpdates.X;
				RepUpdatesPos.y = xmlConfigHC.Elements.ReputationUpdates.Y;
				
				LevelUpAnimScale = xmlConfigHC.Elements.LevelUpAnimation.Scale;
				LevelUpAnimPos.x = xmlConfigHC.Elements.LevelUpAnimation.X;
				LevelUpAnimPos.y = xmlConfigHC.Elements.LevelUpAnimation.Y;
				
				if (xmlConfigHC.Elements.Subtitles.Scale != undefined)
					SubtitlesScale = xmlConfigHC.Elements.Subtitles.Scale;
					
				if (xmlConfigHC.Elements.Subtitles.X != undefined)
					SubtitlesPos.x = xmlConfigHC.Elements.Subtitles.X;
				else
					SubtitlesPos.x = 0;
					
				if (xmlConfigHC.Elements.Subtitles.Y != undefined)
					SubtitlesPos.y = xmlConfigHC.Elements.Subtitles.Y;
				else
					SubtitlesPos.y = 0;
					
				if (xmlConfigHC.Elements.XPBar.Scale != undefined)
					XPBarScale = xmlConfigHC.Elements.XPBar.Scale;
					
				if (xmlConfigHC.Elements.XPBar.X != undefined)
					XPBarPos.x = xmlConfigHC.Elements.XPBar.X;
				else
					XPBarPos.x = 0;
					
				if (xmlConfigHC.Elements.XPBar.Y != undefined)
					XPBarPos.y = xmlConfigHC.Elements.XPBar.Y;
				else
					XPBarPos.y = 0;
					
				if (xmlConfigHC.Elements.CritMeter.Scale != undefined)
					CritMeterScale = xmlConfigHC.Elements.CritMeter.Scale;
					
				if (xmlConfigHC.Elements.CritMeter.X != undefined)
					CritMeterPos.x = xmlConfigHC.Elements.CritMeter.X;
				else
					CritMeterPos.x = 0;
					
				if (xmlConfigHC.Elements.CritMeter.Y != undefined)
					CritMeterPos.y = xmlConfigHC.Elements.CritMeter.Y;
				else
					CritMeterPos.y = 0;
					
				if (xmlConfigHC.Elements.CurrencyUpdates.Scale != undefined)
					CurrencyScale = xmlConfigHC.Elements.CurrencyUpdates.Scale;
					
				if (xmlConfigHC.Elements.CurrencyUpdates.X != undefined)
					CurrencyPos.x = xmlConfigHC.Elements.CurrencyUpdates.X;
				else
					CurrencyPos.x = 0;
					
				if (xmlConfigHC.Elements.CurrencyUpdates.Y != undefined)
					CurrencyPos.y = xmlConfigHC.Elements.CurrencyUpdates.Y;
				else
					CurrencyPos.y = 0;
					
					
				if (xmlConfigHC.Elements.EnemyHealthMeter.Scale != undefined)
					EnemyHealthScale = xmlConfigHC.Elements.EnemyHealthMeter.Scale;
					
				if (xmlConfigHC.Elements.EnemyHealthMeter.X != undefined)
					EnemyHealthPos.x = xmlConfigHC.Elements.EnemyHealthMeter.X;
				else
					EnemyHealthPos.x = 0;
					
				if (xmlConfigHC.Elements.EnemyHealthMeter.Y != undefined)
					EnemyHealthPos.y = xmlConfigHC.Elements.EnemyHealthMeter.Y;
				else
					EnemyHealthPos.y = 0;
					
			}
			var hudHUEradsbarfinal:* = hudHUEradsbar - hudHUEleftmeters;
			var hudHUEteamradsbarfinal:* = hudHUEteamrads - hudHUEteam;
			
			var tempSatRM:Number = 0;
			if (rightmetersSaturation >= 75)
			{
				tempSatRM = -(rightmetersSaturation-25);
			}
			else
			{
				tempSatRM = -rightmetersSaturation;
			}
			
			rightmetersInvColorMatrix = ColorMath.getColorChangeFilter(-rightmetersBrightness, -rightmetersContrast, tempSatRM, -hudHUErightmeters + 60);
			
			rightmetersColorMatrix = ColorMath.getColorChangeFilter(rightmetersBrightness, rightmetersContrast, rightmetersSaturation, hudHUErightmeters - 60);
			
			leftmetersColorMatrix = ColorMath.getColorChangeFilter(leftmetersBrightness, leftmetersContrast, leftmetersSaturation, hudHUEleftmeters - 60);
			
			var tempSatLM:Number = 0;
			if (leftmetersSaturation >= 75)
			{
				tempSatLM = -(leftmetersSaturation-25);
			}
			else
			{
				tempSatLM = -leftmetersSaturation;
			}
			
			leftmetersInvColorMatrix = ColorMath.getColorChangeFilter(-leftmetersBrightness, -leftmetersContrast, tempSatLM, -hudHUEleftmeters + 60);
			
			notiColorMatrix = ColorMath.getColorChangeFilter(notiBrightness, notiContrast, notiSaturation, hudHUEnoti - 60);
			
			frobberColorMatrix = ColorMath.getColorChangeFilter(frobberBrightness, frobberContrast, frobberSaturation, hudHUEfrobber - 60);
			
			trackerColorMatrix = ColorMath.getColorChangeFilter(trackerBrightness, trackerContrast, trackerSaturation, hudHUEtracker - 60);
			
			topcenterColorMatrix = ColorMath.getColorChangeFilter(topcenterBrightness, topcenterContrast, topcenterSaturation, hudHUEtopcenter - 60);
			
			var tempSat:Number = 0;
			if (topcenterSaturation >= 75)
			{
				tempSat = -(topcenterSaturation-25);
			}
			else
			{
				tempSat = -topcenterSaturation;
			}
			
			var tempSatTeam:Number = 0;
			if (teamSaturation >= 75)
			{
				tempSatTeam = -(teamSaturation-25);
			}
			else
			{
				tempSatTeam = -teamSaturation;
			}
			
			sneakDangerColorMatrix = ColorMath.getColorChangeFilter(-topcenterBrightness, -topcenterContrast, tempSat, -hudHUEtopcenter + 60);
			
			bottomcenterColorMatrix = ColorMath.getColorChangeFilter(bottomcenterBrightness, bottomcenterContrast, bottomcenterSaturation, hudHUEbottomcenter - 60);
			
			bccompassColorMatrix = ColorMath.getColorChangeFilter(bccompassBrightness, bccompassContrast, bccompassSaturation, hudHUEbccompass - 60);
			
			var tempSatBCC:Number = 0;
			if (bccompassSaturation >= 75)
			{
				tempSatBCC = -(bccompassSaturation-25);
			}
			else
			{
				tempSatBCC = -bccompassSaturation;
			}
			bccompassInvColorMatrix = ColorMath.getColorChangeFilter(-bccompassBrightness, -bccompassContrast, tempSatBCC, -hudHUEbccompass + 60);

			bottomcenterInvColorMatrix = ColorMath.getColorChangeFilter(-bottomcenterBrightness, -bottomcenterContrast, -bottomcenterSaturation, -hudHUEbottomcenter + 60);
			
			announceColorMatrix = ColorMath.getColorChangeFilter(announceBrightness, announceContrast, announceSaturation, hudHUEannounce - 60);
			
			announceInvColorMatrix = ColorMath.getColorChangeFilter(-announceBrightness, -announceContrast, -announceSaturation, -hudHUEannounce + 60);
			
			centerColorMatrix = ColorMath.getColorChangeFilter(centerBrightness, centerContrast, centerSaturation, hudHUEcenter - 60);
			
			teamColorMatrix = ColorMath.getColorChangeFilter(teamBrightness, teamContrast, teamSaturation, hudHUEteam - 60);
			
			teamInvColorMatrix = ColorMath.getColorChangeFilter(-teamBrightness, -teamContrast, tempSatTeam, -hudHUEteam + 60);
			
			teamradsColorMatrix = ColorMath.getColorChangeFilter(teamRadsBrightness, teamRadsContrast, teamRadsSaturation, hudHUEteamradsbarfinal + 60);
			
			floatingColorMatrix = ColorMath.getColorChangeFilter(floatingBrightness, floatingContrast, floatingSaturation, hudHUEfloating - 60);
			
			floatingInvColorMatrix = ColorMath.getColorChangeFilter(-floatingBrightness, -floatingContrast, -floatingSaturation, -hudHUEfloating + 60);
			
			radsbarColorMatrix = ColorMath.getColorChangeFilter(radsbarBrightness - leftmetersBrightness, radsbarContrast - leftmetersContrast, radsbarSaturation - leftmetersSaturation, hudHUEradsbarfinal + 60);
			
			hudColorHitMarkerMatrix = ColorMath.getColorChangeFilter(hmBrightness, hmContrast, hmSaturation, hudHUEHM);
			
			initializeStaticElementsProps();
		}
		
		private function initializeStaticElementsProps():void
		{
			
			if (xmlConfigHC.Elements != undefined)
			{
				if (SneakMeterScale <= maxScale)
				{
					topLevel.TopCenterGroup_mc.StealthMeter_mc.scaleX = SneakMeterScale;
					topLevel.TopCenterGroup_mc.StealthMeter_mc.scaleY = SneakMeterScale;
				}
				else
				{
					topLevel.TopCenterGroup_mc.StealthMeter_mc.scaleX = 1;
					topLevel.TopCenterGroup_mc.StealthMeter_mc.scaleY = 1;
				}
				
				if (FusionScale <= maxScale)
				{
					topLevel.RightMeters_mc.HUDFusionCoreMeter_mc.scaleX = FusionScale;
					topLevel.RightMeters_mc.HUDFusionCoreMeter_mc.scaleY = FusionScale;
				}
				else
				{
					topLevel.RightMeters_mc.HUDFusionCoreMeter_mc.scaleX = 1;
					topLevel.RightMeters_mc.HUDFusionCoreMeter_mc.scaleY = 1;
				}

				if (APMeterScale <= maxScale)
				{
					topLevel.RightMeters_mc.ActionPointMeter_mc.scaleX = APMeterScale;
					topLevel.RightMeters_mc.ActionPointMeter_mc.scaleY = APMeterScale;
				}
				else
				{
					topLevel.RightMeters_mc.ActionPointMeter_mc.scaleX = 1;
					topLevel.RightMeters_mc.ActionPointMeter_mc.scaleY = 1;
				}
				
				if (ActiveEffectsScale <= maxScale)
				{
					topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.scaleX = ActiveEffectsScale;
					topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.scaleY = ActiveEffectsScale;
				}
				else
				{
					topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.scaleX = 1;
					topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.scaleY = 1;
				}
				
				if (AmmoCountScale <= maxScale)
				{
					topLevel.RightMeters_mc.AmmoCount_mc.scaleX = AmmoCountScale;
					topLevel.RightMeters_mc.AmmoCount_mc.scaleY = AmmoCountScale;
				}
				else
				{
					topLevel.RightMeters_mc.AmmoCount_mc.scaleX = 1;
					topLevel.RightMeters_mc.AmmoCount_mc.scaleY = 1;
				}
				
				if (LevelUpAnimScale <= maxScale)
				{
					topLevel.LevelUpAnimation_mc.scaleX = LevelUpAnimScale;
					topLevel.LevelUpAnimation_mc.scaleY = LevelUpAnimScale;
				}
				else
				{
					topLevel.LevelUpAnimation_mc.scaleX = 1;
					topLevel.LevelUpAnimation_mc.scaleY = 1;
				}
				
				if (RepUpdatesScale <= maxScale)
				{
					topLevel.ReputationUpdates_mc.scaleX = RepUpdatesScale;
					topLevel.ReputationUpdates_mc.scaleY = RepUpdatesScale;
				}
				else
				{
					topLevel.ReputationUpdates_mc.scaleX = 1;
					topLevel.ReputationUpdates_mc.scaleY = 1;
				}
				if (HitMarkerScale <= maxScale)
				{
					topLevel.CenterGroup_mc.HitIndicator_mc.scaleX = HitMarkerScale;
					topLevel.CenterGroup_mc.HitIndicator_mc.scaleY = HitMarkerScale;
				}
				else
				{
					topLevel.CenterGroup_mc.HitIndicator_mc.scaleX = 1;
					topLevel.CenterGroup_mc.HitIndicator_mc.scaleY = 1;
				}
				if (FlashLightWidgetScale <= maxScale)
				{
					topLevel.RightMeters_mc.FlashLightWidget_mc.scaleX = FlashLightWidgetScale;
					topLevel.RightMeters_mc.FlashLightWidget_mc.scaleY = FlashLightWidgetScale;
				}
				else
				{
					topLevel.RightMeters_mc.FlashLightWidget_mc.scaleX = 1;
					topLevel.RightMeters_mc.FlashLightWidget_mc.scaleY = 1;
				}
				
				if (EmoteScale <= maxScale)
				{
					topLevel.RightMeters_mc.LocalEmote_mc.scaleX = EmoteScale;
					topLevel.RightMeters_mc.LocalEmote_mc.scaleY = EmoteScale;
				}
				else
				{
					topLevel.RightMeters_mc.LocalEmote_mc.scaleX = 1;
					topLevel.RightMeters_mc.LocalEmote_mc.scaleY = 1;
				}

				if (QuickLootScale <= maxScale)
				{
					topLevel.CenterGroup_mc.QuickContainerWidget_mc.scaleX = QuickLootScale;
					topLevel.CenterGroup_mc.QuickContainerWidget_mc.scaleY = QuickLootScale;
					
				}
				else
				{
					topLevel.CenterGroup_mc.QuickContainerWidget_mc.scaleX = 1;
					topLevel.CenterGroup_mc.QuickContainerWidget_mc.scaleY = 1;
				}
				
				if (FrobberScale <= maxScale)
				{
					topLevel.FrobberWidget_mc.scaleX = FrobberScale;
					topLevel.FrobberWidget_mc.scaleY = FrobberScale;
				}
				else
				{
					topLevel.FrobberWidget_mc.scaleX = 1;
					topLevel.FrobberWidget_mc.scaleY = 1;
				}

				if (RollOverScale <= maxScale)
				{
					topLevel.CenterGroup_mc.RolloverWidget_mc.scaleX = RollOverScale;
					topLevel.CenterGroup_mc.RolloverWidget_mc.scaleY = RollOverScale;
					
				}
				else
				{
					topLevel.CenterGroup_mc.RolloverWidget_mc.scaleX = 1;
					topLevel.CenterGroup_mc.RolloverWidget_mc.scaleY = 1;
				}
				
				if (CompassScale <= maxScale)
				{
					topLevel.BottomCenterGroup_mc.CompassWidget_mc.scaleX = CompassScale;
					topLevel.BottomCenterGroup_mc.CompassWidget_mc.scaleY = CompassScale;
				}
				else
				{
					topLevel.BottomCenterGroup_mc.CompassWidget_mc.scaleX = 1;
					topLevel.BottomCenterGroup_mc.CompassWidget_mc.scaleY = 1;
				}
				
				if (xmlConfigHC.Elements.Subtitles.Scale != undefined)
				{
					if (SubtitlesScale <= maxScale)
					{
						topLevel.BottomCenterGroup_mc.SubtitleText_mc.scaleX = SubtitlesScale;
						topLevel.BottomCenterGroup_mc.SubtitleText_mc.scaleY = SubtitlesScale;
					}
					else
					{
						topLevel.BottomCenterGroup_mc.SubtitleText_mc.scaleX = 1;
						topLevel.BottomCenterGroup_mc.SubtitleText_mc.scaleY = 1;
					}
				}
				
				if (xmlConfigHC.Elements.CritMeter.Scale != undefined)
				{
					if (CritMeterScale <= maxScale)
					{
						topLevel.BottomCenterGroup_mc.CritMeter_mc.scaleX = CritMeterScale;
						topLevel.BottomCenterGroup_mc.CritMeter_mc.scaleY = CritMeterScale;
					}
					else
					{
						topLevel.BottomCenterGroup_mc.CritMeter_mc.scaleX = 1;
						topLevel.BottomCenterGroup_mc.CritMeter_mc.scaleY = 1;
					}
				}
				
				if (xmlConfigHC.Elements.CurrencyUpdates.Scale != undefined)
				{
					if (CurrencyScale <= maxScale)
					{
						topLevel.HUDNotificationsGroup_mc.CurrencyUpdates_mc.scaleX = CurrencyScale;
						topLevel.HUDNotificationsGroup_mc.CurrencyUpdates_mc.scaleY = CurrencyScale;
					}
					else
					{
						topLevel.HUDNotificationsGroup_mc.CurrencyUpdates_mc.scaleX = 1;
						topLevel.HUDNotificationsGroup_mc.CurrencyUpdates_mc.scaleY = 1;
					}
				}
				
				if (xmlConfigHC.Elements.XPBar.Scale != undefined)
				{
					if (CritMeterScale <= maxScale)
					{
						topLevel.HUDNotificationsGroup_mc.XPMeter_mc.scaleX = XPBarScale;
						topLevel.HUDNotificationsGroup_mc.XPMeter_mc.scaleY = XPBarScale;
					}
					else
					{
						topLevel.HUDNotificationsGroup_mc.XPMeter_mc.scaleX = 1;
						topLevel.HUDNotificationsGroup_mc.XPMeter_mc.scaleY = 1;
					}
				}
				
				if (xmlConfigHC.Elements.EnemyHealthMeter.Scale != undefined)
				{
					if (EnemyHealthScale <= maxScale)
					{
						topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.scaleX = EnemyHealthScale;
						topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.scaleY = EnemyHealthScale;
					}
					else
					{
						topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.scaleX = 1;
						topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.scaleY = 1;
					}
				}
				
				

				if (LeftMeterScale <= maxScale)
				{
					topLevel.LeftMeters_mc.scaleX = LeftMeterScale;
					topLevel.LeftMeters_mc.scaleY = LeftMeterScale;
				}
				else
				{
					topLevel.LeftMeters_mc.scaleX = 1;
					topLevel.LeftMeters_mc.scaleY = 1;
				}


				if (NotificationScale <= maxScale)
				{
					topLevel.HUDNotificationsGroup_mc.Messages_mc.scaleX = NotificationScale;
					topLevel.HUDNotificationsGroup_mc.Messages_mc.scaleY = NotificationScale;
				}
				else
				{
					topLevel.HUDNotificationsGroup_mc.Messages_mc.scaleX = 1;
					topLevel.HUDNotificationsGroup_mc.Messages_mc.scaleY = 1;
				}

				if (QuestScale <= maxScale)
				{
					topLevel.TopRightGroup_mc.NewQuestTracker_mc.scaleX = QuestScale;
					topLevel.TopRightGroup_mc.NewQuestTracker_mc.scaleY = QuestScale;
				}
				else
				{
					topLevel.TopRightGroup_mc.NewQuestTracker_mc.scaleX = 1;
					topLevel.TopRightGroup_mc.NewQuestTracker_mc.scaleY = 1;
				}
				
				if (AnnounceScale <= maxScale)
				{
					topLevel.AnnounceEventWidget_mc.scaleX = AnnounceScale;
					topLevel.AnnounceEventWidget_mc.scaleY = AnnounceScale;
				}
				else
				{
					topLevel.AnnounceEventWidget_mc.scaleX = 1;
					topLevel.AnnounceEventWidget_mc.scaleY = 1;
				}

			}
			
			if (xmlConfigHC.Elements.EnemyHealthMeter.HealthPercentLocation != undefined)
			{
				if (xmlConfigHC.Elements.EnemyHealthMeter.HealthPercentLocation == "top")
				{
					showHealthText.y = topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.y - topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.height;
					showHealthText.autoSize = TextFieldAutoSize.CENTER;
					showHealthText.x = 0 - showHealthText.width * 0.5;
				}
				else if (xmlConfigHC.Elements.EnemyHealthMeter.HealthPercentLocation == "bottom")
				{
					showHealthText.y = topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.y + topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.height + 40;
					showHealthText.autoSize = TextFieldAutoSize.CENTER;
					showHealthText.x = 0 - showHealthText.width * 0.5;
				}
				else if (xmlConfigHC.Elements.EnemyHealthMeter.HealthPercentLocation == "right")
				{
					showHealthText.y = topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.y + showHealthText.height - topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.MeterBar_mc.height / 2;
					showHealthText.autoSize = TextFieldAutoSize.LEFT;
					showHealthText.x = topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.x + topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.width / 4 + 75;
				}
				else if (xmlConfigHC.Elements.EnemyHealthMeter.HealthPercentLocation == "left")
				{
					showHealthText.y = topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.y + showHealthText.height - topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.MeterBar_mc.height / 2;
					showHealthText.autoSize = TextFieldAutoSize.RIGHT;
					showHealthText.x = topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.x - topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.width / 2;
				}
				else
				{
					showHealthText.y = topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.y - topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.DisplayText_mc.height;
					showHealthText.autoSize = TextFieldAutoSize.CENTER;
					showHealthText.x = 0 - showHealthText.width * 0.5;
				}
			}
			
			if (xmlConfigHC.Colors.HUD.EnableRecoloring == "true")
			{
				topLevel.TopCenterGroup_mc.filters = [topcenterColorMatrix];

				/*
					commented out as announce code no longer functions and I cba to try to fix it
				try
				{
					topLevel.AnnounceEventWidget_mc.AnnounceActiveQuest_mc.Title_mc.Title_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.AnnounceActiveQuest_mc.Name_mc.Name_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.AnnounceActiveQuest_mc.Desc_mc.Desc_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.AnnounceLocationDiscovered_mc.Area_mc.Area_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.AnnounceLocationDiscovered_mc.Title_mc.Title_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.QuestCompleteContainer_mc.FanfareName_mc.FanfareName_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.QuestCompleteContainer_mc.FanfareType_mc.FanfareType_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.QuestCompleteContainer_mc.FanfareDescription_mc.FanfareDescription_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.UniqueItemContainer_mc.FanfareName_mc.FanfareName_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.UniqueItemContainer_mc.FanfareDescription_mc.FanfareDescription_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.AnnounceMessage_mc.Text_mc.Text_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.AnnounceTextCenter_mc.textField_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.AnnounceActiveQuest_mc.Desc_mc.Desc_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.AnnounceActiveQuest_mc.Title_mc.Title_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.AnnounceActiveQuest_mc.Name_mc.Name_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.QuestRewardContainer_mc.FanfareName_mc6.FanfareName_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.QuestRewardContainer_mc.FanfareName_mc5.FanfareName_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.QuestRewardContainer_mc.FanfareName_mc4.FanfareName_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.QuestRewardContainer_mc.FanfareName_mc3.FanfareName_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.QuestRewardContainer_mc.FanfareName_mc2.FanfareName_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.QuestRewardContainer_mc.FanfareName_mc1.FanfareName_tf.textColor = "0x" + announceRGB1;
					topLevel.AnnounceEventWidget_mc.QuestRewardContainer_mc.FanfareType_mc.FanfareType_tf.textColor = "0x" + announceRGB1;
				}
				catch (e:Error)
				{
					displayText("XML problem (Announce): " + e.toString());
				}
				
				*/
				topLevel.RightMeters_mc.filters = [rightmetersColorMatrix];
				topLevel.RightMeters_mc.LocalEmote_mc.filters = [rightmetersInvColorMatrix];
				
				//CenterGroup > HitMarker ;)
				topLevel.CenterGroup_mc.HitIndicator_mc.filters = [hudColorHitMarkerMatrix];
				
				//CenterGroup > QuickContainer, HUDCrosshair, RolloverWidget
				topLevel.CenterGroup_mc.getChildAt(0).filters = [centerColorMatrix];
				if (xmlConfigHC.Elements.RightMeter.Parts.FlashLightWidget.RestoreFlashLightIcon != undefined)
				{
					if (xmlConfigHC.Elements.RightMeter.Parts.FlashLightWidget.RestoreFlashLightIcon == "true")
					{
						FlashLightRestored_mc.visible = true;
					}
					else if (xmlConfigHC.Elements.RightMeter.Parts.FlashLightWidget.RestoreFlashLightIcon == "false")
					{
						FlashLightRestored_mc.visible = false;
					}
				}
				
				if (xmlConfigHC.Colors.HUD.CustomCrosshair == "true")
				{
					topLevel.CenterGroup_mc.HUDCrosshair_mc.filters = null;
				}
				else if (xmlConfigHC.Colors.HUD.CustomCrosshair == "false")
				{
					topLevel.CenterGroup_mc.HUDCrosshair_mc.filters = [centerColorMatrix];
				}
				
				topLevel.CenterGroup_mc.getChildAt(5).filters = [centerColorMatrix];
				topLevel.CenterGroup_mc.getChildAt(1).alpha = Number(xmlConfigHC.Colors.HUD.CrosshairOpacity);
				
				topLevel.DamageNumbers_mc.filters = [floatingColorMatrix];
				topLevel.FloatingTargetManager_mc.filters = [floatingColorMatrix];

				//HudFrobber
				topLevel.FrobberWidget_mc.filters = [frobberColorMatrix];
				
				//BottomCenterGroup > Subtitles, Crit Meter, sneakAttackMessage
				
				topLevel.BottomCenterGroup_mc.SubtitleText_mc.filters = [bottomcenterColorMatrix];
				topLevel.BottomCenterGroup_mc.CritMeter_mc.filters = [bottomcenterColorMatrix];
				
				
				topLevel.TopRightGroup_mc.NewQuestTracker_mc.filters = [trackerColorMatrix];
				
				topLevel.HUDNotificationsGroup_mc.Messages_mc.filters = [notiColorMatrix];
				topLevel.HUDNotificationsGroup_mc.XPMeter_mc.filters = [notiColorMatrix];
				
				topLevel.LeftMeters_mc.getChildAt(0).getChildAt(2).getChildAt(0).getChildAt(0).filters = [radsbarColorMatrix];
				topLevel.LeftMeters_mc.RadsMeter_mc.filters = [leftmetersInvColorMatrix];
				topLevel.LeftMeters_mc.filters = [leftmetersColorMatrix];
			}
			
			reloadCount = 0;
		}
		
		private function reloadXML() : void
		{
			try
			{
				xmlLoaderHC.load(new URLRequest("../HUDEditor.xml"));
				initCommands(xmlLoaderHC.data.toString());
			}
			catch (error:Error)
			{
				displayText("Error finding HUDEditor configuration file. " + error.message.toString());
			}
		} 
		
		private function displayText(_text:String):void
		{
			//debugTextHC.text += _text + "\n"; 
			debugTextHC.appendText(_text + "\n");
		}
		
		/*
			-
			-
			Removed some code here (that wasn't mine to distribute) which was for personal testing.
			-
			-
		*/
		
		private function displayHENotification(header:String, title:String, body:String) : void
		{
			HUDNotification_mc.Internal_mc.messageBoxStarContainer.visible = false;
			HUDNotification_mc.Internal_mc.HeaderText_tf.text = header;
			HUDNotification_mc.Internal_mc.TitleText_tf.text = " " + title;
			HUDNotification_mc.Internal_mc.BodyText_tf.text = " " + body;
					
			HUDNotification_mc.gotoAndPlay("FadeIn");
			EventCloseTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.closePromptHandler);
			timerResetAndStart(EventCloseTimer);
		}
		
		private function timerResetAndStart(timer:Timer) : *
		{
			timer.reset();
			timer.start();
			return;
		}
		
		public function closePromptHandler() : void
		{
			HUDNotification_mc.gotoAndPlay("FadeOut");
		}
		
		private function onHudModeDataChange(param1:FromClientDataEvent) : *
		{
			inPowerArmor = param1.data.inPowerArmor;
			powerArmorHUDEnabled = param1.data.powerArmorHUDEnabled;

		}
		
		private function frame1() : *
		{
			stop();
			HUDNotification_mc.visible = false;
		}

		private function frame2() : *
		{
			stop();
			HUDNotification_mc.visible = true;
		}
		

		private function frame3() : *
		{
			stop();
		}
		
		private function frame4() : *
		{
			stop();
			HUDNotification_mc.visible = false;
		}
		
		public function set levelUpVisible(param1:Boolean) : void
		{
			if(param1)
			{
				topLevel.HUDNotificationsGroup_mc.XPMeter_mc.gotoAndStop("levelup");
				topLevel.HUDNotificationsGroup_mc.XPMeter_mc.NumberText.visible = false;
			}
			else
			{
				topLevel.HUDNotificationsGroup_mc.XPMeter_mc.gotoAndStop("xp");
				topLevel.HUDNotificationsGroup_mc.XPMeter_mc.NumberText.visible = true;
			}
		}
		
		private function ShowHealth(param1:int):*
		{
			var isEnemy:Boolean = false;
			var healthPercent:Number  = NaN;
			showHealthText.visible = true;
			if (xmlConfigHC.Elements.EnemyHealthMeter.ShowHealthPercent == "true")
			{
				isEnemy = false;
				if (topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.currentFrame < 5)
				{
					isEnemy = true;
				}
				else if (topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.currentFrame > 5)
				{
					isEnemy = false;
				}
				healthPercent = !!isEnemy ? Number(topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.MeterBarEnemy_mc.Percent) : Number(topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.MeterBar_mc.Percent);
				if (param1 > 0)
				{
					showHealthText.text = "[" + Math.round(param1 * healthPercent).toString() + " - " + (healthPercent * 100).toFixed(2).toString() + "%]";
				}
				else
				{
					showHealthText.text = "[" + (healthPercent * 100).toFixed(2).toString() + "%]";
				}
				showHealthText.textColor = !!isEnemy ? uint(16741472) : uint(16777163);
			}
			else if (xmlConfigHC.Elements.EnemyHealthMeter.ShowHealthPercent == "false")
			{
				showHealthText.visible = false;
			}
			else if (xmlConfigHC.Elements.EnemyHealthMeter.ShowHealthPercent == undefined)
			{
				showHealthText.visible = false;
			}
		}
	}
	
}
