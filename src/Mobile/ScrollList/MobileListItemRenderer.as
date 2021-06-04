// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Mobile.ScrollList.MobileListItemRenderer

package Mobile.ScrollList
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.*;

    public class MobileListItemRenderer extends MovieClip 
    {

        private const DELTA_MOUSE_POS:int = 15;

        public var textField:TextField;
        protected var _data:Object;
        private var _mouseDownPos:Number;
        private var _mouseUpPos:Number;


        public function get data():Object
        {
            return (this._data);
        }

        protected function get isClickable():Boolean
        {
            return ((!(this.data == null)) && (!((!(this.data.clickable == null)) && (!(this.data.clickable)))));
        }

        public function reset():void
        {
            this._data = null;
            addEventListener(Event.REMOVED_FROM_STAGE, this.destroy, false, 0, true);
            addEventListener(MouseEvent.MOUSE_DOWN, this.itemPressHandler, false, 0, true);
        }

        public function setData(_arg_1:Object):*
        {
            this._data = _arg_1;
            if (_arg_1 != null)
            {
                this.setVisual();
            };
        }

        protected function setVisual():void
        {
        }

        protected function itemPressHandler(_arg_1:MouseEvent):void
        {
            if (this.isClickable)
            {
                addEventListener(Event.ENTER_FRAME, this.onEnterFrame, false, 0, true);
                addEventListener(MouseEvent.MOUSE_UP, this.itemReleaseHandler, false, 0, true);
                this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_SELECT, {"renderer":this}));
            };
        }

        protected function itemReleaseHandler(_arg_1:MouseEvent):void
        {
            if (this.isClickable)
            {
                removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                removeEventListener(MouseEvent.MOUSE_UP, this.itemReleaseHandler);
                this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_RELEASE, {"renderer":this}));
            };
        }

        protected function onEnterFrame(_arg_1:Event):void
        {
            if (((((mouseY < 0) || (mouseY > this.height)) || (mouseX < 0)) || (mouseX > this.width)))
            {
                removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                removeEventListener(MouseEvent.MOUSE_UP, this.itemReleaseHandler);
                this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_RELEASE_OUTSIDE, {"renderer":this}));
            };
        }

        public function selectItem():void
        {
        }

        public function unselectItem():void
        {
        }

        public function pressItem():void
        {
        }

        protected function destroy(_arg_1:Event):void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.destroy);
            removeEventListener(MouseEvent.MOUSE_DOWN, this.itemPressHandler);
        }


    }
}//package Mobile.ScrollList

