package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import flash.utils.getQualifiedClassName;
   import Shared.AS3.Events.*;
   import Shared.AS3.Data.*;
   import Shared.AS3.*;
   import Shared.*;

	/**
	 * ...
	 * @author Bolbman
	 * Modified for HUDColours mod by Annorexorcist
	 */
	public class HUDEditor extends MovieClip 
	{
		
		private var topLevel:* = null;
		private var xmlConfigHC:XML;
		private var xmlLoaderHC:URLLoader;
		private var updateTimerHC:Timer;
		
		private var imageName:String;   

		private var debugTextHC:TextField;
		private var debugTextHCFormat:TextFormat;
		private var debugTextHCShadow:DropShadowFilter;
		
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
		
		public var eee:*;
		
		public var sneakMeterScale:* = 1;
		public var QuestScale:* = 1;
		public var NotificationScale:* = 1;
		public var LeftMeterScale:* = 1;
		public var RightMeterScale:* = 1;
		public var CompassScale:* = 1;
		public var AnnounceScale:* = 1;
		public var QuickLootScale:* = 1;
		public var InteractPromptScale:* = 1;
		public var FrobberX:* = 0; 
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
		
		private static var hudColorHitMarkerMatrix:ColorMatrixFilter = null;
		
		private var _CharInfo:Object;
		private var _AmmoInfo:*;

		
		public function HUDEditor() 
		{
			updateTimerHC = new Timer(120, 0);

			debugTextHCShadow = new DropShadowFilter(1, 45, 0x000000, 0.75, 4, 4, 1, BitmapFilterQuality.HIGH, false, false, false);
			debugTextHC = new TextField();
			debugTextHCFormat = new TextFormat("$MAIN_Font_Light", 18, 0xF0F0F0); //color: 16777163
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
			
			super();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			trace("HUDColours Started");
		}
		
		private function addedToStageHandler(e:Event):void
		{
			topLevel = stage.getChildAt(0);
			if(topLevel != null && getQualifiedClassName(topLevel) == "HUDMenu")
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
			xmlLoaderHC = new URLLoader();
			xmlLoaderHC.addEventListener(Event.COMPLETE, onFileLoad);
			loadConfig();
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
				displayText("Error finding HUDColours configuration file. " + error.message.toString());
				return;
			}
		}
		
		private function onFileLoad(e:Event):void
		{
			Shared.AS3.Data.BSUIDataManager.Subscribe("HUDRightMetersData", onCharInfoUpd);
			initCommands(e.target.data);
			updateTimerHC.addEventListener(TimerEvent.TIMER_COMPLETE, update);
			updateTimerHC.start();
			xmlLoaderHC.removeEventListener(Event.COMPLETE, onFileLoad);
		}
		
		private function onCharInfoUpd(_arg1:FromClientDataEvent):*
		{
			_CharInfo = _arg1.data;
		}
		
		
		private function update(event:TimerEvent):void
		{
			
			/*debugTextHC.text = "";
			var labelTF:* = topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ActiveEffectStatusLabel_mc.Label_tf;
			var thirstPC:* = this._CharInfo.thirstPercent;
			var hungerPC:* = this._CharInfo.hungerPercent;
			
			var thirstRound:* = Math.round(thirstPC * 100);
			var hungerRound:* = Math.round(hungerPC * 100);
			
			var hungerZeros:* = "";
			var thirstZeros:* = "";
			
			if (thirstRound < 100)
			{
				thirstZeros = "0" + thirstRound;
			}
			
			if (hungerRound < 100)
			{
				hungerZeros = "0" + hungerRound;
			}
			
			if (thirstRound < 10)
			{
				thirstZeros = "00" + thirstRound;
			}
			
			if (hungerRound < 10)
			{
				hungerZeros = "00" + hungerRound;
			}
			
			if (hungerRound == 100)
			{
				hungerZeros = hungerRound;
			}
			
			if (thirstRound == 100)
			{
				thirstZeros = thirstRound;
			}
			
			//displayText("Thirst: " + thirstRound + "%");
			//displayText("Hunger: " + hungerRound + "%");
			//labelTF.text = hungerZeros + "%                                              " + thirstZeros + "%";
			//displayText(labelTF.autoSize.toString());
			//labelTF.autoSize = TextFieldAutoSize.RIGHT;
			/*for(var id:String in topLevel.RightMeters_mc)
			{
				var value:Object = topLevel.RightMeters_mc[id];
				var temp1:* = id + " = " + value;
				displayText(temp1);
			}*/

			
			for (var ii:int = 0; ii < topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.numChildren; ii++)
			{
				//displayText(ii + " " + topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).toString());
				//displayText(ii + ":2 currentFrame " + topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(2).currentFrame.toString());
				if (topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.getChildAt(ii).getChildAt(2).currentFrame == 50)
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
			

			
			//displayText(topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ClipHolderInternal.toString());

			if (topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.IsHostile == true)
			{
				topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.filters = [sneakDangerColorMatrix];
			}
			else if (topLevel.TopCenterGroup_mc.EnemyHealthMeter_mc.IsHostile == false)
			{
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

			comment("Team Panel");
			eee = topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).numChildren;
			//displayText(eee);

			if (eee == 1)
			{
				topLevel.PartyResolutionContainer_mc.filters = [teamColorMatrix];
				topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(0).textColor = 0xF5CB5B;
				topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(1).textColor = 0xF5CB5B;
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(9).filters = [teamradsColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(3).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(7).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(15).filters = [teamInvColorMatrix];
			}
			
			else if (eee == 2)
			{
				topLevel.PartyResolutionContainer_mc.filters = [teamColorMatrix];
				topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(0).textColor = 0xF5CB5B;
				topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(1).textColor = 0xF5CB5B;
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(9).filters = [teamradsColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(3).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(7).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(15).filters = [teamInvColorMatrix];
				
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(9).filters = [teamradsColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(3).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(7).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(15).filters = [teamInvColorMatrix];
			}
			
			else if (eee == 3)
			{
				topLevel.PartyResolutionContainer_mc.filters = [teamColorMatrix];
				topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(0).textColor = 0xF5CB5B;
				topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(1).textColor = 0xF5CB5B;
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(9).filters = [teamradsColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(3).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(7).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(15).filters = [teamInvColorMatrix];
				
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(9).filters = [teamradsColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(3).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(7).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(15).filters = [teamInvColorMatrix];
				
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(9).filters = [teamradsColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(3).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(7).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(15).filters = [teamInvColorMatrix];
			}
			
			else if (eee == 4)
			{
				topLevel.PartyResolutionContainer_mc.filters = [teamColorMatrix];
				topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(0).textColor = 0xF5CB5B;
				topLevel.PartyResolutionContainer_mc.HUDPartyListBase_mc.PTPartyListHeader_mc.getChildAt(1).getChildAt(1).textColor = 0xF5CB5B;
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(9).filters = [teamradsColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(3).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(7).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(15).filters = [teamInvColorMatrix];
				
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(9).filters = [teamradsColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(3).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(7).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(1).getChildAt(15).filters = [teamInvColorMatrix];
				
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(9).filters = [teamradsColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(3).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(7).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(2).getChildAt(15).filters = [teamInvColorMatrix];
				
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(3).getChildAt(9).filters = [teamradsColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(3).getChildAt(3).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(3).getChildAt(7).filters = [teamInvColorMatrix];
				topLevel.getChildAt(16).getChildAt(0).getChildAt(1).getChildAt(0).getChildAt(1).getChildAt(3).getChildAt(15).filters = [teamInvColorMatrix];
			}
			
			else
			{
				comment("do nothing here, fixes performance issues relating to no team panel showing");
			}
			
			topLevel.TeammateMarkerBase.filters = [floatingColorMatrix];
			if (topLevel.TeammateMarkerBase.numChildren > 1)
			{
				for (var i:int = 1; i < topLevel.TeammateMarkerBase.numChildren; i++)
				{
					topLevel.TeammateMarkerBase.getChildAt(i).getChildAt(3).filters = [floatingInvColorMatrix];
				}
			}
			
			if (xmlConfigHC.Colors.HUD.EditMode != undefined)
			{
				if (xmlConfigHC.Colors.HUD.EditMode == true && reloadCount == 25)
				{
					//debugTextHC.text = "";
					reloadXML();
					reloadCount = 0;
					//topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ActiveEffectStatusLabel_mc.Label_tf.text = "HUDEditor v1.6 EDIT MODE";
				}
				else if (xmlConfigHC.Colors.HUD.EditMode == false)
				{
					//topLevel.RightMeters_mc.HUDActiveEffectsWidget_mc.ActiveEffectStatusLabel_mc.Label_tf.text = "";
					reloadCount = 0;
				}
				else
				{
					reloadCount++;
				}
			}
		}
		
		public static function rangeToPercent(num:Number, min:Number, max:Number, constrainMin:Boolean = false, constrainMax:Boolean = false):Number 
		{
			if (constrainMin && num < min) return 0;
			if (constrainMax && num > max) return 1;
			return (num - min) / (max - min);
		}

		private function initCommands(wholeFileStr:String):void
		{
			comment("Read the whole configuration string and assign values to our actionscript variables");
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
			
			radsbarBrightness = Number(xmlConfigHC.Colors.LeftMeters.Brightness);
			radsbarContrast = Number(xmlConfigHC.Colors.LeftMeters.Contrast);
			radsbarSaturation = Number(xmlConfigHC.Colors.LeftMeters.Saturation);
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
			
			if (xmlConfigHC.Colors.BottomCenter.CompassRGB != undefined)
			{
				hudHUEbccompass = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.BottomCenter.CompassRGB))[0];
			}
			else
			{
				hudHUEbccompass = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.BottomCenter.RGB))[0];
			}
			
			hudHUEannounce = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.AnnounceAvailable.RGB))[0];
			hudHUEcenter = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.Center.RGB))[0];
			hudHUEteam = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.Team.RGB))[0];
			hudHUEfloating = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.Floating.RGB))[0];
			hudHUEteamrads = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.Team.RadsBarRGB))[0];
			hudHUEradsbar = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.LeftMeters.RadsBarRGB))[0];
			hudHUEHM = ColorMath.hex2hsb(uint("0x" + xmlConfigHC.Colors.HitMarkerTint.RGB))[0];
			
			sneakMeterScale = xmlConfigHC.ElementScale.StealthMeterScale;
			QuestScale = xmlConfigHC.ElementScale.QuestTrackerScale;
			LeftMeterScale = xmlConfigHC.ElementScale.LeftMeterScale;
			RightMeterScale = xmlConfigHC.ElementScale.RightMeterScale;
			AnnounceScale = xmlConfigHC.ElementScale.AnnounceScale;
			CompassScale = xmlConfigHC.ElementScale.CompassScale;
			NotificationScale = xmlConfigHC.ElementScale.NotificationScale;
			QuickLootScale = xmlConfigHC.ElementScale.QuickLootScale;

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
			
			bottomcenterInvColorMatrix = ColorMath.getColorChangeFilter(-bottomcenterBrightness, -bottomcenterContrast, -bottomcenterSaturation, -hudHUEbottomcenter + 60);
			
			announceColorMatrix = ColorMath.getColorChangeFilter(announceBrightness, announceContrast, announceSaturation, hudHUEannounce - 60);
			
			announceInvColorMatrix = ColorMath.getColorChangeFilter(-announceBrightness, -announceContrast, -announceSaturation, -hudHUEannounce + 60);
			
			centerColorMatrix = ColorMath.getColorChangeFilter(centerBrightness, centerContrast, centerSaturation, hudHUEcenter - 60);
			
			teamColorMatrix = ColorMath.getColorChangeFilter(teamBrightness, teamContrast, teamSaturation, hudHUEteam - 60);
			
			teamInvColorMatrix = ColorMath.getColorChangeFilter(-teamBrightness, -teamContrast, tempSatTeam, -hudHUEteam + 60);
			
			teamradsColorMatrix = ColorMath.getColorChangeFilter(teamBrightness, teamContrast, teamSaturation, hudHUEteamradsbarfinal + 60);
			
			floatingColorMatrix = ColorMath.getColorChangeFilter(floatingBrightness, floatingContrast, floatingSaturation, hudHUEfloating - 60);
			
			floatingInvColorMatrix = ColorMath.getColorChangeFilter(-floatingBrightness, -floatingContrast, -floatingSaturation, -hudHUEfloating + 60);
			
			radsbarColorMatrix = ColorMath.getColorChangeFilter(radsbarBrightness - leftmetersBrightness, radsbarContrast - leftmetersContrast, radsbarSaturation - leftmetersSaturation, hudHUEradsbarfinal + 60);
			
			hudColorHitMarkerMatrix = ColorMath.getColorChangeFilter(hmBrightness, hmContrast, hmSaturation, hudHUEHM);
			
			initializeStaticElementsProps();
		}
		
		private function initializeStaticElementsProps():void
		{
			topLevel.TopCenterGroup_mc.filters = [topcenterColorMatrix];
			if (sneakMeterScale <= 1.5 )
			{
				topLevel.TopCenterGroup_mc.getChildAt(0).scaleX = sneakMeterScale;
				topLevel.TopCenterGroup_mc.getChildAt(0).scaleY = sneakMeterScale;
			}
			if (RightMeterScale <= 1.5 )
			{
				topLevel.RightMeters_mc.scaleX = RightMeterScale;
				topLevel.RightMeters_mc.scaleY = RightMeterScale;
			}
			if (QuickLootScale <= 1.5 )
			{
				topLevel.CenterGroup_mc.getChildAt(0).scaleX = QuickLootScale;
				topLevel.CenterGroup_mc.getChildAt(0).scaleY = QuickLootScale;
			}
			if (CompassScale <= 1.5 )
			{
				topLevel.getChildAt(8).getChildAt(0).scaleX = CompassScale;
				topLevel.getChildAt(8).getChildAt(0).scaleY = CompassScale;
			}
			if (LeftMeterScale <= 1.5 )
			{
				topLevel.LeftMeters_mc.scaleX = LeftMeterScale;
				topLevel.LeftMeters_mc.scaleY = LeftMeterScale;
			}
			if (NotificationScale <= 1.5 )
			{
				topLevel.HUDNotificationsGroup_mc.Messages_mc.scaleX = NotificationScale;
				topLevel.HUDNotificationsGroup_mc.Messages_mc.scaleY = NotificationScale;
			}
			if (QuestScale <= 1.5 )
			{
				topLevel.TopRightGroup_mc.QuestTracker.scaleX = QuestScale;
				topLevel.TopRightGroup_mc.QuestTracker.scaleY = QuestScale;
			}
			
			if (AnnounceScale <= 1.5 )
			{
				topLevel.AnnounceEventWidget_mc.scaleX = AnnounceScale;
				topLevel.AnnounceEventWidget_mc.scaleY = AnnounceScale;
			}

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
				displayText(e.toString());
			}
			
			topLevel.BottomCenterGroup_mc.CompassWidget_mc.filters = [bccompassColorMatrix];
			
			topLevel.RightMeters_mc.filters = [rightmetersColorMatrix];
			topLevel.RightMeters_mc.LocalEmote_mc.filters = [rightmetersInvColorMatrix];
			
			comment("CenterGroup > HitMarker ;)");
			topLevel.CenterGroup_mc.getChildAt(4).filters = [hudColorHitMarkerMatrix];
			
			comment("CenterGroup > QuickContainer, HUDCrosshair, RolloverWidget");
			topLevel.CenterGroup_mc.getChildAt(0).filters = [centerColorMatrix];
			
			if (xmlConfigHC.Colors.HUD.CustomCrosshair == true)
			{
				comment("do nothing");
			}
			else
			{
				topLevel.CenterGroup_mc.getChildAt(1).filters = [centerColorMatrix];
			}
			
			topLevel.CenterGroup_mc.getChildAt(5).filters = [centerColorMatrix];
			topLevel.CenterGroup_mc.getChildAt(1).alpha = Number(xmlConfigHC.Colors.HUD.CrosshairOpacity);
			
			topLevel.getChildAt(3).filters = [floatingColorMatrix];
			topLevel.getChildAt(23).filters = [floatingColorMatrix];

			comment("HudFrobber");
			topLevel.getChildAt(10).filters = [frobberColorMatrix];
			
			comment("BottomCenterGroup > Subtitles, Crit Meter, sneakAttackMessage");
			
			topLevel.BottomCenterGroup_mc.SubtitleText_mc.filters = [bottomcenterColorMatrix];
			topLevel.BottomCenterGroup_mc.CritMeter_mc.filters = [bottomcenterColorMatrix];
			
			
			topLevel.TopRightGroup_mc.QuestTracker.filters = [trackerColorMatrix];
			
			topLevel.HUDNotificationsGroup_mc.Messages_mc.filters = [notiColorMatrix];
			topLevel.HUDNotificationsGroup_mc.XPMeter_mc.filters = [notiColorMatrix];
			
			topLevel.LeftMeters_mc.getChildAt(0).getChildAt(2).getChildAt(0).getChildAt(0).filters = [radsbarColorMatrix];
			topLevel.LeftMeters_mc.RadsMeter_mc.filters = [leftmetersInvColorMatrix];
			topLevel.LeftMeters_mc.filters = [leftmetersColorMatrix];
		}
		
		private function reloadXML() : void
		{
			try
			{
				xmlLoaderHC.load(new URLRequest("../HUDEditor.xml"));
				initCommands(xmlLoaderHC.data.toString());
				return;
			}
			catch (error:Error)
			{
				displayText("Error finding HUDColours configuration file. " + error.message.toString());
				return;
			}
		} 
		
		private function displayText(_text:String):void
		{
			debugTextHC.text += _text + "\n";
		}

		private function comment(_text:String):void
		{
			//lets me comment in the code so when people inspect it they can see the comment
			return;
		}
	}
	
}