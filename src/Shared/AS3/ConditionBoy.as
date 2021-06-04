// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.ConditionBoy

package Shared.AS3
{
    import flash.display.MovieClip;
    import Shared.AS3.COMPANIONAPP.PipboyLoader;
    import __AS3__.vec.Vector;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.utils.setTimeout;
    import __AS3__.vec.*;

    public dynamic class ConditionBoy extends BSUIComponent 
    {

        private static const CONDITION_DISPLAY_TIME:uint = 5000;
        private static const CLIP_BODY_TEMPLATE_PATH:String = "Components/ConditionClips/Condition_Body_";
        private static const CLIP_BODY_HUNGER_ID:int = 16;
        private static const CLIP_BODY_THIRST_ID:int = 18;
        private static const CLIP_BODY_DISEASE_ID:int = 17;
        private static const CLIP_BODY_MUTATION_ID:int = 19;
        private static const NUM_BODY_CLIPS:int = 20;
        private static const HEAD_NORMAL_FRAME:uint = 1;
        private static const HEAD_GENERAL_NEGATIVE_FRAME:uint = 4;
        private static const HEAD_GENERAL_NEGATIVE_DAMAGED_FRAME:uint = 33;
        private static const HEAD_DRUGGED_FRAME:uint = 5;
        private static const HEAD_DRUGGED_DAMAGED_FRAME:uint = 37;
        private static const HEAD_IRRADIATED_FRAME:uint = 17;
        private static const HEAD_IRRADIATED_DAMAGED_FRAME:uint = 49;
        private static const HEAD_DISEASED_FRAME:uint = 65;
        private static const HEAD_DISEASED_DAMAGED_FRAME:uint = 67;
        private static const HEAD_MUTATED_FRAME:uint = 71;
        private static const HEAD_MUTATED_DAMAGED_FRAME:uint = 76;
        private static const HEAD_HUNGER_FRAME:uint = HEAD_DRUGGED_FRAME;//5
        private static const HEAD_THIRST_FRAME:uint = HEAD_DRUGGED_FRAME;//5

        private var BodyClip:MovieClip = null;
        private var HeadClip:MovieClip = null;
        private var HeadLoader:PipboyLoader;
        private var BodyLoader:PipboyLoader;
        private var ColorFileText:String;
        private var PrimaryCondition:Object;
        private var SecondaryConditions:Vector.<Object>;
        private var CurrentlyShownCondition:Object;
        private var PreloadedBodyClips:Vector.<PipboyLoader>;
        private var ShouldUpdate:Boolean = false;
        private var PrimaryConditionChanged:Boolean = false;
        private var IsReadyForNextCondition:Boolean = true;
        private var IsMutated:Boolean = false;
        private var IsDiseased:Boolean = false;
        private var IsThirstStateNegative:Boolean = false;
        private var IsHungerStateNegative:Boolean = false;
        private var Monochrome:Boolean = false;
        private var IsMenuInstance:Boolean = false;

        public function ConditionBoy()
        {
            this.ColorFileText = new String();
            this.PrimaryCondition = {};
            this.SecondaryConditions = new Vector.<Object>();
            this.CurrentlyShownCondition = {};
            super();
            this.LoadHead();
        }

        public function set monochrome(_arg_1:Boolean):*
        {
        }

        public function get monochrome():*
        {
            return (this.Monochrome);
        }

        public function set isMenuInstance(_arg_1:Boolean):*
        {
            this.IsMenuInstance = _arg_1;
        }

        public function PreloadConditions():*
        {
            var _local_1:*;
            var _local_2:PipboyLoader;
            var _local_3:URLRequest;
            if (!this.PreloadedBodyClips)
            {
                this.PreloadedBodyClips = new Vector.<PipboyLoader>(NUM_BODY_CLIPS, true);
                for (_local_1 in this.PreloadedBodyClips)
                {
                    _local_2 = new PipboyLoader();
                    this.PreloadedBodyClips[_local_1] = _local_2;
                    _local_3 = new URLRequest(this.GetPathForCondition(_local_1));
                    _local_2.load(_local_3);
                };
            };
        }

        private function GetPathForCondition(_arg_1:int):*
        {
            return (((CLIP_BODY_TEMPLATE_PATH + this.ColorFileText) + _arg_1) + ".swf");
        }

        public function SetData(_arg_1:Object):*
        {
            this.UpdatePrimaryCondition(_arg_1);
            if (!this.IsMenuInstance)
            {
                this.UpdateSecondaryConditions(_arg_1);
            };
            if (this.IsReadyForNextCondition)
            {
                this.ShowNextCondition();
            };
        }

        private function UpdatePrimaryCondition(_arg_1:Object):*
        {
            var _local_2:Boolean = _arg_1.isHeadDamaged;
            var _local_3:uint = HEAD_NORMAL_FRAME;
            if (_arg_1.isIrradiated)
            {
                _local_3 = ((_local_2) ? HEAD_IRRADIATED_DAMAGED_FRAME : HEAD_IRRADIATED_FRAME);
            }
            else
            {
                if (_arg_1.isDrugged)
                {
                    _local_3 = ((_local_2) ? HEAD_DRUGGED_DAMAGED_FRAME : HEAD_DRUGGED_FRAME);
                }
                else
                {
                    if ((((_arg_1.isAddicted) || (_local_2)) || (!(_arg_1.bodyFlags == 0))))
                    {
                        _local_3 = ((_local_2) ? HEAD_GENERAL_NEGATIVE_DAMAGED_FRAME : HEAD_GENERAL_NEGATIVE_FRAME);
                    };
                };
            };
            this.PrimaryCondition.isPersistent = ((_local_2) || (!(_arg_1.bodyFlags == 0)));
            if (((!(this.PrimaryCondition.headFrame == _local_3)) || (!(this.PrimaryCondition.bodyId == _arg_1.bodyFlags))))
            {
                this.PrimaryCondition.headFrame = _local_3;
                this.PrimaryCondition.bodyId = _arg_1.bodyFlags;
                this.PrimaryConditionChanged = true;
            };
        }

        private function UpdateSecondaryConditions(_arg_1:Object):*
        {
            var _local_2:Boolean = _arg_1.isHeadDamaged;
            if (((!(this.IsMutated)) && (_arg_1.isMutated)))
            {
                this.SecondaryConditions.push({
                    "headFrame":((_local_2) ? HEAD_MUTATED_DAMAGED_FRAME : HEAD_MUTATED_FRAME),
                    "bodyId":CLIP_BODY_MUTATION_ID
                });
            };
            this.IsMutated = _arg_1.isMutated;
            if (((!(this.IsDiseased)) && (_arg_1.isDiseased)))
            {
                this.SecondaryConditions.push({
                    "headFrame":((_local_2) ? HEAD_DISEASED_DAMAGED_FRAME : HEAD_DISEASED_FRAME),
                    "bodyId":CLIP_BODY_DISEASE_ID
                });
            };
            this.IsDiseased = _arg_1.isDiseased;
            if (((_arg_1.isThirstStateNegative) && (!(this.IsThirstStateNegative))))
            {
                this.SecondaryConditions.push({
                    "headFrame":HEAD_THIRST_FRAME,
                    "bodyId":CLIP_BODY_THIRST_ID
                });
            };
            this.IsThirstStateNegative = _arg_1.isThirstStateNegative;
            if (((_arg_1.isHungerStateNegative) && (!(this.IsHungerStateNegative))))
            {
                this.SecondaryConditions.push({
                    "headFrame":HEAD_HUNGER_FRAME,
                    "bodyId":CLIP_BODY_HUNGER_ID
                });
            };
            this.IsHungerStateNegative = _arg_1.isHungerStateNegative;
        }

        private function ShowNextCondition():*
        {
            var _local_2:Boolean;
            var _local_3:URLRequest;
            var _local_1:Object;
            if (this.SecondaryConditions.length > 0)
            {
                _local_1 = this.SecondaryConditions.pop();
            }
            else
            {
                if (((this.PrimaryConditionChanged) || (this.PrimaryCondition.isPersistent)))
                {
                    _local_1 = this.PrimaryCondition;
                    this.PrimaryConditionChanged = false;
                };
            };
            if (_local_1)
            {
                _local_2 = ((this.IsShowingCondition(_local_1)) && (_local_1.isPersistent));
                if (!_local_2)
                {
                    this.UnloadBody();
                    this.CurrentlyShownCondition.headFrame = _local_1.headFrame;
                    this.CurrentlyShownCondition.bodyId = _local_1.bodyId;
                    if (this.PreloadedBodyClips != null)
                    {
                        this.onConditionBodyLoadComplete(null);
                    }
                    else
                    {
                        this.BodyLoader = new PipboyLoader();
                        this.BodyLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onConditionBodyLoadComplete);
                        this.BodyLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onConditionBodyLoadFailed);
                        _local_3 = new URLRequest(this.GetPathForCondition(_local_1.bodyId));
                        this.BodyLoader.load(_local_3);
                    };
                };
            }
            else
            {
                if (!this.IsMenuInstance)
                {
                    visible = false;
                    this.UnloadBody();
                };
            };
        }

        private function IsShowingCondition(_arg_1:Object):*
        {
            return ((((_arg_1) && (this.CurrentlyShownCondition)) && (_arg_1.headFrame == this.CurrentlyShownCondition.headFrame)) && (_arg_1.bodyId == this.CurrentlyShownCondition.bodyId));
        }

        private function LoadHead():*
        {
            if (this.HeadLoader)
            {
                this.HeadLoader.unloadAndStop();
            };
            this.HeadLoader = new PipboyLoader();
            var _local_1:URLRequest = new URLRequest(((this.monochrome) ? "Components/ConditionClips/Condition_Head_Mono.swf" : "Components/ConditionClips/Condition_Head.swf"));
            this.HeadLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onConditionHeadLoadComplete);
            this.HeadLoader.load(_local_1);
        }

        private function UnloadBody():*
        {
            if (this.BodyLoader)
            {
                try
                {
                    this.BodyLoader.close();
                }
                catch(e:Error)
                {
                };
            };
            if (this.BodyClip)
            {
                removeChild(this.BodyClip);
                this.BodyClip.stop();
                this.BodyClip = null;
            };
            if (this.BodyLoader)
            {
                this.BodyLoader.unload();
                this.BodyLoader = null;
            };
            this.CurrentlyShownCondition = {};
        }

        override public function redrawUIComponent():void
        {
            super.redrawUIComponent();
            if ((((this.BodyClip) && (this.HeadClip)) && (this.ShouldUpdate)))
            {
                visible = true;
                this.ShouldUpdate = false;
                this.BodyClip.Head_mc.addChild(this.HeadClip);
                this.BodyClip.scaleX = 1.2;
                this.BodyClip.scaleY = this.BodyClip.scaleX;
                addChild(this.BodyClip);
                this.BodyClip.play();
                this.HeadClip.gotoAndStop(this.CurrentlyShownCondition.headFrame);
                if (!this.IsMenuInstance)
                {
                    this.IsReadyForNextCondition = false;
                    setTimeout(function ():void
                    {
                        IsReadyForNextCondition = true;
                        ShowNextCondition();
                    }, CONDITION_DISPLAY_TIME);
                };
            };
        }

        private function onConditionBodyLoadComplete(_arg_1:Event):*
        {
            if (this.BodyLoader)
            {
                _arg_1.target.removeEventListener(Event.COMPLETE, this.onConditionBodyLoadComplete);
                _arg_1.target.removeEventListener(IOErrorEvent.IO_ERROR, this.onConditionBodyLoadFailed);
                this.BodyClip = (this.BodyLoader.contentLoaderInfo.content as MovieClip);
            }
            else
            {
                if (this.PreloadedBodyClips)
                {
                    this.BodyClip = (this.PreloadedBodyClips[this.CurrentlyShownCondition.bodyId].contentLoaderInfo.content as MovieClip);
                }
                else
                {
                    throw (new Error("onConditionBodyLoadComplete called but there is no loader nor preloaded clip to get info from"));
                };
            };
            this.ShouldUpdate = true;
            SetIsDirty();
        }

        private function onConditionBodyLoadFailed(_arg_1:IOErrorEvent):*
        {
            _arg_1.target.removeEventListener(Event.COMPLETE, this.onConditionBodyLoadComplete);
            _arg_1.target.removeEventListener(IOErrorEvent.IO_ERROR, this.onConditionBodyLoadFailed);
            trace(("failed to load body: " + this.GetPathForCondition(this.CurrentlyShownCondition.bodyId)));
            this.UnloadBody();
        }

        private function onConditionHeadLoadComplete(_arg_1:Event):*
        {
            if (this.HeadLoader)
            {
                _arg_1.target.removeEventListener(Event.COMPLETE, this.onConditionHeadLoadComplete);
                this.HeadClip = (this.HeadLoader.contentLoaderInfo.content as MovieClip);
                this.HeadLoader = null;
            };
        }


    }
}//package Shared.AS3

