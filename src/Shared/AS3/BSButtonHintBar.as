// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.BSButtonHintBar

package Shared.AS3
{
    import flash.display.MovieClip;
    import __AS3__.vec.Vector;
    import flash.events.Event;
    import Shared.AS3.COMPANIONAPP.CompanionAppMode;
    import Shared.AS3.COMPANIONAPP.MobileButtonHint;
    import flash.geom.Rectangle;
    import flash.display.Graphics;
    import __AS3__.vec.*;

    public dynamic class BSButtonHintBar extends BSUIComponent 
    {

        public static var BACKGROUND_COLOR:uint = 0;
        public static var BACKGROUND_ALPHA:Number = 0.4;
        public static var BACKGROUND_PAD:Number = 8;
        public static var BUTTON_SPACING:Number = 20;
        public static var BAR_Y_OFFSET:Number = 5;
        private static var ALIGN_CENTER:* = 0;
        private static var ALIGN_LEFT:* = 1;
        private static var ALIGN_RIGHT:* = 2;

        public var Sizer_mc:MovieClip;
        private var Alignment:int = 0;
        private var StartingXPos:int = 0;
        private var m_UseBackground:Boolean = true;
        private var ButtonHintBarInternal_mc:MovieClip;
        private var _buttonHintDataV:Vector.<BSButtonHintData>;
        private var ButtonPoolV:Vector.<BSButtonHint>;
        private var m_UseVaultTecColor:Boolean = true;
        private var _bRedirectToButtonBarMenu:Boolean = true;
        public var SetButtonHintData:Function;

        public function BSButtonHintBar()
        {
            this.SetButtonHintData = this.SetButtonHintData_Impl;
            super();
            visible = false;
            this.ButtonHintBarInternal_mc = new MovieClip();
            this.ButtonHintBarInternal_mc.y = BAR_Y_OFFSET;
            addChild(this.ButtonHintBarInternal_mc);
            this._buttonHintDataV = new Vector.<BSButtonHintData>();
            this.ButtonPoolV = new Vector.<BSButtonHint>();
            this.StartingXPos = this.x;
        }

        public function set useBackground(_arg_1:Boolean):void
        {
            this.m_UseBackground = _arg_1;
            SetIsDirty();
        }

        public function get useBackground():Boolean
        {
            return (this.m_UseBackground);
        }

        public function get bRedirectToButtonBarMenu_Inspectable():Boolean
        {
            return (this._bRedirectToButtonBarMenu);
        }

        public function set bRedirectToButtonBarMenu_Inspectable(_arg_1:Boolean):*
        {
            if (this._bRedirectToButtonBarMenu != _arg_1)
            {
                this._bRedirectToButtonBarMenu = _arg_1;
                SetIsDirty();
            };
        }

        public function get useVaultTecColor():Boolean
        {
            return (this.m_UseVaultTecColor);
        }

        public function set useVaultTecColor(_arg_1:Boolean):void
        {
            if (this.m_UseVaultTecColor != _arg_1)
            {
                this.m_UseVaultTecColor = _arg_1;
                SetIsDirty();
            };
        }

        public function set align(_arg_1:uint):*
        {
            this.Alignment = _arg_1;
            SetIsDirty();
        }

        private function CanBeVisible():Boolean
        {
            return ((!(this.bRedirectToButtonBarMenu_Inspectable)) || (!(bAcquiredByNativeCode)));
        }

        override public function onAcquiredByNativeCode():*
        {
            var _local_1:Vector.<BSButtonHintData>;
            super.onAcquiredByNativeCode();
            if (this.bRedirectToButtonBarMenu_Inspectable)
            {
                this.SetButtonHintData(this._buttonHintDataV);
                _local_1 = new Vector.<BSButtonHintData>();
                this.SetButtonHintData_Impl(_local_1);
                SetIsDirty();
            };
        }

        private function SetButtonHintData_Impl(abuttonHintDataV:Vector.<BSButtonHintData>):void
        {
            this._buttonHintDataV.forEach(function (_arg_1:BSButtonHintData, _arg_2:int, _arg_3:Vector.<BSButtonHintData>):*
            {
                if (_arg_1)
                {
                    _arg_1.removeEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
                };
            }, this);
            this._buttonHintDataV = abuttonHintDataV;
            this._buttonHintDataV.forEach(function (_arg_1:BSButtonHintData, _arg_2:int, _arg_3:Vector.<BSButtonHintData>):*
            {
                if (_arg_1)
                {
                    _arg_1.addEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE, this.onButtonHintDataDirtyEvent);
                };
            }, this);
            this.CreateButtonHints();
        }

        public function onButtonHintDataDirtyEvent(_arg_1:Event):void
        {
            SetIsDirty();
        }

        private function CreateButtonHints():*
        {
            visible = false;
            while (this.ButtonPoolV.length < this._buttonHintDataV.length)
            {
                if (CompanionAppMode.isOn)
                {
                    this.ButtonPoolV.push(new MobileButtonHint());
                }
                else
                {
                    this.ButtonPoolV.push(new BSButtonHint());
                };
            };
            var _local_1:int;
            while (_local_1 < this.ButtonPoolV.length)
            {
                this.ButtonPoolV[_local_1].ButtonHintData = ((_local_1 < this._buttonHintDataV.length) ? this._buttonHintDataV[_local_1] : null);
                _local_1++;
            };
            SetIsDirty();
        }

        override public function onAddedToStage():void
        {
            super.onAddedToStage();
        }

        override public function redrawUIComponent():void
        {
            var _local_4:BSButtonHint;
            super.redrawUIComponent();
            var _local_1:* = false;
            var _local_2:Number = 0;
            var _local_3:Number = 0;
            if (CompanionAppMode.isOn)
            {
                _local_3 = (stage.stageWidth - 75);
            };
            var _local_5:int = -1;
            var _local_6:Number = 0;
            while (_local_6 < this.ButtonPoolV.length)
            {
                _local_4 = this.ButtonPoolV[_local_6];
                if (((_local_4.ButtonVisible) && (this.CanBeVisible())))
                {
                    _local_1 = true;
                    _local_4.useVaultTecColor = this.useVaultTecColor;
                    _local_5 = _local_6;
                    if (!this.ButtonHintBarInternal_mc.contains(_local_4))
                    {
                        this.ButtonHintBarInternal_mc.addChild(_local_4);
                    };
                    if (_local_4.bIsDirty)
                    {
                        _local_4.redrawUIComponent();
                    };
                    if (((CompanionAppMode.isOn) && (_local_4.Justification == BSButtonHint.JUSTIFY_RIGHT)))
                    {
                        _local_3 = (_local_3 - _local_4.Sizer_mc.width);
                        _local_4.x = _local_3;
                    }
                    else
                    {
                        _local_4.x = _local_2;
                        _local_2 = (_local_2 + (_local_4.Sizer_mc.width + BUTTON_SPACING));
                    };
                }
                else
                {
                    if (this.ButtonHintBarInternal_mc.contains(_local_4))
                    {
                        this.ButtonHintBarInternal_mc.removeChild(_local_4);
                    };
                };
                _local_6++;
            };
            if (this.ButtonPoolV.length > this._buttonHintDataV.length)
            {
                this.ButtonPoolV.splice(this._buttonHintDataV.length, (this.ButtonPoolV.length - this._buttonHintDataV.length));
            };
            var _local_7:Rectangle = new Rectangle(0, 0, 0, 0);
            if (_local_5 >= 0)
            {
                _local_7.width = (this.ButtonPoolV[_local_5].x + this.ButtonPoolV[_local_5].Sizer_mc.width);
                _local_7.height = (this.ButtonPoolV[_local_5].y + this.ButtonPoolV[_local_5].Sizer_mc.height);
            };
            if (((this.Sizer_mc) && (this.ButtonHintBarInternal_mc.contains(this.Sizer_mc))))
            {
                this.ButtonHintBarInternal_mc.removeChild(this.Sizer_mc);
            };
            this.Sizer_mc = new MovieClip();
            var _local_8:Graphics = this.Sizer_mc.graphics;
            this.ButtonHintBarInternal_mc.addChildAt(this.Sizer_mc, 0);
            _local_8.clear();
            _local_8.beginFill(BACKGROUND_COLOR, ((this.m_UseBackground) ? BACKGROUND_ALPHA : 0));
            _local_8.drawRect(0, 0, (_local_7.width + BACKGROUND_PAD), _local_7.height);
            _local_8.endFill();
            this.Sizer_mc.x = (BACKGROUND_PAD * -0.5);
            if (!CompanionAppMode.isOn)
            {
                this.ButtonHintBarInternal_mc.x = (-(_local_7.width) / 2);
            };
            visible = _local_1;
            if (this.Alignment == ALIGN_LEFT)
            {
                this.x = (this.StartingXPos + (_local_7.width / 2));
            }
            else
            {
                if (this.Alignment != ALIGN_CENTER)
                {
                    if (this.Alignment == ALIGN_RIGHT)
                    {
                        this.x = (this.StartingXPos - (_local_7.width / 2));
                    };
                };
            };
        }


    }
}//package Shared.AS3

