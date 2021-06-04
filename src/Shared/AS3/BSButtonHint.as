// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.BSButtonHint

package Shared.AS3
{
    import flash.filters.ColorMatrixFilter;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.FrameLabel;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import Shared.AS3.Events.PlatformChangeEvent;
    import Shared.AS3.COMPANIONAPP.CompanionAppMode;
    import fl.motion.AdjustColor;
    import flash.text.TextFormat;
    import flash.utils.getDefinitionByName;
    import Shared.GlobalFunc;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;

    public dynamic class BSButtonHint extends BSUIComponent 
    {

        private static var colorMatrix:ColorMatrixFilter = null;
        private static const DISABLED_GREY_OUT_ALPHA:Number = 0.5;
        public static const JUSTIFY_RIGHT:uint = 0;
        public static const JUSTIFY_LEFT:uint = 1;
        public static const HOLD_TEXT_OFFSET:Number = 10;
        public static const HOLD_KEY_SCALE:Number = 1.25;
        private static const DYNAMIC_MOVIE_CLIP_BUFFER:* = 3;
        private static const NameToTextMap:Object = {
            "Xenon_A":"A",
            "Xenon_B":"B",
            "Xenon_X":"C",
            "Xenon_Y":"D",
            "Xenon_Select":"E",
            "Xenon_LS":"F",
            "Xenon_L1":"G",
            "Xenon_L3":"H",
            "Xenon_L2":"I",
            "Xenon_L2R2":"J",
            "Xenon_RS":"K",
            "Xenon_R1":"L",
            "Xenon_R3":"M",
            "Xenon_R2":"N",
            "Xenon_Start":"O",
            "Xenon_L1R1":"Z",
            "_Positive":"P",
            "_Negative":"Q",
            "_Question":"R",
            "_Neutral":"S",
            "Left":"T",
            "Right":"U",
            "Down":"V",
            "Up":"W",
            "Xenon_R2_Alt":"X",
            "Xenon_L2_Alt":"Y",
            "PSN_A":"a",
            "PSN_Y":"b",
            "PSN_X":"c",
            "PSN_B":"d",
            "PSN_Select":"z",
            "PSN_L3":"f",
            "PSN_L1":"g",
            "PSN_L1R1":"h",
            "PSN_LS":"i",
            "PSN_L2":"j",
            "PSN_L2R2":"k",
            "PSN_R3":"l",
            "PSN_R1":"m",
            "PSN_RS":"n",
            "PSN_R2":"o",
            "PSN_Start":"p",
            "_DPad_LR":"q",
            "_DPad_UD":"r",
            "_DPad_Left":"t",
            "_DPad_Right":"u",
            "_DPad_Down":"v",
            "_DPad_Up":"w",
            "PSN_R2_Alt":"x",
            "PSN_L2_Alt":"y"
        };
        private static const FRtoENMap:Object = {
            "A":"Q",
            "Q":"A",
            "W":"Z",
            "Z":"W",
            "-":")"
        };
        private static const BEtoENMap:Object = {
            "A":"Q",
            "Q":"A",
            "W":"Z",
            "Z":"W",
            "-":")",
            "=":"-"
        };
        private static const WarningColorMatrixFilter:ColorMatrixFilter = new ColorMatrixFilter(new Array(1, 0, 0, 0, -9, 0, 1, 0, 0, -141, 0, 0, 1, 0, -114, 0, 0, 0, 1, 0));

        public var textField_tf:TextField;
        public var IconHolderInstance:MovieClip;
        public var SecondaryIconHolderInstance:MovieClip;
        public var HoldMeter_mc:MovieClip;
        public var Sizer_mc:MovieClip;
        private var m_CanHold:Boolean = false;
        private var m_HoldPercent:Number = 0;
        private var m_HoldFrames:int = 25;
        private var m_HoldStartFrame:int = 0;
        private var m_UseVaultTecColor:Boolean = false;
        private var _hitArea:Sprite;
        private var DynamicMovieClip:MovieClip;
        private var bButtonFlashing:Boolean;
        private var _strCurrentDynamicMovieClipName:String;
        private var _DyanmicMovieHeight:Number;
        private var _DynamicMovieY:Number;
        private var _buttonHintData:BSButtonHintData;
        internal var _bButtonPressed:Boolean = false;
        internal var _bMouseOver:Boolean = false;

        public function BSButtonHint()
        {
            var _local_1:Array;
            var _local_2:FrameLabel;
            var _local_3:Boolean;
            var _local_4:uint;
            super();
            visible = false;
            mouseChildren = false;
            this.bButtonFlashing = false;
            this._strCurrentDynamicMovieClipName = "";
            this.DynamicMovieClip = null;
            this._DyanmicMovieHeight = this.textField_tf.height;
            this._DynamicMovieY = this.textField_tf.y;
            this.SetUpTextFields(this.textField_tf);
            this.SetUpTextFields(this.IconHolderInstance.IconAnimInstance.Icon_tf);
            this.SetUpTextFields(this.SecondaryIconHolderInstance.IconAnimInstance.Icon_tf);
            this._hitArea = new Sprite();
            this._hitArea.graphics.beginFill(0);
            this._hitArea.graphics.drawRect(0, 0, 1, 1);
            this._hitArea.graphics.endFill();
            this._hitArea.visible = false;
            this._hitArea.mouseEnabled = false;
            addEventListener(MouseEvent.CLICK, this.onTextClick);
            addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, this.onMouseOut);
            if (this.HoldMeter_mc != null)
            {
                _local_1 = this.HoldMeter_mc.currentLabels;
                _local_3 = false;
                _local_4 = 1;
                while (_local_4 < _local_1.length)
                {
                    _local_2 = (_local_1[_local_4] as FrameLabel);
                    if (_local_3)
                    {
                        this.m_HoldFrames = ((_local_2.frame - this.m_HoldStartFrame) - 1);
                        return;
                    };
                    if (_local_2.name == "buttonHold")
                    {
                        _local_3 = true;
                        this.m_HoldStartFrame = _local_2.frame;
                    };
                    _local_4++;
                };
            };
        }

        public function set ButtonHintData(_arg_1:BSButtonHintData):void
        {
            if (this._buttonHintData)
            {
                this._buttonHintData.removeEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
            };
            this._buttonHintData = _arg_1;
            if (this._buttonHintData)
            {
                this._buttonHintData.addEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
            };
            SetIsDirty();
        }

        private function onButtonHintDataDirtyEvent(_arg_1:Event):void
        {
            SetIsDirty();
        }

        public function get PCKey():String
        {
            var _local_1:String;
            if (this._buttonHintData.PCKey)
            {
                _local_1 = this._buttonHintData.PCKey;
                _local_1 = this.TranslateKey(_local_1);
                return ((this.Justification == JUSTIFY_LEFT) ? (_local_1 + ")") : ("(" + _local_1));
            };
            return ("");
        }

        public function get SecondaryPCKey():String
        {
            var _local_1:String;
            if (this._buttonHintData.SecondaryPCKey)
            {
                _local_1 = this._buttonHintData.SecondaryPCKey;
                _local_1 = this.TranslateKey(_local_1);
                return ("(" + _local_1);
            };
            return ("");
        }

        private function TranslateKey(_arg_1:String):String
        {
            switch (uiKeyboard)
            {
                case PlatformChangeEvent.PLATFORM_PC_KB_FR:
                    if (FRtoENMap.hasOwnProperty(_arg_1))
                    {
                        _arg_1 = FRtoENMap[_arg_1];
                    };
                    break;
                case PlatformChangeEvent.PLATFORM_PC_KB_BE:
                    if (BEtoENMap.hasOwnProperty(_arg_1))
                    {
                        _arg_1 = BEtoENMap[_arg_1];
                    };
                    break;
            };
            return (_arg_1);
        }

        private function get UsePCKey():Boolean
        {
            return ((uiController == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE) && (!(NameToTextMap.hasOwnProperty(this._buttonHintData.PCKey))));
        }

        public function get ControllerButton():String
        {
            var _local_1:* = "";
            if (((!(uiController == PlatformChangeEvent.PLATFORM_MOBILE)) && (this.UsePCKey)))
            {
                _local_1 = this.PCKey;
            }
            else
            {
                switch (uiController)
                {
                    case PlatformChangeEvent.PLATFORM_PC_KB_MOUSE:
                        _local_1 = this._buttonHintData.PCKey;
                        break;
                    case PlatformChangeEvent.PLATFORM_PC_GAMEPAD:
                    case PlatformChangeEvent.PLATFORM_XB1:
                    default:
                        _local_1 = this._buttonHintData.XenonButton;
                        break;
                    case PlatformChangeEvent.PLATFORM_PS4:
                        _local_1 = this._buttonHintData.PSNButton;
                        break;
                    case PlatformChangeEvent.PLATFORM_MOBILE:
                        _local_1 = "";
                };
                if (NameToTextMap.hasOwnProperty(_local_1))
                {
                    _local_1 = NameToTextMap[_local_1];
                };
            };
            return (_local_1);
        }

        public function get SecondaryControllerButton():String
        {
            var _local_1:* = "";
            if (this._buttonHintData.hasSecondaryButton)
            {
                if (((!(uiController == PlatformChangeEvent.PLATFORM_MOBILE)) && (this.UsePCKey)))
                {
                    _local_1 = this.SecondaryPCKey;
                }
                else
                {
                    switch (uiController)
                    {
                        case PlatformChangeEvent.PLATFORM_PC_KB_MOUSE:
                            _local_1 = this._buttonHintData.SecondaryPCKey;
                            break;
                        case PlatformChangeEvent.PLATFORM_PC_GAMEPAD:
                        case PlatformChangeEvent.PLATFORM_XB1:
                        default:
                            _local_1 = this._buttonHintData.SecondaryXenonButton;
                            break;
                        case PlatformChangeEvent.PLATFORM_PS4:
                            _local_1 = this._buttonHintData.SecondaryPSNButton;
                            break;
                        case PlatformChangeEvent.PLATFORM_MOBILE:
                            _local_1 = "";
                    };
                    if (NameToTextMap.hasOwnProperty(_local_1))
                    {
                        _local_1 = NameToTextMap[_local_1];
                    };
                };
            };
            return (_local_1);
        }

        public function get ButtonText():String
        {
            return (this._buttonHintData.ButtonText);
        }

        public function get Justification():uint
        {
            if (CompanionAppMode.isOn)
            {
                return ((this._buttonHintData != null) ? this._buttonHintData.Justification : JUSTIFY_LEFT);
            };
            return (this._buttonHintData.Justification);
        }

        public function get ButtonDisabled():Boolean
        {
            return (this._buttonHintData.ButtonDisabled);
        }

        public function get SecondaryButtonDisabled():Boolean
        {
            return (this._buttonHintData.SecondaryButtonDisabled);
        }

        public function get AllButtonsDisabled():Boolean
        {
            return ((this.ButtonDisabled) && ((!(this._buttonHintData.hasSecondaryButton)) || (this.SecondaryButtonDisabled)));
        }

        public function get ButtonVisible():Boolean
        {
            return ((this._buttonHintData) && (this._buttonHintData.ButtonVisible));
        }

        public function get UseDynamicMovieClip():Boolean
        {
            return (this._buttonHintData.DynamicMovieClipName.length > 0);
        }

        public function onTextClick(_arg_1:Event):void
        {
            var _local_2:*;
            var _local_3:*;
            if (this.ButtonVisible)
            {
                _local_2 = (!(this.ButtonDisabled));
                _local_3 = false;
                if (((this._buttonHintData.SecondaryPCKey) && ((_arg_1 as MouseEvent).localX > (this._hitArea.width / 2))))
                {
                    _local_2 = false;
                    _local_3 = (!(this.SecondaryButtonDisabled));
                };
                if (_local_2)
                {
                    this._buttonHintData.onTextClick();
                }
                else
                {
                    if (_local_3)
                    {
                        this._buttonHintData.onSecondaryButtonClick();
                    };
                };
            };
        }

        public function get bButtonPressed():Boolean
        {
            return (this._bButtonPressed);
        }

        public function set bButtonPressed(_arg_1:Boolean):*
        {
            if (this._bButtonPressed != _arg_1)
            {
                this._bButtonPressed = _arg_1;
                SetIsDirty();
            };
        }

        public function get bMouseOver():Boolean
        {
            return (this._bMouseOver);
        }

        public function set bMouseOver(_arg_1:Boolean):*
        {
            if (this._bMouseOver != _arg_1)
            {
                this._bMouseOver = _arg_1;
                SetIsDirty();
            };
        }

        private function onMouseOver(_arg_1:MouseEvent):*
        {
            this.bMouseOver = true;
        }

        protected function onMouseOut(_arg_1:MouseEvent):*
        {
            this.bMouseOver = false;
        }

        public function get useVaultTecColor():Boolean
        {
            return (this.m_UseVaultTecColor);
        }

        public function set useVaultTecColor(_arg_1:Boolean):void
        {
            var _local_2:AdjustColor;
            var _local_3:Array;
            if (_arg_1 != this.m_UseVaultTecColor)
            {
                this.m_UseVaultTecColor = _arg_1;
                if (_arg_1)
                {
                    if (colorMatrix == null)
                    {
                        _local_2 = new AdjustColor();
                        _local_2.brightness = 100;
                        _local_2.contrast = 0;
                        _local_2.saturation = -77;
                        _local_2.hue = -55;
                        _local_3 = _local_2.CalculateFinalFlatArray();
                        colorMatrix = new ColorMatrixFilter(_local_3);
                    };
                    this.HoldMeter_mc.filters = [colorMatrix];
                    this.textField_tf.textColor = 16777163;
                    this.IconHolderInstance.IconAnimInstance.Icon_tf.textColor = 16777163;
                    this.SecondaryIconHolderInstance.IconAnimInstance.Icon_tf.textColor = 16777163;
                }
                else
                {
                    this.HoldMeter_mc.filters = null;
                    this.textField_tf.textColor = 0xFF00;
                    this.IconHolderInstance.IconAnimInstance.Icon_tf.textColor = 0xFF00;
                    this.SecondaryIconHolderInstance.IconAnimInstance.Icon_tf.textColor = 0xFF00;
                };
            };
        }

        public function set canHold(_arg_1:Boolean):void
        {
            this.m_CanHold = _arg_1;
        }

        public function set holdPercent(_arg_1:Number):void
        {
            if (_arg_1 != this.m_HoldPercent)
            {
                this.m_HoldPercent = _arg_1;
                this.redrawHoldIndicator();
            };
        }

        private function redrawHoldIndicator():void
        {
            if (this.HoldMeter_mc != null)
            {
                if (this.m_CanHold)
                {
                    this.HoldMeter_mc.visible = true;
                    if (this.m_HoldPercent >= 1)
                    {
                        this.HoldMeter_mc.gotoAndPlay("buttonHoldComplete");
                    }
                    else
                    {
                        if (this.m_HoldPercent > 0)
                        {
                            this.HoldMeter_mc.gotoAndStop((this.m_HoldStartFrame + Math.floor((this.m_HoldFrames * this.m_HoldPercent))));
                        }
                        else
                        {
                            this.HoldMeter_mc.gotoAndStop("idle");
                        };
                    };
                }
                else
                {
                    this.HoldMeter_mc.visible = false;
                };
            };
        }

        override public function redrawUIComponent():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Array;
            var _local_6:uint;
            super.redrawUIComponent();
            hitArea = null;
            if (contains(this._hitArea))
            {
                removeChild(this._hitArea);
            };
            visible = this.ButtonVisible;
            if (visible)
            {
                this.canHold = this._buttonHintData.canHold;
                this.holdPercent = this._buttonHintData.holdPercent;
                this.redrawPrimaryButton();
                this.redrawDynamicMovieClip();
                this.redrawTextField();
                this.redrawSecondaryButton();
                this.SetFlashing(this._buttonHintData.ButtonFlashing);
                this.redrawHoldIndicator();
                this.updateButtonHintFilters();
                if (this.m_CanHold)
                {
                    this.HoldMeter_mc.x = (this.IconHolderInstance.x + (this.IconHolderInstance.width / 2));
                    this.HoldMeter_mc.scaleX = ((this.UsePCKey) ? HOLD_KEY_SCALE : 1);
                    this.HoldMeter_mc.scaleY = ((this.UsePCKey) ? HOLD_KEY_SCALE : 1);
                };
                this.redrawHitArea();
                addChild(this._hitArea);
                hitArea = this._hitArea;
                _local_1 = 0;
                _local_2 = 0;
                _local_3 = 0;
                _local_4 = 0;
                _local_5 = [this.IconHolderInstance, this.SecondaryIconHolderInstance, this.textField_tf];
                _local_6 = 0;
                while (_local_6 < _local_5.length)
                {
                    _local_2 = Math.max(_local_2, (_local_5[_local_6].x + _local_5[_local_6].width));
                    _local_4 = Math.max(_local_4, (_local_5[_local_6].y + _local_5[_local_6].height));
                    _local_6++;
                };
                this.Sizer_mc.x = _local_1;
                this.Sizer_mc.y = _local_3;
                this.Sizer_mc.width = (_local_2 - _local_1);
                this.Sizer_mc.height = (_local_4 - _local_3);
            };
        }

        public function SetFlashing(_arg_1:Boolean):*
        {
            if (_arg_1 != this.bButtonFlashing)
            {
                this.bButtonFlashing = _arg_1;
                this.IconHolderInstance.gotoAndPlay(((_arg_1) ? "Flashing" : "Default"));
            };
        }

        private function UpdateIconTextField(_arg_1:TextField, _arg_2:String):*
        {
            var _local_6:*;
            _arg_1.text = _arg_2;
            var _local_3:String = this.GetExpectedFont();
            var _local_4:String = _arg_1.getTextFormat().font;
            if (_local_3 != _local_4)
            {
                _local_6 = new TextFormat(_local_3);
                _arg_1.setTextFormat(_local_6);
            };
            var _local_5:Number = ((this.UsePCKey) ? 1.25 : 2.25);
            if (_arg_1.y != _local_5)
            {
                _arg_1.y = _local_5;
            };
        }

        private function redrawDynamicMovieClip():void
        {
            var _local_1:Class;
            var _local_2:Number;
            if (this._buttonHintData.DynamicMovieClipName != this._strCurrentDynamicMovieClipName)
            {
                if (this.DynamicMovieClip)
                {
                    removeChild(this.DynamicMovieClip);
                };
                if (this.UseDynamicMovieClip)
                {
                    _local_1 = (getDefinitionByName(this._buttonHintData.DynamicMovieClipName) as Class);
                    this.DynamicMovieClip = new ((_local_1 as Class))();
                    addChild(this.DynamicMovieClip);
                    _local_2 = (this._DyanmicMovieHeight / this.DynamicMovieClip.height);
                    this.DynamicMovieClip.scaleX = _local_2;
                    this.DynamicMovieClip.scaleY = _local_2;
                    this.DynamicMovieClip.alpha = ((this.AllButtonsDisabled) ? DISABLED_GREY_OUT_ALPHA : 1);
                    this.DynamicMovieClip.x = ((this.Justification == JUSTIFY_LEFT) ? (this.IconHolderInstance.width + DYNAMIC_MOVIE_CLIP_BUFFER) : ((this.IconHolderInstance.x - this.DynamicMovieClip.width) - DYNAMIC_MOVIE_CLIP_BUFFER));
                    this.DynamicMovieClip.y = this._DynamicMovieY;
                };
            };
        }

        private function redrawTextField():void
        {
            var _local_1:*;
            this.textField_tf.visible = (!(this.UseDynamicMovieClip));
            if (this.textField_tf.visible)
            {
                GlobalFunc.SetText(this.textField_tf, this.ButtonText, false, true, false);
                this.textField_tf.alpha = ((this.AllButtonsDisabled) ? DISABLED_GREY_OUT_ALPHA : 1);
                _local_1 = ((this.m_CanHold) ? HOLD_TEXT_OFFSET : 0);
                this.textField_tf.x = ((this.Justification == JUSTIFY_LEFT) ? (this.IconHolderInstance.width + _local_1) : ((this.IconHolderInstance.x - this.textField_tf.width) - _local_1));
            };
        }

        private function redrawSecondaryButton():void
        {
            this.SecondaryIconHolderInstance.visible = this._buttonHintData.hasSecondaryButton;
            if (this.SecondaryIconHolderInstance.visible)
            {
                this.UpdateIconTextField(this.SecondaryIconHolderInstance.IconAnimInstance.Icon_tf, this.SecondaryControllerButton);
                this.SecondaryIconHolderInstance.alpha = ((this.SecondaryButtonDisabled) ? DISABLED_GREY_OUT_ALPHA : 1);
                this.SecondaryIconHolderInstance.x = ((this.UseDynamicMovieClip) ? ((this.DynamicMovieClip.x + this.DynamicMovieClip.width) + DYNAMIC_MOVIE_CLIP_BUFFER) : (this.textField_tf.x + this.textField_tf.width));
            };
        }

        private function redrawPrimaryButton():void
        {
            this.UpdateIconTextField(this.IconHolderInstance.IconAnimInstance.Icon_tf, this.ControllerButton);
            this.IconHolderInstance.alpha = ((this.ButtonDisabled) ? DISABLED_GREY_OUT_ALPHA : 1);
            this.IconHolderInstance.x = ((this.Justification == JUSTIFY_LEFT) ? 0 : -(this.IconHolderInstance.width));
        }

        private function redrawHitArea():void
        {
            var _local_1:* = this.getBounds(this);
            this._hitArea.x = _local_1.x;
            this._hitArea.width = _local_1.width;
            this._hitArea.y = _local_1.y;
            this._hitArea.height = _local_1.height;
        }

        private function GetExpectedFont():String
        {
            var _local_1:String;
            var _local_2:Boolean;
            if (this.UsePCKey)
            {
                _local_1 = "$MAIN_Font";
            }
            else
            {
                _local_2 = ((!(this.bMouseOver)) && (!(this.bButtonPressed)));
                _local_1 = ((_local_2) ? "$Controller_buttons" : "$Controller_buttons_inverted");
            };
            return (_local_1);
        }

        private function SetUpTextFields(_arg_1:TextField):*
        {
            _arg_1.autoSize = TextFieldAutoSize.LEFT;
            _arg_1.antiAliasType = AntiAliasType.NORMAL;
        }

        private function updateButtonHintFilters():void
        {
            var _local_1:* = this.filters.indexOf(WarningColorMatrixFilter);
            if (this._buttonHintData.IsWarning)
            {
                this.filters = [WarningColorMatrixFilter];
            }
            else
            {
                this.filters = [];
            };
        }


    }
}//package Shared.AS3

