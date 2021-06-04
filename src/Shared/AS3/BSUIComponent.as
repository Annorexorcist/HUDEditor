// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.BSUIComponent

package Shared.AS3
{
    import Shared.AS3.Events.PlatformChangeEvent;
    import scaleform.gfx.Extensions;
    import flash.events.Event;
    import Shared.AS3.Events.PlatformRequestEvent;

    public dynamic class BSUIComponent extends BSDisplayObject 
    {

        private var _uiPlatform:uint;
        private var _bPS3Switch:Boolean;
        private var _uiController:uint;
        private var _uiKeyboard:uint;
        private var _bAcquiredByNativeCode:Boolean;

        public function BSUIComponent()
        {
            this._uiPlatform = PlatformChangeEvent.PLATFORM_INVALID;
            this._bPS3Switch = false;
            this._uiController = PlatformChangeEvent.PLATFORM_INVALID;
            this._uiKeyboard = PlatformChangeEvent.PLATFORM_INVALID;
            this._bAcquiredByNativeCode = false;
            Extensions.enabled = true;
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

        public function get bAcquiredByNativeCode():Boolean
        {
            return (this._bAcquiredByNativeCode);
        }

        public function onAcquiredByNativeCode():*
        {
            this._bAcquiredByNativeCode = true;
        }

        override public function redrawDisplayObject():void
        {
            try
            {
                this.redrawUIComponent();
            }
            catch(e:Error)
            {
                trace(((((this + " ") + this.name) + ": ") + e.getStackTrace()));
            };
        }

        final private function onSetPlatformEvent(_arg_1:Event):*
        {
            var _local_2:PlatformChangeEvent = (_arg_1 as PlatformChangeEvent);
            this.SetPlatform(_local_2.uiPlatform, _local_2.bPS3Switch, _local_2.uiController, _local_2.uiKeyboard);
        }

        override public function onAddedToStage():void
        {
            dispatchEvent(new PlatformRequestEvent(this));
            if (stage)
            {
                stage.addEventListener(PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatformEvent);
            };
        }

        override public function onRemovedFromStage():void
        {
            if (stage)
            {
                stage.removeEventListener(PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatformEvent);
            };
        }

        public function redrawUIComponent():void
        {
        }

        public function SetPlatform(_arg_1:uint, _arg_2:Boolean, _arg_3:uint, _arg_4:uint):void
        {
            if (((((!(this._uiPlatform == _arg_1)) || (!(this._bPS3Switch == _arg_2))) || (!(this._uiController == _arg_3))) || (!(this._uiKeyboard == _arg_4))))
            {
                this._uiPlatform = _arg_1;
                this._bPS3Switch = _arg_2;
                this._uiController = _arg_3;
                this._uiKeyboard = _arg_4;
                SetIsDirty();
            };
        }


    }
}//package Shared.AS3

