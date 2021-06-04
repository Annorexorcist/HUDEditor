// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//aze.motion.specials.PropertyRect

package aze.motion.specials
{
    import flash.geom.Rectangle;
    import aze.motion.EazeTween;

    public class PropertyRect extends EazeSpecial 
    {

        private var original:Rectangle;
        private var targetRect:Rectangle;
        private var tmpRect:Rectangle;

        public function PropertyRect(_arg_1:Object, _arg_2:*, _arg_3:*, _arg_4:EazeSpecial):void
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this.targetRect = (((_arg_3) && (_arg_3 is Rectangle)) ? _arg_3.clone() : new Rectangle());
        }

        public static function register():void
        {
            EazeTween.specialProperties["__rect"] = PropertyRect;
        }


        override public function init(_arg_1:Boolean):void
        {
            this.original = ((target[property] is Rectangle) ? (target[property].clone() as Rectangle) : new Rectangle(0, 0, target.width, target.height));
            if (_arg_1)
            {
                this.tmpRect = this.original;
                this.original = this.targetRect;
                this.targetRect = this.tmpRect;
            };
            this.tmpRect = new Rectangle();
        }

        override public function update(_arg_1:Number, _arg_2:Boolean):void
        {
            if (_arg_2)
            {
                target.scrollRect = this.targetRect;
            }
            else
            {
                this.tmpRect.x = (this.original.x + ((this.targetRect.x - this.original.x) * _arg_1));
                this.tmpRect.y = (this.original.y + ((this.targetRect.y - this.original.y) * _arg_1));
                this.tmpRect.width = (this.original.width + ((this.targetRect.width - this.original.width) * _arg_1));
                this.tmpRect.height = (this.original.height + ((this.targetRect.height - this.original.height) * _arg_1));
                target[property] = this.tmpRect;
            };
        }

        override public function dispose():void
        {
            this.original = (this.targetRect = (this.tmpRect = null));
            super.dispose();
        }


    }
}//package aze.motion.specials

