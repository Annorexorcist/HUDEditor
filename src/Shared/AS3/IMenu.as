// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.IMenu

package Shared.AS3
{
    import fl.motion.AdjustColor;
    import flash.filters.ColorMatrixFilter;
    import Shared.AS3.Events.PlatformChangeEvent;
    import Shared.GlobalFunc;
    import Shared.AS3.Events.PlatformRequestEvent;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import Shared.AS3.Events.MenuComponentLoadedEvent;
    import Shared.AS3.Data.BSUIDataManager;
    import Shared.AS3.Data.FromClientDataEvent;
    import flash.display.InteractiveObject;
    import flash.text.TextFormat;
    import flash.text.TextField;

    public class IMenu extends BSDisplayObject 
    {

        private var _uiPlatform:uint;
        private var _bPS3Switch:Boolean;
        private var _uiController:uint;
        private var _uiKeyboard:uint;
        private var _bNuclearWinterMode:Boolean;
        private var _bRestoreLostFocus:Boolean;
        private var safeX:Number = 0;
        private var safeY:Number = 0;
        private var textFieldSizeMap:Object;
        private var _ButtonHintBar:BSButtonHintBar;
        private var bOverrideColors:* = true;
        internal var colorFilter:AdjustColor;
        internal var mColorMatrix:ColorMatrixFilter;
        internal var mMatrix:Array;

        public function IMenu()
        {
            this.textFieldSizeMap = new Object();
            this.colorFilter = new AdjustColor();
            this.mMatrix = [];
            super();
            this._uiPlatform = PlatformChangeEvent.PLATFORM_INVALID;
            this._bPS3Switch = false;
            this._bRestoreLostFocus = false;
            this._bNuclearWinterMode = false;
            GlobalFunc.MaintainTextFormat();
            addEventListener(PlatformRequestEvent.PLATFORM_REQUEST, this.onPlatformRequestEvent, true);
        }

        public function get uiPlatform():uint
        {
            return (this._uiPlatform);
        }

        public function get bPS3Switch():Boolean
        {
            return (this._bPS3Switch);
        }

        public function get uiController():uint
        {
            return (this._uiController);
        }

        public function get uiKeyboard():uint
        {
            return (this._uiKeyboard);
        }

        public function get bNuclearWinterMode():Boolean
        {
            return (this._bNuclearWinterMode);
        }

        public function get SafeX():Number
        {
            return (this.safeX);
        }

        public function get SafeY():Number
        {
            return (this.safeY);
        }

        public function get buttonHintBar():BSButtonHintBar
        {
            return (this._ButtonHintBar);
        }

        public function set buttonHintBar(_arg_1:BSButtonHintBar):*
        {
            this._ButtonHintBar = _arg_1;
        }

        public function set overrideColors(_arg_1:Boolean):*
        {
            this.bOverrideColors = _arg_1;
        }

        public function get overrideColors():Boolean
        {
            return (this.bOverrideColors);
        }

        protected function onPlatformRequestEvent(_arg_1:Event):*
        {
            if (this.uiPlatform != PlatformChangeEvent.PLATFORM_INVALID)
            {
                (_arg_1 as PlatformRequestEvent).RespondToRequest(this.uiPlatform, this.bPS3Switch, this.uiController, this.uiKeyboard);
            };
        }

        override public function onAddedToStage():void
        {
            var menu:* = undefined;
            stage.stageFocusRect = false;
            stage.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusLostEvent);
            stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.onMouseFocusEvent);
            stage.addEventListener(MenuComponentLoadedEvent.MENU_COMPONENT_LOADED, this.OnMenuComponentLoadedEvent);
            menu = this;
            BSUIDataManager.Subscribe("HUDColors", function (_arg_1:FromClientDataEvent):*
            {
                if (!overrideColors)
                {
                    return;
                };
                var _local_2:* = _arg_1.data;
                if (((((_local_2.hue == 0) && (_local_2.saturation == 0)) && (_local_2.value == 0)) && (_local_2.contrast == 0)))
                {
                    menu.filters = null;
                }
                else
                {
                    colorFilter = new AdjustColor();
                    colorFilter.hue = _local_2.hue;
                    colorFilter.saturation = _local_2.saturation;
                    colorFilter.brightness = _local_2.value;
                    colorFilter.contrast = _local_2.contrast;
                    mMatrix = colorFilter.CalculateFinalFlatArray();
                    mColorMatrix = new ColorMatrixFilter(mMatrix);
                    menu.filters = [mColorMatrix];
                };
            });
        }

        override public function onRemovedFromStage():void
        {
            stage.removeEventListener(FocusEvent.FOCUS_OUT, this.onFocusLostEvent);
            stage.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, this.onMouseFocusEvent);
            stage.removeEventListener(MenuComponentLoadedEvent.MENU_COMPONENT_LOADED, this.OnMenuComponentLoadedEvent);
        }

        private function OnMenuComponentLoadedEvent(_arg_1:MenuComponentLoadedEvent):*
        {
            _arg_1.RespondToEvent(this);
        }

        public function SetPlatform(_arg_1:uint, _arg_2:Boolean, _arg_3:uint, _arg_4:uint):*
        {
            this._uiPlatform = _arg_1;
            this._bPS3Switch = this.bPS3Switch;
            this._uiController = _arg_3;
            this._uiKeyboard = _arg_4;
            dispatchEvent(new PlatformChangeEvent(this.uiPlatform, this.bPS3Switch, this.uiController, this.uiKeyboard));
        }

        public function SetNuclearWinterMode(_arg_1:Boolean):*
        {
            this._bNuclearWinterMode = _arg_1;
        }

        public function SetSafeRect(_arg_1:Number, _arg_2:Number):*
        {
            this.safeX = _arg_1;
            this.safeY = _arg_2;
            this.onSetSafeRect();
        }

        protected function onSetSafeRect():void
        {
        }

        private function onFocusLostEvent(_arg_1:FocusEvent):*
        {
            if (this._bRestoreLostFocus)
            {
                this._bRestoreLostFocus = false;
                stage.focus = (_arg_1.target as InteractiveObject);
            };
            this.onFocusLost(_arg_1);
        }

        public function onFocusLost(_arg_1:FocusEvent):*
        {
        }

        protected function onMouseFocusEvent(_arg_1:FocusEvent):*
        {
            if (((_arg_1.target == null) || (!(_arg_1.target is InteractiveObject))))
            {
                stage.focus = null;
            }
            else
            {
                this._bRestoreLostFocus = true;
            };
        }

        public function ShrinkFontToFit(_arg_1:TextField, _arg_2:int):*
        {
            var _local_5:int;
            var _local_3:TextFormat = _arg_1.getTextFormat();
            if (this.textFieldSizeMap[_arg_1] == null)
            {
                this.textFieldSizeMap[_arg_1] = _local_3.size;
            };
            _local_3.size = this.textFieldSizeMap[_arg_1];
            _arg_1.setTextFormat(_local_3);
            var _local_4:int = _arg_1.maxScrollV;
            while (((_local_4 > _arg_2) && (_local_3.size > 4)))
            {
                _local_5 = (_local_3.size as int);
                _local_3.size = (_local_5 - 1);
                _arg_1.setTextFormat(_local_3);
                _local_4 = _arg_1.maxScrollV;
            };
        }


    }
}//package Shared.AS3

