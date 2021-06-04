// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Events.NetworkedUIEvent

package Shared.AS3.Events
{
    import flash.events.Event;

    public class NetworkedUIEvent extends Event 
    {

        private var _EventType:String = "blank";
        private var _EventSender:String = "data";
        private var _EventTarget:String = "for";
        private var _EventData:String = "testing";

        public function NetworkedUIEvent(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:Boolean=false, _arg_7:Boolean=false)
        {
            this._EventType = _arg_2;
            this._EventSender = _arg_3;
            this._EventTarget = _arg_4;
            this._EventData = _arg_5;
            super(_arg_1, _arg_6, _arg_7);
        }

        override public function clone():Event
        {
            return (new NetworkedUIEvent(type, this._EventType, this._EventSender, this._EventTarget, this._EventData, bubbles, cancelable));
        }

        public function get EventType():String
        {
            return (this._EventType);
        }

        public function get EventSender():String
        {
            return (this._EventSender);
        }

        public function get EventTarget():String
        {
            return (this._EventTarget);
        }

        public function get EventData():String
        {
            return (this._EventData);
        }


    }
}//package Shared.AS3.Events

