// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//fl.transitions.TweenEvent

package fl.transitions
{
    import flash.events.Event;

    public class TweenEvent extends Event 
    {

        public static const MOTION_START:String = "motionStart";
        public static const MOTION_STOP:String = "motionStop";
        public static const MOTION_FINISH:String = "motionFinish";
        public static const MOTION_CHANGE:String = "motionChange";
        public static const MOTION_RESUME:String = "motionResume";
        public static const MOTION_LOOP:String = "motionLoop";

        public var time:Number = NaN;
        public var position:Number = NaN;

        public function TweenEvent(_arg_1:String, _arg_2:Number, _arg_3:Number, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(_arg_1, _arg_4, _arg_5);
            this.time = _arg_2;
            this.position = _arg_3;
        }

        override public function clone():Event
        {
            return (new TweenEvent(this.type, this.time, this.position, this.bubbles, this.cancelable));
        }


    }
}//package fl.transitions

