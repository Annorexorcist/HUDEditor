// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.BSDisplayObject

package Shared.AS3
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.display.LoaderInfo;
    import Shared.GlobalFunc;
    import flash.utils.getQualifiedClassName;
    import flash.display.DisplayObject;

    public class BSDisplayObject extends MovieClip 
    {

        private var _bIsDirty:Boolean;
        public var onAddChild:Function;
        public var onRemoveChild:Function;

        public function BSDisplayObject()
        {
            this._bIsDirty = false;
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStageEvent);
            if ((loaderInfo is LoaderInfo))
            {
                loaderInfo.addEventListener(Event.INIT, this.onLoadedInitEvent);
            };
        }

        public function get bIsDirty():Boolean
        {
            return (this._bIsDirty);
        }

        public function SetIsDirty():void
        {
            this._bIsDirty = true;
            this.requestRedraw();
        }

        final private function ClearIsDirty():void
        {
            this._bIsDirty = false;
        }

        final private function onLoadedInitEvent(_arg_1:Event):void
        {
            if ((loaderInfo is LoaderInfo))
            {
                loaderInfo.removeEventListener(Event.INIT, this.onLoadedInitEvent);
            };
            this.onLoadedInit();
        }

        final private function onAddedToStageEvent(_arg_1:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.onAddedToStageEvent);
            this.onAddedToStage();
            if (this.bIsDirty)
            {
                this.requestRedraw();
            };
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStageEvent);
        }

        final private function onRemovedFromStageEvent(_arg_1:Event):void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStageEvent);
            if (stage)
            {
                stage.removeEventListener(Event.RENDER, this.onRenderEvent);
            };
            this.onRemovedFromStage();
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStageEvent);
        }

        final private function onRenderEvent(_arg_1:Event):void
        {
            if (stage)
            {
                stage.removeEventListener(Event.RENDER, this.onRenderEvent);
            };
            if (this.bIsDirty)
            {
                this.ClearIsDirty();
                this.redrawDisplayObject();
            };
            GlobalFunc.BSASSERT((!(this.bIsDirty)), (((("BSDisplayObject: " + getQualifiedClassName(this)) + ": ") + this.name) + ": redrawDisplayObject caused the object to be dirtied. This should never happen as it wont be rendered for that change until it changes for yet another reason later."));
        }

        private function requestRedraw():void
        {
            if (stage)
            {
                stage.addEventListener(Event.RENDER, this.onRenderEvent);
                stage.invalidate();
            };
        }

        public function onLoadedInit():void
        {
        }

        public function redrawDisplayObject():void
        {
        }

        public function onAddedToStage():void
        {
        }

        public function onRemovedFromStage():void
        {
        }

        override public function addChild(_arg_1:DisplayObject):DisplayObject
        {
            var _local_2:DisplayObject = super.addChild(_arg_1);
            if ((this.onAddChild is Function))
            {
                this.onAddChild(_arg_1, getQualifiedClassName(_arg_1));
            };
            return (_local_2);
        }

        override public function removeChild(_arg_1:DisplayObject):DisplayObject
        {
            var _local_2:DisplayObject = super.removeChild(_arg_1);
            if ((this.onRemoveChild is Function))
            {
                this.onRemoveChild(_arg_1, getQualifiedClassName(_arg_1));
            };
            return (_local_2);
        }


    }
}//package Shared.AS3

