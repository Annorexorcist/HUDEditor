// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.specials.PropertyFrame

package aze.motion.specials
{
    import flash.display.MovieClip;
    import aze.motion.EazeTween;
    import flash.display.FrameLabel;

    public class PropertyFrame extends EazeSpecial 
    {

        private var start:int;
        private var delta:int;
        private var frameStart:*;
        private var frameEnd:*;

        public function PropertyFrame(_arg_1:Object, _arg_2:*, _arg_3:*, _arg_4:EazeSpecial)
        {
            var _local_6:Array;
            var _local_7:String;
            var _local_8:int;
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            var _local_5:MovieClip = MovieClip(_arg_1);
            if ((_arg_3 is String))
            {
                _local_7 = _arg_3;
                if (_local_7.indexOf("+") > 0)
                {
                    _local_6 = _local_7.split("+");
                    this.frameStart = _local_6[0];
                    this.frameEnd = _local_7;
                }
                else
                {
                    if (_local_7.indexOf(">") > 0)
                    {
                        _local_6 = _local_7.split(">");
                        this.frameStart = _local_6[0];
                        this.frameEnd = _local_6[1];
                    }
                    else
                    {
                        this.frameEnd = _local_7;
                    };
                };
            }
            else
            {
                _local_8 = int(_arg_3);
                if (_local_8 <= 0)
                {
                    _local_8 = (_local_8 + _local_5.totalFrames);
                };
                this.frameEnd = Math.max(1, Math.min(_local_5.totalFrames, _local_8));
            };
        }

        public static function register():void
        {
            EazeTween.specialProperties.frame = PropertyFrame;
        }


        override public function init(_arg_1:Boolean):void
        {
            var _local_2:MovieClip = MovieClip(target);
            if ((this.frameStart is String))
            {
                this.frameStart = this.findLabel(_local_2, this.frameStart);
            }
            else
            {
                this.frameStart = _local_2.currentFrame;
            };
            if ((this.frameEnd is String))
            {
                this.frameEnd = this.findLabel(_local_2, this.frameEnd);
            };
            if (_arg_1)
            {
                this.start = this.frameEnd;
                this.delta = (this.frameStart - this.start);
            }
            else
            {
                this.start = this.frameStart;
                this.delta = (this.frameEnd - this.start);
            };
            _local_2.gotoAndStop(this.start);
        }

        private function findLabel(_arg_1:MovieClip, _arg_2:String):int
        {
            var _local_3:FrameLabel;
            for each (_local_3 in _arg_1.currentLabels)
            {
                if (_local_3.name == _arg_2)
                {
                    return (_local_3.frame);
                };
            };
            return (1);
        }

        override public function update(_arg_1:Number, _arg_2:Boolean):void
        {
            var _local_3:MovieClip = MovieClip(target);
            _local_3.gotoAndStop(Math.round((this.start + (this.delta * _arg_1))));
        }

        public function getPreferredDuration():Number
        {
            var _local_1:MovieClip = MovieClip(target);
            var _local_2:Number = ((_local_1.stage) ? _local_1.stage.frameRate : 30);
            return (Math.abs((Number(this.delta) / _local_2)));
        }


    }
}//package aze.motion.specials

