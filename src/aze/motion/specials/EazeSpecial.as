// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.specials.EazeSpecial

package aze.motion.specials
{
    public class EazeSpecial 
    {

        protected var target:Object;
        protected var property:String;
        public var next:EazeSpecial;

        public function EazeSpecial(_arg_1:Object, _arg_2:*, _arg_3:*, _arg_4:EazeSpecial)
        {
            this.target = _arg_1;
            this.property = _arg_2;
            this.next = _arg_4;
        }

        public function init(_arg_1:Boolean):void
        {
        }

        public function update(_arg_1:Number, _arg_2:Boolean):void
        {
        }

        public function dispose():void
        {
            this.target = null;
            if (this.next)
            {
                this.next.dispose();
            };
            this.next = null;
        }


    }
}//package aze.motion.specials

