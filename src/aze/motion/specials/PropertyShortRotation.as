// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.specials.PropertyShortRotation

package aze.motion.specials
{
    import aze.motion.EazeTween;

    public class PropertyShortRotation extends EazeSpecial 
    {

        private var fvalue:Number;
        private var radius:Number;
        private var start:Number;
        private var delta:Number;

        public function PropertyShortRotation(_arg_1:Object, _arg_2:*, _arg_3:*, _arg_4:EazeSpecial)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this.fvalue = _arg_3[0];
            this.radius = ((_arg_3[1]) ? Math.PI : 180);
        }

        public static function register():void
        {
            EazeTween.specialProperties["__short"] = PropertyShortRotation;
        }


        override public function init(_arg_1:Boolean):void
        {
            var _local_2:Number;
            this.start = target[property];
            if (_arg_1)
            {
                _local_2 = this.start;
                target[property] = (this.start = this.fvalue);
            }
            else
            {
                _local_2 = this.fvalue;
            };
            while ((_local_2 - this.start) > this.radius)
            {
                this.start = (this.start + (this.radius * 2));
            };
            while ((_local_2 - this.start) < -(this.radius))
            {
                this.start = (this.start - (this.radius * 2));
            };
            this.delta = (_local_2 - this.start);
        }

        override public function update(_arg_1:Number, _arg_2:Boolean):void
        {
            target[property] = (this.start + (_arg_1 * this.delta));
        }


    }
}//package aze.motion.specials

