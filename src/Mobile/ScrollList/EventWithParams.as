// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Mobile.ScrollList.EventWithParams

package Mobile.ScrollList
{
    import flash.events.Event;
    import flash.utils.getQualifiedClassName;

    public class EventWithParams extends Event 
    {

        public var params:Object;

        public function EventWithParams(_arg_1:String, _arg_2:Object=null, _arg_3:Boolean=false, _arg_4:Boolean=false)
        {
            super(_arg_1, _arg_3, _arg_4);
            this.params = _arg_2;
        }

        override public function clone():Event
        {
            return (new EventWithParams(type, this.params, bubbles, cancelable));
        }

        override public function toString():String
        {
            return (formatToString(getQualifiedClassName(this), "type", "bubbles", "cancelable", "eventPhase", "params"));
        }


    }
}//package Mobile.ScrollList

