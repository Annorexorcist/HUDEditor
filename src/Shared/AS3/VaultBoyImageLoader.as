// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.VaultBoyImageLoader

package Shared.AS3
{
    import flash.display.MovieClip;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.display.Graphics;

    public dynamic class VaultBoyImageLoader extends BSUIComponent 
    {

        public var VaultBoyImageInternal_mc:BSUIComponent;
        private var SWF:MovieClip;
        private var menuLoader:Loader;
        private var _bUseFixedQuestStageSize:Boolean = true;
        private var _bPlayClipOnce:Boolean = false;
        private var _clipAlignment:String = "TopLeft";
        private var _defaultBoySwfName:String = "Components/Quest Vault Boys/Miscellaneous Quests/DefaultBoy.swf";
        private var _questAnimStageWidth:Number = 550;
        private var _questAnimStageHeight:Number = 400;
        private var _maxClipHeight:Number = 160;
        public var onLastFrame:Function;

        public function VaultBoyImageLoader()
        {
            this.onLastFrame = this.onLastFrame_Impl;
            super();
            this.SWF = null;
            this.menuLoader = null;
        }

        public function get bUseFixedQuestStageSize_Inspectable():Boolean
        {
            return (this._bUseFixedQuestStageSize);
        }

        public function set bUseFixedQuestStageSize_Inspectable(_arg_1:Boolean):*
        {
            this._bUseFixedQuestStageSize = _arg_1;
        }

        public function get bPlayClipOnce_Inspectable():Boolean
        {
            return (this._bPlayClipOnce);
        }

        public function set bPlayClipOnce_Inspectable(_arg_1:Boolean):*
        {
            this._bPlayClipOnce = _arg_1;
        }

        public function get ClipAlignment_Inspectable():String
        {
            return (this._clipAlignment);
        }

        public function set ClipAlignment_Inspectable(_arg_1:String):*
        {
            this._clipAlignment = _arg_1;
        }

        public function get DefaultBoySwfName_Inspectable():String
        {
            return (this._defaultBoySwfName);
        }

        public function set DefaultBoySwfName_Inspectable(_arg_1:String):*
        {
            this._defaultBoySwfName = _arg_1;
        }

        public function get questAnimStageWidth_Inspectable():Number
        {
            return (this._questAnimStageWidth);
        }

        public function set questAnimStageWidth_Inspectable(_arg_1:Number):void
        {
            this._questAnimStageWidth = _arg_1;
        }

        public function get questAnimStageHeight_Inspectable():Number
        {
            return (this._questAnimStageHeight);
        }

        public function set questAnimStageHeight_Inspectable(_arg_1:Number):void
        {
            this._questAnimStageHeight = _arg_1;
        }

        public function get maxClipHeight_Inspectable():Number
        {
            return (this._maxClipHeight);
        }

        public function set maxClipHeight_Inspectable(_arg_1:Number):void
        {
            this._maxClipHeight = _arg_1;
        }

        public function SWFLoad(aSwfLoaderURL:String):void
        {
            this.VaultBoyImageInternal_mc.visible = false;
            if (this.menuLoader)
            {
                this.menuLoader.close();
            };
            this.SWFUnload();
            var loadCompleteCallback:Function = function (_arg_1:Event):*
            {
                onMenuLoadComplete(_arg_1, aSwfLoaderURL);
            };
            var menuLoadRequest:URLRequest = new URLRequest(((aSwfLoaderURL) ? aSwfLoaderURL : this.DefaultBoySwfName_Inspectable));
            this.menuLoader = new Loader();
            this.menuLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteCallback);
            this.menuLoader.load(menuLoadRequest);
            SetIsDirty();
        }

        public function onMenuLoadComplete(_arg_1:Event, _arg_2:String):void
        {
            var _local_3:MovieClip;
            if ((((_arg_1) && (_arg_1.currentTarget)) && (_arg_1.currentTarget.content)))
            {
                _local_3 = (_arg_1.currentTarget.content as MovieClip);
                _local_3.SwfLoaderURL = _arg_2;
                this.SetQuestMovieClip(_local_3);
            }
            else
            {
                this.SWFUnload();
            };
        }

        public function SetQuestMovieClip(_arg_1:MovieClip):void
        {
            var _local_4:Graphics;
            this.VaultBoyImageInternal_mc.visible = true;
            this.SWF = _arg_1;
            this.VaultBoyImageInternal_mc.addChild(this.SWF);
            if (this.bPlayClipOnce_Inspectable)
            {
                this.SWF.addEventListener(Event.ENTER_FRAME, this.onSWFEnterFrame);
            };
            if (this.bUseFixedQuestStageSize_Inspectable)
            {
                _local_4 = this.SWF.graphics;
                _local_4.clear();
                _local_4.beginFill(0, 0);
                _local_4.drawRect(0, 0, this.questAnimStageWidth_Inspectable, this.questAnimStageHeight_Inspectable);
                _local_4.endFill();
            };
            var _local_2:Number = this._maxClipHeight;
            var _local_3:Number = (_local_2 / this.SWF.height);
            this.SWF.scaleX = _local_3;
            this.SWF.scaleY = _local_3;
            if (this.ClipAlignment_Inspectable == "Center")
            {
                this.SWF.x = ((-(this.questAnimStageWidth_Inspectable) * 0.5) * _local_3);
                this.SWF.y = ((-(this.questAnimStageHeight_Inspectable) * 0.5) * _local_3);
            };
            this.menuLoader = null;
            SetIsDirty();
        }

        public function onLastFrame_Impl(_arg_1:String):*
        {
        }

        public function onSWFEnterFrame(_arg_1:Event):*
        {
            if ((((this.bPlayClipOnce_Inspectable) && (this.SWF)) && (this.SWF.currentFrame == this.SWF.totalFrames)))
            {
                this.SWF.removeEventListener(Event.ENTER_FRAME, this.onSWFEnterFrame);
                this.SWF.stop();
                this.onLastFrame(this.SWF.SwfLoaderURL);
            };
        }

        public function SWFUnload():void
        {
            if (this.SWF)
            {
                this.SWF.removeEventListener(Event.ENTER_FRAME, this.onSWFEnterFrame);
                if (this.VaultBoyImageInternal_mc.contains(this.SWF))
                {
                    this.VaultBoyImageInternal_mc.removeChild(this.SWF);
                };
                if (this.SWF.loaderInfo)
                {
                    this.SWF.loaderInfo.loader.unload();
                };
            };
            this.SWF = null;
            this.VaultBoyImageInternal_mc.SetIsDirty();
            this.VaultBoyImageInternal_mc.visible = false;
            SetIsDirty();
        }


    }
}//package Shared.AS3

