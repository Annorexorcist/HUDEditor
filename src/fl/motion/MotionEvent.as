// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//fl.motion.MotionEvent

package fl.motion
{
    import flash.events.Event;

    public class MotionEvent extends Event 
    {

        public static const MOTION_START:String = "motionStart";
        public static const MOTION_END:String = "motionEnd";
        public static const MOTION_UPDATE:String = "motionUpdate";
        public static const TIME_CHANGE:String = "timeChange";

        public function MotionEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        override public function clone():Event
        {
            return (new MotionEvent(this.type, this.bubbles, this.cancelable));
        }


    }
}//package fl.motion

