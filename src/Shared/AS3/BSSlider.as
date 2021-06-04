// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.BSSlider

package Shared.AS3
{
    import flash.display.MovieClip;
    import flash.geom.Rectangle;
    import flash.events.MouseEvent;
    import Shared.GlobalFunc;
    import Shared.AS3.Events.CustomEvent;
    import flash.events.Event;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;

    public class BSSlider extends BSUIComponent 
    {

        public static const VALUE_CHANGED:String = "Slider::ValueChanged";
        public static const FILL_MIN_POS_OFFSET:Number = 2;
        public static const HANDLE_SIZE_VALUE_DELTA_MAX:Number = 8;
        public static const HANDLE_SIZE_MIN_PERCENT:Number = 0.25;
        public static const HANDLE_SIZE_MAX_PERCENT:Number = 0.75;

        public var SliderBackground_mc:MovieClip;
        public var Marker_mc:MovieClip;
        public var Fill_mc:MovieClip;
        public var LeftArrow_mc:MovieClip;
        public var RightArrow_mc:MovieClip;
        private var _iMaxValue:uint;
        private var _iValue:uint;
        private var _iMinValue:uint;
        private var _fFillLength:Number;
        private var _fMinPosition:Number;
        private var _fMaxPosition:Number;
        private var _SliderMarkerBoundBox:Rectangle;
        private var _bIsDragging:Boolean;
        private var _iControllerBumperJumpSize:*;
        private var _iControllerTriggerJumpSize:*;
        private var _bVertical:Boolean = false;
        private var _fillBaseSizePos:Rectangle;
        private var _MarkerBaseSizePos:Rectangle;
        private var _bDispatchOnValueChange:Boolean = true;
        private var _bHandleSizeViaContents:Boolean = false;
        private var _HandleDragStartPosOffset:Number = 0;
        private var _fHandleSize:Number = 0;
        private var _bParentMouseHandler:Boolean = true;

        public function BSSlider()
        {
            this._fillBaseSizePos = new Rectangle(this.Fill_mc.x, this.Fill_mc.y, this.Fill_mc.width, this.Fill_mc.height);
            this._MarkerBaseSizePos = new Rectangle(this.Marker_mc.x, this.Marker_mc.y, this.Marker_mc.width, this.Marker_mc.height);
            this.updateConstraints();
            this._bIsDragging = false;
            this._iMinValue = 0;
            this._iMaxValue = 1;
            this.value = this._iMinValue;
            this._iControllerBumperJumpSize = 1;
            this._iControllerTriggerJumpSize = 3;
            this.Marker_mc.addEventListener(MouseEvent.MOUSE_DOWN, this.onBeginDrag);
            this.Marker_mc.buttonMode = true;
        }

        public function set handleSizeViaContents(_arg_1:Boolean):void
        {
            this._bHandleSizeViaContents = _arg_1;
            SetIsDirty();
        }

        public function set dispatchOnValueChange(_arg_1:Boolean):void
        {
            this._bDispatchOnValueChange = _arg_1;
        }

        public function get dispatchOnValueChange():Boolean
        {
            return (this._bDispatchOnValueChange);
        }

        public function updateConstraints():void
        {
            if (this._bVertical)
            {
                this._fMinPosition = (this._fillBaseSizePos.y + FILL_MIN_POS_OFFSET);
                this._fMaxPosition = (this._fillBaseSizePos.y + this._fillBaseSizePos.height);
                this._SliderMarkerBoundBox = new Rectangle(this._fillBaseSizePos.x, this._fillBaseSizePos.y, 0, this._fillBaseSizePos.height);
                this.Fill_mc.width = this._fillBaseSizePos.width;
                this.Marker_mc.x = this._MarkerBaseSizePos.x;
            }
            else
            {
                this._fMinPosition = (this._fillBaseSizePos.x + FILL_MIN_POS_OFFSET);
                this._fMaxPosition = (this._fillBaseSizePos.x + this._fillBaseSizePos.width);
                this._SliderMarkerBoundBox = new Rectangle(this._fillBaseSizePos.x, this._fillBaseSizePos.y, this._fillBaseSizePos.width, 0);
                this.Fill_mc.height = this._fillBaseSizePos.height;
                this.Marker_mc.y = this._MarkerBaseSizePos.y;
            };
            this._fFillLength = (this._fMaxPosition - this._fMinPosition);
        }

        public function set bVertical(_arg_1:Boolean):void
        {
            this._bVertical = _arg_1;
            this.updateConstraints();
        }

        private function updateHandleSize():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            if (this._bHandleSizeViaContents)
            {
                _local_1 = (this._iMaxValue - this._iMinValue);
                _local_2 = (HANDLE_SIZE_VALUE_DELTA_MAX / _local_1);
                _local_3 = GlobalFunc.Clamp(_local_2, HANDLE_SIZE_MIN_PERCENT, HANDLE_SIZE_MAX_PERCENT);
                if (this._bVertical)
                {
                    this.Marker_mc.width = this._MarkerBaseSizePos.width;
                    this.Marker_mc.height = (this._fFillLength * _local_3);
                }
                else
                {
                    this.Marker_mc.width = (this._fFillLength * _local_3);
                    this.Marker_mc.height = this._MarkerBaseSizePos.height;
                };
                this._fHandleSize = ((this._bVertical) ? this.Marker_mc.height : this.Marker_mc.width);
            };
        }

        public function get handleSize():Number
        {
            return (this._fHandleSize);
        }

        public function get sliderLength():Number
        {
            if (this._bHandleSizeViaContents)
            {
                return (this._fFillLength - this.handleSize);
            };
            return (this._fFillLength);
        }

        public function get minValue():uint
        {
            return (this._iMinValue);
        }

        public function set minValue(_arg_1:uint):*
        {
            this._iMinValue = Math.min(_arg_1, this._iMaxValue);
            if (this._iValue < this._iMinValue)
            {
                this.value = this._iMinValue;
            };
            SetIsDirty();
        }

        public function get value():uint
        {
            return (this._iValue);
        }

        public function set value(_arg_1:uint):*
        {
            this.doSetValue(_arg_1);
        }

        public function doSetValue(_arg_1:uint, _arg_2:Boolean=true):void
        {
            this._iValue = Math.min(Math.max(_arg_1, this._iMinValue), this._iMaxValue);
            if (this._bVertical)
            {
                this.Marker_mc.y = this.markerPosition;
            }
            else
            {
                this.Marker_mc.x = this.markerPosition;
            };
            if (((_arg_2) && (this._bDispatchOnValueChange)))
            {
                dispatchEvent(new CustomEvent(VALUE_CHANGED, this.value, true, true));
            };
            SetIsDirty();
        }

        public function valueJump(_arg_1:int):*
        {
            if (((_arg_1 < 0) && (-(_arg_1) > this._iValue)))
            {
                this.value = 1;
            }
            else
            {
                this.value = Math.min(Math.max((this._iValue + _arg_1), this._iMinValue), this._iMaxValue);
            };
        }

        public function get maxValue():uint
        {
            return (this._iMaxValue);
        }

        public function set maxValue(_arg_1:uint):*
        {
            this._iMaxValue = Math.max(_arg_1, 1);
            if (this._iValue > this._iMaxValue)
            {
                this.value = this._iMaxValue;
            };
            SetIsDirty();
        }

        public function get markerPosition():Number
        {
            var _local_1:Number = (this._iValue / this._iMaxValue);
            return (this._fMinPosition + (_local_1 * this.sliderLength));
        }

        public function get controllerBumberJumpSize():uint
        {
            return (this._iControllerBumperJumpSize);
        }

        public function set controllerBumberJumpSize(_arg_1:uint):*
        {
            this._iControllerBumperJumpSize = _arg_1;
        }

        public function get controllerTriggerJumpSize():uint
        {
            return (this._iControllerTriggerJumpSize);
        }

        public function set controllerTriggerJumpSize(_arg_1:uint):*
        {
            this._iControllerTriggerJumpSize = _arg_1;
        }

        private function onBeginDrag(_arg_1:MouseEvent):*
        {
            this._bIsDragging = true;
            this._HandleDragStartPosOffset = ((this._bVertical) ? (mouseY - this.Marker_mc.y) : (mouseX - this.Marker_mc.x));
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onReleaseDrag);
            stage.addEventListener(Event.ENTER_FRAME, this.onValueDrag);
        }

        private function onReleaseDrag(_arg_1:MouseEvent):*
        {
            if (this._bIsDragging)
            {
                stage.removeEventListener(MouseEvent.MOUSE_UP, this.onReleaseDrag);
                stage.removeEventListener(Event.ENTER_FRAME, this.onValueDrag);
                this.onValueDrag(null);
                this._bIsDragging = false;
            };
        }

        private function onValueDrag(_arg_1:Event):*
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            if (this._bIsDragging)
            {
                if (this._bVertical)
                {
                    this.Marker_mc.y = GlobalFunc.Clamp((mouseY - this._HandleDragStartPosOffset), this._SliderMarkerBoundBox.y, (this._SliderMarkerBoundBox.y + this.sliderLength));
                }
                else
                {
                    this.Marker_mc.x = GlobalFunc.Clamp((mouseX - this._HandleDragStartPosOffset), this._SliderMarkerBoundBox.x, (this._SliderMarkerBoundBox.x + this.sliderLength));
                };
                _local_2 = ((this._bVertical) ? this.Marker_mc.y : this.Marker_mc.x);
                _local_3 = ((this._bVertical) ? this._SliderMarkerBoundBox.y : this._SliderMarkerBoundBox.x);
                _local_4 = ((this._bVertical) ? (this._SliderMarkerBoundBox.y + this.sliderLength) : (this._SliderMarkerBoundBox.x + this.sliderLength));
                _local_5 = ((_local_2 - _local_3) / (_local_4 - _local_3));
                this.value = (this._iMinValue + Math.round((_local_5 * (this._iMaxValue - this._iMinValue))));
            };
        }

        private function onKeyDownHandler(_arg_1:KeyboardEvent):*
        {
            if (_arg_1.keyCode == Keyboard.LEFT)
            {
                this.valueJump(-1);
                _arg_1.stopPropagation();
            }
            else
            {
                if (_arg_1.keyCode == Keyboard.RIGHT)
                {
                    this.valueJump(1);
                    _arg_1.stopPropagation();
                };
            };
        }

        private function onMouseWheelHandler(_arg_1:MouseEvent):*
        {
            if (_arg_1.delta < 0)
            {
                this.valueJump(-1);
            }
            else
            {
                if (_arg_1.delta > 0)
                {
                    this.valueJump(1);
                };
            };
            _arg_1.stopPropagation();
        }

        public function onArrowClickHandler(_arg_1:MouseEvent):*
        {
            var _local_2:MovieClip = (_arg_1.target as MovieClip);
            if (_arg_1.target == this.LeftArrow_mc)
            {
                this.valueJump(-(this._iControllerBumperJumpSize));
            }
            else
            {
                if (_arg_1.target == this.RightArrow_mc)
                {
                    this.valueJump(this._iControllerBumperJumpSize);
                };
            };
        }

        public function onSliderBarMouseClickHandler(_arg_1:MouseEvent):*
        {
            var _local_2:Number = ((this._bVertical) ? mouseY : mouseX);
            var _local_3:uint = ((_local_2 / this.sliderLength) * (this._iMaxValue - this._iMinValue));
            this.value = _local_3;
        }

        public function ProcessUserEvent(_arg_1:String, _arg_2:Boolean):Boolean
        {
            var _local_3:* = false;
            if (!_arg_2)
            {
                if (_arg_1 == "LShoulder")
                {
                    this.valueJump(-(this._iControllerBumperJumpSize));
                    _local_3 = true;
                }
                else
                {
                    if (_arg_1 == "RShoulder")
                    {
                        this.valueJump(this._iControllerBumperJumpSize);
                        _local_3 = true;
                    }
                    else
                    {
                        if (_arg_1 == "LTrigger")
                        {
                            this.valueJump(-(this._iControllerTriggerJumpSize));
                            _local_3 = true;
                        }
                        else
                        {
                            if (_arg_1 == "RTrigger")
                            {
                                this.valueJump(this._iControllerTriggerJumpSize);
                                _local_3 = true;
                            };
                        };
                    };
                };
            };
            return (_local_3);
        }

        public function addParentScrollEvents():void
        {
            parent.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownHandler);
            parent.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
            this._bParentMouseHandler = true;
        }

        override public function onAddedToStage():void
        {
            super.onAddedToStage();
            if (this.LeftArrow_mc != null)
            {
                this.LeftArrow_mc.addEventListener(MouseEvent.CLICK, this.onArrowClickHandler);
            };
            if (this.RightArrow_mc != null)
            {
                this.RightArrow_mc.addEventListener(MouseEvent.CLICK, this.onArrowClickHandler);
            };
            this.SliderBackground_mc.addEventListener(MouseEvent.CLICK, this.onSliderBarMouseClickHandler);
        }

        override public function onRemovedFromStage():void
        {
            super.onRemovedFromStage();
            if (this._bParentMouseHandler)
            {
                parent.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownHandler);
                parent.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheelHandler);
            };
            if (this.LeftArrow_mc != null)
            {
                this.LeftArrow_mc.removeEventListener(MouseEvent.CLICK, this.onArrowClickHandler);
            };
            if (this.RightArrow_mc != null)
            {
                this.RightArrow_mc.removeEventListener(MouseEvent.CLICK, this.onArrowClickHandler);
            };
            this.SliderBackground_mc.removeEventListener(MouseEvent.CLICK, this.onSliderBarMouseClickHandler);
        }

        override public function redrawUIComponent():void
        {
            super.redrawUIComponent();
            this.updateHandleSize();
            var _local_1:Number = this.markerPosition;
            if (this._bVertical)
            {
                this.Marker_mc.y = _local_1;
                this.Fill_mc.height = (_local_1 - this.Fill_mc.y);
            }
            else
            {
                this.Marker_mc.x = _local_1;
                this.Fill_mc.width = (_local_1 - this.Fill_mc.x);
            };
        }


    }
}//package Shared.AS3

