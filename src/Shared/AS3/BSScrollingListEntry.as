// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.BSScrollingListEntry

package Shared.AS3
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import scaleform.gfx.Extensions;
    import flash.geom.ColorTransform;
    import scaleform.gfx.TextFieldEx;
    import flash.text.TextFieldAutoSize;
    import Shared.GlobalFunc;

    public class BSScrollingListEntry extends MovieClip 
    {

        public var border:MovieClip;
        public var textField:TextField;
        public var Sizer_mc:MovieClip;
        protected var _clipIndex:uint;
        protected var _clipRow:uint;
        protected var _clipCol:uint;
        protected var _itemIndex:uint;
        protected var _selected:Boolean;
        protected var _parentClip:MovieClip;
        public var ORIG_BORDER_HEIGHT:Number;
        public var ORIG_BORDER_WIDTH:Number;
        public var ORIG_TEXT_COLOR:Number;
        protected var _HasDynamicHeight:Boolean = false;

        public function BSScrollingListEntry()
        {
            Extensions.enabled = true;
            this.ORIG_BORDER_HEIGHT = ((this.border != null) ? this.border.height : 0);
            this.ORIG_BORDER_WIDTH = ((this.border != null) ? this.border.width : 0);
            this.ORIG_TEXT_COLOR = ((this.textField != null) ? this.textField.textColor : 16777163);
            if (this.textField != null)
            {
                this.textField.mouseEnabled = false;
                if (this.textField.multiline)
                {
                    this._HasDynamicHeight = true;
                };
            };
            if (this.Sizer_mc)
            {
                this.hitArea = this.Sizer_mc;
            };
        }

        public function Dtor():*
        {
        }

        public function get parentClip():MovieClip
        {
            return (this._parentClip);
        }

        public function set parentClip(_arg_1:MovieClip):*
        {
            this._parentClip = _arg_1;
        }

        public function get clipIndex():uint
        {
            return (this._clipIndex);
        }

        public function set clipIndex(_arg_1:uint):*
        {
            this._clipIndex = _arg_1;
        }

        public function get clipRow():uint
        {
            return (this._clipRow);
        }

        public function set clipRow(_arg_1:uint):*
        {
            this._clipRow = _arg_1;
        }

        public function get clipCol():uint
        {
            return (this._clipCol);
        }

        public function set clipCol(_arg_1:uint):*
        {
            this._clipCol = _arg_1;
        }

        public function get itemIndex():uint
        {
            return (this._itemIndex);
        }

        public function set itemIndex(_arg_1:uint):*
        {
            this._itemIndex = _arg_1;
        }

        public function get selected():Boolean
        {
            return (this._selected);
        }

        public function set selected(_arg_1:Boolean):*
        {
            this._selected = _arg_1;
        }

        public function get hasDynamicHeight():Boolean
        {
            return (this._HasDynamicHeight);
        }

        public function get defaultHeight():Number
        {
            return (this.ORIG_BORDER_HEIGHT);
        }

        public function get defaultWidth():Number
        {
            return (this.ORIG_BORDER_WIDTH);
        }

        protected function SetColorTransform(_arg_1:Object, _arg_2:Boolean):*
        {
            var _local_3:ColorTransform = _arg_1.transform.colorTransform;
            _local_3.redOffset = ((_arg_2) ? -255 : 0);
            _local_3.greenOffset = ((_arg_2) ? -255 : 0);
            _local_3.blueOffset = ((_arg_2) ? -255 : 0);
            _arg_1.transform.colorTransform = _local_3;
        }

        public function SetEntryText(_arg_1:Object, _arg_2:String):*
        {
            var _local_3:Number;
            if ((((!(this.textField == null)) && (!(_arg_1 == null))) && (_arg_1.hasOwnProperty("text"))))
            {
                if (_arg_2 == BSScrollingList.TEXT_OPTION_SHRINK_TO_FIT)
                {
                    TextFieldEx.setTextAutoSize(this.textField, "shrink");
                }
                else
                {
                    if (_arg_2 == BSScrollingList.TEXT_OPTION_MULTILINE)
                    {
                        this.textField.autoSize = TextFieldAutoSize.LEFT;
                        this.textField.multiline = true;
                        this.textField.wordWrap = true;
                    };
                };
                if (_arg_1.text != undefined)
                {
                    GlobalFunc.SetText(this.textField, _arg_1.text, true);
                }
                else
                {
                    GlobalFunc.SetText(this.textField, " ", true);
                };
                this.textField.textColor = ((this.selected) ? 0 : this.ORIG_TEXT_COLOR);
            };
            if (this.border != null)
            {
                this.border.alpha = ((this.selected) ? GlobalFunc.SELECTED_RECT_ALPHA : 0);
                if ((((!(this.textField == null)) && (_arg_2 == BSScrollingList.TEXT_OPTION_MULTILINE)) && (this.textField.numLines > 1)))
                {
                    _local_3 = (this.textField.y - this.border.y);
                    this.border.height = ((this.textField.textHeight + (_local_3 * 2)) + 5);
                }
                else
                {
                    this.border.height = this.ORIG_BORDER_HEIGHT;
                };
            };
        }


    }
}//package Shared.AS3

