// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//fl.motion.AnimatorFactory3D

package fl.motion
{
    public class AnimatorFactory3D extends AnimatorFactoryBase 
    {

        public function AnimatorFactory3D(_arg_1:MotionBase, _arg_2:Array=null)
        {
            super(_arg_1, _arg_2);
            this._is3D = true;
        }

        override protected function getNewAnimator():AnimatorBase
        {
            return (new Animator3D(null, null));
        }


    }
}//package fl.motion

