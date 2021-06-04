// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.SWFLoaderClip

package Shared.AS3
{
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.system.ApplicationDomain;
    import flash.utils.getDefinitionByName;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    public class SWFLoaderClip extends MovieClip 
    {

        internal var SWF:DisplayObject;
        internal var menuLoader:Loader;
        protected var ClipAlpha:Number = 0.65;
        protected var ClipScale:Number = 0.5;
        protected var ClipRotation:Number = 0;
        protected var ClipWidth:Number = 0;
        protected var ClipHeight:Number = 0;
        protected var ClipXOffset:Number = 0;
        protected var ClipYOffset:Number = 0;
        protected var CenterClip:Boolean = false;
        internal var AltMenuName:String;

        public function SWFLoaderClip()
        {
            this.AltMenuName = new String();
            super();
            this.SWF = null;
            this.menuLoader = new Loader();
        }

        private function getIconClip(_arg_1:String, _arg_2:String="", _arg_3:String=null):MovieClip
        {
            var _local_4:Object;
            var _local_5:MovieClip;
            if (((!(_arg_3 == null)) && ((_arg_1 == null) || (_arg_1.length <= 0))))
            {
                _arg_1 = _arg_3;
            };
            if (((!(_arg_1 == null)) && (_arg_1.length > 0)))
            {
                this.forceUnload();
                if (ApplicationDomain.currentDomain.hasDefinition(_arg_1))
                {
                    _local_4 = (getDefinitionByName(_arg_1) as Class);
                    if (_local_4 != null)
                    {
                        _local_5 = (new (_local_4)() as MovieClip);
                        return (_local_5);
                    };
                }
                else
                {
                    this.SWFLoad((_arg_2 + _arg_1));
                };
            };
            return (null);
        }

        public function setContainerIconClip(_arg_1:String, _arg_2:String="", _arg_3:String=null):MovieClip
        {
            var _local_4:MovieClip = this.getIconClip(_arg_1, _arg_2, _arg_3);
            if (_local_4 != null)
            {
                addChild(_local_4);
                _local_4.scaleX = this.ClipScale;
                _local_4.scaleY = this.ClipScale;
                if (this.ClipWidth != 0)
                {
                    _local_4.width = this.ClipWidth;
                };
                if (this.ClipHeight != 0)
                {
                    _local_4.height = this.ClipHeight;
                };
                _local_4.x = (_local_4.x + this.ClipXOffset);
                _local_4.y = (_local_4.y + this.ClipYOffset);
            }
            else
            {
                trace((("Invalid Icon: Could not find image for path '" + _arg_1) + "'"));
            };
            return (_local_4);
        }

        public function set clipAlpha(_arg_1:Number):*
        {
            this.ClipAlpha = _arg_1;
        }

        public function set clipScale(_arg_1:Number):*
        {
            this.ClipScale = _arg_1;
        }

        public function set clipRotation(_arg_1:Number):*
        {
            this.ClipRotation = _arg_1;
        }

        public function set clipWidth(_arg_1:Number):*
        {
            this.ClipWidth = _arg_1;
        }

        public function set clipHeight(_arg_1:Number):*
        {
            this.ClipHeight = _arg_1;
        }

        public function get clipWidth():Number
        {
            return (this.ClipWidth);
        }

        public function get clipHeight():Number
        {
            return (this.ClipHeight);
        }

        public function get clipScale():Number
        {
            return (this.ClipScale);
        }

        public function set clipYOffset(_arg_1:Number):*
        {
            this.ClipYOffset = _arg_1;
        }

        public function get clipYOffset():Number
        {
            return (this.ClipYOffset);
        }

        public function set clipXOffset(_arg_1:Number):*
        {
            this.ClipXOffset = _arg_1;
        }

        public function get clipXOffset():Number
        {
            return (this.ClipXOffset);
        }

        public function set centerClip(_arg_1:Boolean):*
        {
            this.CenterClip = _arg_1;
        }

        public function get centerClip():Boolean
        {
            return (this.CenterClip);
        }

        public function forceUnload():*
        {
            if (this.SWF)
            {
                this.SWFUnload(this.SWF);
            };
            while (numChildren > 0)
            {
                removeChildAt(0);
            };
        }

        public function SWFLoad(_arg_1:String):void
        {
            try
            {
                this.menuLoader.close();
            }
            catch(e:Error)
            {
            };
            if (this.SWF)
            {
                this.SWFUnload(this.SWF);
            };
            var _local_2:URLRequest = new URLRequest((_arg_1 + ".swf"));
            this.menuLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onMenuLoadComplete);
            this.menuLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this._ioErrorEventHandler, false, 0, true);
            this.menuLoader.load(_local_2);
        }

        public function SWFLoadAlt(_arg_1:String, _arg_2:String):*
        {
            this.AltMenuName = _arg_2;
            this.SWFLoad(_arg_1);
        }

        private function _ioErrorEventHandler(_arg_1:IOErrorEvent):*
        {
            if (this.AltMenuName.length > 0)
            {
                this.SWFLoad(this.AltMenuName);
            }
            else
            {
                trace(("Failed to load .swf. " + new Error().getStackTrace()));
            };
        }

        public function onMenuLoadComplete(_arg_1:Event):void
        {
            this.SWF = _arg_1.currentTarget.content;
            addChild(this.SWF);
            this.SWF.scaleX = this.ClipScale;
            this.SWF.scaleY = this.ClipScale;
            this.SWF.alpha = this.ClipAlpha;
            if (this.ClipWidth != 0)
            {
                this.SWF.width = this.ClipWidth;
            };
            if (this.ClipHeight != 0)
            {
                this.SWF.height = this.ClipHeight;
            };
            if (this.CenterClip)
            {
                this.SWF.x = (this.SWF.width * -0.5);
                this.SWF.y = (this.SWF.height * -0.5);
            };
            this.SWF.x = (this.SWF.x + this.ClipXOffset);
            this.SWF.y = (this.SWF.y + this.ClipYOffset);
        }

        public function SWFUnload(_arg_1:DisplayObject):void
        {
            removeChild(_arg_1);
            _arg_1.loaderInfo.loader.unload();
            this.SWF = null;
        }


    }
}//package Shared.AS3

