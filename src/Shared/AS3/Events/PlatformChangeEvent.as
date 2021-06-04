// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Events.PlatformChangeEvent

package Shared.AS3.Events
{
    import flash.events.Event;

    public class PlatformChangeEvent extends Event 
    {

        public static const PLATFORM_PC_KB_MOUSE:uint = 0;
        public static const PLATFORM_PC_GAMEPAD:uint = 1;
        public static const PLATFORM_XB1:uint = 2;
        public static const PLATFORM_PS4:uint = 3;
        public static const PLATFORM_MOBILE:uint = 4;
        public static const PLATFORM_INVALID:uint = uint.MAX_VALUE;//0xFFFFFFFF
        public static const PLATFORM_PC_KB_ENG:uint = 0;
        public static const PLATFORM_PC_KB_FR:uint = 1;
        public static const PLATFORM_PC_KB_BE:uint = 2;
        public static const PLATFORM_CHANGE:String = "SetPlatform";

        internal var _uiPlatform:uint = 0xFFFFFFFF;
        internal var _bPS3Switch:Boolean = false;
        internal var _uiController:uint = 0xFFFFFFFF;
        internal var _uiKeyboard:uint = 0xFFFFFFFF;

        public function PlatformChangeEvent(_arg_1:uint, _arg_2:Boolean, _arg_3:uint, _arg_4:uint)
        {
            super(PLATFORM_CHANGE, true, true);
            this.uiPlatform = _arg_1;
            this.bPS3Switch = _arg_2;
            this.uiController = _arg_3;
            this.uiKeyboard = _arg_4;
        }

        public function get uiPlatform():*
        {
            return (this._uiPlatform);
        }

        public function set uiPlatform(_arg_1:uint):*
        {
            this._uiPlatform = _arg_1;
        }

        public function get bPS3Switch():*
        {
            return (this._bPS3Switch);
        }

        public function set bPS3Switch(_arg_1:Boolean):*
        {
            this._bPS3Switch = _arg_1;
        }

        public function get uiController():*
        {
            return (this._uiController);
        }

        public function set uiController(_arg_1:uint):*
        {
            this._uiController = _arg_1;
        }

        public function get uiKeyboard():*
        {
            return (this._uiKeyboard);
        }

        public function set uiKeyboard(_arg_1:uint):*
        {
            this._uiKeyboard = _arg_1;
        }

        override public function clone():Event
        {
            return (new PlatformChangeEvent(this.uiPlatform, this.bPS3Switch, this.uiController, this.uiKeyboard));
        }


    }
}//package Shared.AS3.Events

