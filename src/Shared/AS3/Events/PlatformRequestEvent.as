// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Events.PlatformRequestEvent

package Shared.AS3.Events
{
    import flash.events.Event;
    import flash.display.MovieClip;

    public class PlatformRequestEvent extends Event 
    {

        public static const PLATFORM_REQUEST:String = "GetPlatform";

        internal var _target:MovieClip;

        public function PlatformRequestEvent(_arg_1:MovieClip)
        {
            super(PLATFORM_REQUEST);
            this._target = _arg_1;
        }

        public function RespondToRequest(_arg_1:uint, _arg_2:Boolean, _arg_3:uint, _arg_4:uint):*
        {
            this._target.SetPlatform(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        override public function clone():Event
        {
            return (new PlatformRequestEvent(this._target));
        }


    }
}//package Shared.AS3.Events

