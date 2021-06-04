// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Events.CustomEvent

package Shared.AS3.Events
{
    import flash.events.Event;

    public class CustomEvent extends Event 
    {

        public static const ACTION_HOVERCHARACTER:String = "HoverCharacter";

        public var params:Object;

        public function CustomEvent(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this.params = _arg_2;
        }

        override public function clone():Event
        {
            return (new CustomEvent(type, this.params, bubbles, cancelable));
        }


    }
}//package Shared.AS3.Events

