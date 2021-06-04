// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.easing.Quadratic

package aze.motion.easing
{
    public final class Quadratic 
    {


        public static function easeIn(_arg_1:Number):Number
        {
            return (_arg_1 * _arg_1);
        }

        public static function easeOut(_arg_1:Number):Number
        {
            return (-(_arg_1) * (_arg_1 - 2));
        }

        public static function easeInOut(_arg_1:Number):Number
        {
            if ((_arg_1 = (_arg_1 * 2)) < 1)
            {
                return ((0.5 * _arg_1) * _arg_1);
            };
            return (-0.5 * ((--_arg_1 * (_arg_1 - 2)) - 1));
        }


    }
}//package aze.motion.easing

