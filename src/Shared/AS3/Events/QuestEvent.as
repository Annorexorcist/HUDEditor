// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Events.QuestEvent

package Shared.AS3.Events
{
    import flash.events.Event;

    public class QuestEvent extends Event 
    {

        public static const EVENT_COMPLETE:String = "QuestComplete";
        public static const EVENT_AVAILABLE:String = "QuestAvailable";
        public static const EVENT_ACCEPTED:String = "QuestAccepted";

        private var m_Data:Object;
        public var pvpFlag:Boolean;

        public function QuestEvent(_arg_1:String, _arg_2:Object, _arg_3:Boolean=false, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            this.m_Data = _arg_2;
            this.pvpFlag = _arg_5;
            super(_arg_1, _arg_3, _arg_4);
        }

        public function get data():Object
        {
            return (this.m_Data);
        }

        override public function clone():Event
        {
            return (new QuestEvent(type, this.data, bubbles, cancelable));
        }


    }
}//package Shared.AS3.Events

