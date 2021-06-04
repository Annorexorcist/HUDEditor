// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.specials.PropertyVolume

package aze.motion.specials
{
    import aze.motion.EazeTween;
    import flash.media.SoundMixer;
    import flash.media.SoundTransform;

    public class PropertyVolume extends EazeSpecial 
    {

        private var start:Number;
        private var delta:Number;
        private var vvalue:Number;
        private var targetVolume:Boolean;

        public function PropertyVolume(_arg_1:Object, _arg_2:*, _arg_3:*, _arg_4:EazeSpecial)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this.vvalue = _arg_3;
        }

        public static function register():void
        {
            EazeTween.specialProperties.volume = PropertyVolume;
        }


        override public function init(_arg_1:Boolean):void
        {
            var _local_3:Number;
            this.targetVolume = ("soundTransform" in target);
            var _local_2:SoundTransform = ((this.targetVolume) ? target.soundTransform : SoundMixer.soundTransform);
            if (_arg_1)
            {
                this.start = this.vvalue;
                _local_3 = _local_2.volume;
            }
            else
            {
                _local_3 = this.vvalue;
                this.start = _local_2.volume;
            };
            this.delta = (_local_3 - this.start);
        }

        override public function update(_arg_1:Number, _arg_2:Boolean):void
        {
            var _local_3:SoundTransform = ((this.targetVolume) ? target.soundTransform : SoundMixer.soundTransform);
            _local_3.volume = (this.start + (this.delta * _arg_1));
            if (this.targetVolume)
            {
                target.soundTransform = _local_3;
            }
            else
            {
                SoundMixer.soundTransform = _local_3;
            };
        }


    }
}//package aze.motion.specials

