// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Overlay.PublicTeams.PublicTeamsBondMeter

package Overlay.PublicTeams
{
    import flash.display.MovieClip;
    import flash.utils.Timer;
    import flash.events.Event;
    import Shared.AS3.Data.BSUIDataManager;
    import flash.events.TimerEvent;
    import Shared.GlobalFunc;
    import Shared.AS3.Data.FromClientDataEvent;

    public class PublicTeamsBondMeter extends MovieClip 
    {

        public static var TIME_TO_FULL_BOND:Number;
        public static var LAST_BOND_UPDATE_TIME:Number;
        public static const BOND_METER_OFF:uint = 0;
        public static const BOND_METER_PAUSED:uint = 1;
        public static const BOND_METER_FILLING:uint = 2;
        public static const BOND_METER_COMPLETE:uint = 3;
        public static const EVENT_BOND_METER_COMPLETE:* = "EventBondMeterComplete";

        public var BondIcon_mc:MovieClip;
        public var BondMeterFill_mc:MovieClip;
        public var BondMeterAnim_mc:MovieClip;
        public var BondMeterFrameBonded_mc:MovieClip;
        public var BondMeterCompleteAnim_mc:MovieClip;
        private var m_StartTime:Number = 0;
        private var m_BondMeterState:int = -1;
        private var m_Timer:Timer;

        public function PublicTeamsBondMeter()
        {
            if (isNaN(TIME_TO_FULL_BOND))
            {
                TIME_TO_FULL_BOND = 300;
            };
            if (isNaN(LAST_BOND_UPDATE_TIME))
            {
                LAST_BOND_UPDATE_TIME = 0;
            };
            this.m_Timer = new Timer(1000);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            BSUIDataManager.Subscribe(PublicTeamsShared.EVENT_PUBLIC_TEAMS_DATA, this.onPublicTeamsDataUpdate);
            this.bondMeterState = BOND_METER_OFF;
        }

        public function get bondMeterState():int
        {
            return (this.m_BondMeterState);
        }

        public function set bondMeterState(_arg_1:int):void
        {
            if ((((!(_arg_1 == BOND_METER_OFF)) && (!(_arg_1 == BOND_METER_COMPLETE))) || (!(this.m_BondMeterState == _arg_1))))
            {
                this.m_BondMeterState = _arg_1;
                switch (_arg_1)
                {
                    case BOND_METER_OFF:
                        this.BondIcon_mc.visible = false;
                        this.BondMeterAnim_mc.gotoAndStop(1);
                        this.setBondFillProgress(0);
                        this.BondMeterFrameBonded_mc.visible = false;
                        this.m_Timer.removeEventListener(TimerEvent.TIMER, this.onTimerEvent);
                        this.m_Timer.reset();
                        return;
                    case BOND_METER_PAUSED:
                        this.BondIcon_mc.visible = false;
                        this.BondMeterAnim_mc.gotoAndStop(1);
                        this.setBondFillProgress(this.m_StartTime);
                        this.BondMeterFrameBonded_mc.visible = false;
                        this.m_Timer.removeEventListener(TimerEvent.TIMER, this.onTimerEvent);
                        this.m_Timer.reset();
                        return;
                    case BOND_METER_FILLING:
                        this.BondIcon_mc.visible = false;
                        this.BondMeterAnim_mc.gotoAndPlay(1);
                        this.setBondFillProgress(this.elapsedTime);
                        this.BondMeterFrameBonded_mc.visible = false;
                        this.m_Timer.addEventListener(TimerEvent.TIMER, this.onTimerEvent);
                        this.m_Timer.start();
                        return;
                    case BOND_METER_COMPLETE:
                        this.BondIcon_mc.visible = true;
                        this.BondMeterAnim_mc.gotoAndStop(1);
                        this.setBondFillProgress(this.elapsedTime);
                        this.BondMeterFrameBonded_mc.visible = true;
                        this.m_Timer.removeEventListener(TimerEvent.TIMER, this.onTimerEvent);
                        this.m_Timer.reset();
                        dispatchEvent(new Event(EVENT_BOND_METER_COMPLETE, true, true));
                        return;
                };
            };
        }

        public function get elapsedTime():Number
        {
            var _local_1:Number = 0;
            if (LAST_BOND_UPDATE_TIME)
            {
                _local_1 = ((new Date().getTime() / 1000) - LAST_BOND_UPDATE_TIME);
            };
            return (this.m_StartTime + _local_1);
        }

        public function get isBonded():Boolean
        {
            return (this.bondMeterState == BOND_METER_COMPLETE);
        }

        public function resetBondMeter():void
        {
            this.bondMeterState = BOND_METER_OFF;
        }

        public function startBondMeter(_arg_1:Number, _arg_2:Boolean=false):void
        {
            this.m_StartTime = _arg_1;
            if (this.m_StartTime >= 0)
            {
                if (_arg_2)
                {
                    if (this.m_StartTime >= TIME_TO_FULL_BOND)
                    {
                        this.bondMeterState = BOND_METER_COMPLETE;
                    }
                    else
                    {
                        this.bondMeterState = BOND_METER_PAUSED;
                    };
                }
                else
                {
                    if (this.elapsedTime >= TIME_TO_FULL_BOND)
                    {
                        this.bondMeterState = BOND_METER_COMPLETE;
                    }
                    else
                    {
                        this.bondMeterState = BOND_METER_FILLING;
                    };
                };
            }
            else
            {
                this.bondMeterState = BOND_METER_OFF;
            };
        }

        private function setBondFillProgress(_arg_1:Number):void
        {
            var _local_2:uint;
            if (_arg_1 <= 0)
            {
                this.BondMeterFill_mc.gotoAndStop(1);
            }
            else
            {
                if (_arg_1 <= TIME_TO_FULL_BOND)
                {
                    _local_2 = (this.BondMeterFill_mc.totalFrames * (_arg_1 / TIME_TO_FULL_BOND));
                    this.BondMeterFill_mc.gotoAndStop(_local_2);
                }
                else
                {
                    this.BondMeterFill_mc.gotoAndStop(this.BondMeterFill_mc.totalFrames);
                };
            };
        }

        private function onTimerEvent(_arg_1:Event):void
        {
            if (this.bondMeterState == BOND_METER_FILLING)
            {
                this.setBondFillProgress(this.elapsedTime);
                if (this.elapsedTime >= TIME_TO_FULL_BOND)
                {
                    this.BondMeterCompleteAnim_mc.gotoAndPlay("complete");
                    GlobalFunc.PlayMenuSound("UIMenuSocialTeamBonded");
                    this.bondMeterState = BOND_METER_COMPLETE;
                };
            };
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            if (this.m_Timer)
            {
                this.m_Timer.removeEventListener(TimerEvent.TIMER, this.onTimerEvent);
            };
        }

        private function onPublicTeamsDataUpdate(_arg_1:FromClientDataEvent):void
        {
            if ((((_arg_1) && (_arg_1.data)) && (_arg_1.data.requiredBondTime)))
            {
                TIME_TO_FULL_BOND = _arg_1.data.requiredBondTime;
            };
        }


    }
}//package Overlay.PublicTeams

