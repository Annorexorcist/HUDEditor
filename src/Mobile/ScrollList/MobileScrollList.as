// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Mobile.ScrollList.MobileScrollList

package Mobile.ScrollList
{
    import flash.display.MovieClip;
    import __AS3__.vec.Vector;
    import flash.geom.Rectangle;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import Shared.AS3.BSScrollingList;
    import Shared.AS3.BGSExternalInterface;
    import __AS3__.vec.*;

    public class MobileScrollList extends MovieClip 
    {

        public static const ITEM_SELECT:String = "itemSelect";
        public static const ITEM_RELEASE:String = "itemRelease";
        public static const ITEM_RELEASE_OUTSIDE:String = "itemReleaseOutside";
        public static const HORIZONTAL:uint = 0;
        public static const VERTICAL:uint = 1;

        protected const EPSILON:Number = 0.01;
        protected const VELOCITY_MOVE_FACTOR:Number = 0.4;
        protected const VELOCITY_MOUSE_DOWN_FACTOR:Number = 0.5;
        protected const VELOCITY_MOUSE_UP_FACTOR:Number = 0.8;
        protected const RESISTANCE_OUT_BOUNDS:Number = 0.15;
        protected const BOUNCE_FACTOR:Number = 0.6;
        private const DELTA_MOUSE_POS:int = 15;

        private var _availableRenderers:Vector.<MobileListItemRenderer>;
        protected var _data:Vector.<Object>;
        protected var _rendererRect:Rectangle;
        protected var _bounds:Rectangle;
        protected var _scrollDim:Number;
        protected var _deltaBetweenButtons:Number;
        protected var _renderers:Vector.<MobileListItemRenderer>;
        protected var _tempSelectedIndex:int;
        protected var _selectedIndex:int;
        protected var _position:Number;
        protected var _direction:uint;
        private var _itemRendererLinkageId:String = "MobileListItemRendererMc";
        protected var _background:Sprite;
        protected var _scrollList:Sprite;
        protected var _scrollMask:Sprite;
        protected var _touchZone:Sprite;
        protected var _prevIndicator:MovieClip;
        protected var _nextIndicator:MovieClip;
        protected var _mouseDown:Boolean = false;
        protected var _velocity:Number = 0;
        protected var _mouseDownPos:Number = 0;
        protected var _mouseDownPoint:Point;
        protected var _prevMouseDownPoint:Point;
        private var _mousePressPos:Number;
        protected var _hasBackground:Boolean = false;
        protected var _backgroundColor:int = 0xEEEEEE;
        protected var _noScrollShortList:Boolean = false;
        protected var _clickable:Boolean = true;
        protected var _endListAlign:Boolean = false;
        protected var _textOption:String;
        private var _elasticity:Boolean = true;

        public function MobileScrollList(_arg_1:Number, _arg_2:Number=0, _arg_3:uint=1)
        {
            this._mouseDownPoint = new Point();
            this._prevMouseDownPoint = new Point();
            super();
            this._scrollDim = _arg_1;
            this._deltaBetweenButtons = _arg_2;
            this._direction = _arg_3;
            this._selectedIndex = -1;
            this._tempSelectedIndex = -1;
            this._position = NaN;
            this.hasBackground = false;
            this.noScrollShortList = false;
            this._clickable = true;
            this.endListAlign = false;
            this._availableRenderers = new Vector.<MobileListItemRenderer>();
        }

        public function get data():Vector.<Object>
        {
            return (this._data);
        }

        public function get renderers():Vector.<MobileListItemRenderer>
        {
            return (this._renderers);
        }

        public function get selectedIndex():int
        {
            return (this._selectedIndex);
        }

        public function set selectedIndex(_arg_1:int):void
        {
            var _local_2:MobileListItemRenderer = this.getRendererAt(this._selectedIndex);
            if (_local_2 != null)
            {
                _local_2.unselectItem();
            };
            this._selectedIndex = _arg_1;
            var _local_3:MobileListItemRenderer = this.getRendererAt(this._selectedIndex);
            if (_local_3 != null)
            {
                _local_3.selectItem();
            };
            this.setPosition();
        }

        public function get selectedRenderer():MobileListItemRenderer
        {
            return (this.getRendererAt(this.selectedIndex));
        }

        public function get position():Number
        {
            return (this._position);
        }

        public function set position(_arg_1:Number):void
        {
            this._position = _arg_1;
        }

        public function set needFullRefresh(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                this._selectedIndex = -1;
                this._position = NaN;
                this.setPosition();
            };
        }

        private function get canScroll():Boolean
        {
            var _local_1:Boolean = ((this._direction == HORIZONTAL) ? (this._scrollList.width < this._bounds.width) : (this._scrollList.height < this._bounds.height));
            if (!((this.noScrollShortList) && (_local_1)))
            {
                return (true);
            };
            return (false);
        }

        public function get itemRendererLinkageId():String
        {
            return (this._itemRendererLinkageId);
        }

        public function set itemRendererLinkageId(_arg_1:String):void
        {
            this._itemRendererLinkageId = _arg_1;
        }

        public function get hasBackground():Boolean
        {
            return (this._hasBackground);
        }

        public function set hasBackground(_arg_1:Boolean):void
        {
            this._hasBackground = _arg_1;
        }

        public function get backgroundColor():int
        {
            return (this._backgroundColor);
        }

        public function set backgroundColor(_arg_1:int):void
        {
            this._backgroundColor = _arg_1;
        }

        public function get noScrollShortList():Boolean
        {
            return (this._noScrollShortList);
        }

        public function set noScrollShortList(_arg_1:Boolean):void
        {
            this._noScrollShortList = _arg_1;
        }

        public function get clickable():Boolean
        {
            return (this._clickable);
        }

        public function set clickable(_arg_1:Boolean):void
        {
            this._clickable = _arg_1;
        }

        public function get endListAlign():Boolean
        {
            return (this._endListAlign);
        }

        public function set endListAlign(_arg_1:Boolean):void
        {
            this._endListAlign = _arg_1;
        }

        public function get textOption():String
        {
            return (this._textOption);
        }

        public function set textOption(_arg_1:String):void
        {
            this._textOption = _arg_1;
        }

        public function get elasticity():Boolean
        {
            return (this._elasticity);
        }

        public function set elasticity(_arg_1:Boolean):void
        {
            this._elasticity = _arg_1;
        }

        public function invalidateData():void
        {
            var _local_1:int;
            if (this._data != null)
            {
                _local_1 = 0;
                while (_local_1 < this._data.length)
                {
                    this.removeRenderer(_local_1);
                    _local_1++;
                };
            };
            if (this._scrollMask != null)
            {
                removeChild(this._scrollMask);
                this._scrollMask = null;
            };
            if (this._background != null)
            {
                removeChild(this._background);
                this._background = null;
            };
            if (this._touchZone != null)
            {
                this._scrollList.removeChild(this._touchZone);
                this._touchZone = null;
            };
            if (this._scrollList != null)
            {
                if (this._scrollList.stage != null)
                {
                    this._scrollList.stage.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
                    this._scrollList.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
                };
                this._scrollList.mask = null;
            };
            this._tempSelectedIndex = -1;
            this._bounds = null;
            this._data = null;
            this._renderers = null;
            this._mouseDown = false;
        }

        public function setData(_arg_1:Vector.<Object>):void
        {
            var _local_2:int;
            this.invalidateData();
            this._data = _arg_1;
            if (this.endListAlign)
            {
                this._data.reverse();
            };
            this._renderers = new Vector.<MobileListItemRenderer>();
            if (this._scrollList == null)
            {
                this._scrollList = new Sprite();
                addChild(this._scrollList);
                this._scrollList.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler, false, 0, true);
                this._scrollList.addEventListener(Event.ENTER_FRAME, this.enterFrameHandler, false, 0, true);
            };
            _local_2 = 0;
            while (_local_2 < this._data.length)
            {
                this._renderers.push(this.addRenderer(_local_2, this._data[_local_2]));
                _local_2++;
            };
            if (this._deltaBetweenButtons > 0)
            {
                this._touchZone = this.createSprite(0xFFFF00, new Rectangle(0, 0, this._scrollList.width, this._scrollList.height), 0);
                this._scrollList.addChildAt(this._touchZone, 0);
            };
            this._bounds = ((this._direction == HORIZONTAL) ? new Rectangle(0, 0, this._scrollDim, this._rendererRect.height) : new Rectangle(0, 0, this._rendererRect.width, this._scrollDim));
            this.createMask();
            if (this.hasBackground)
            {
                this.createBackground();
            };
            this.selectedIndex = this._selectedIndex;
            if (!this.canScroll)
            {
                if (this._prevIndicator)
                {
                    this._prevIndicator.visible = false;
                };
                if (this._nextIndicator)
                {
                    this._nextIndicator.visible = false;
                };
            };
            this.setDataOnVisibleRenderers();
        }

        public function setScrollIndicators(_arg_1:MovieClip, _arg_2:MovieClip):void
        {
            this._prevIndicator = _arg_1;
            this._nextIndicator = _arg_2;
            if (this._prevIndicator)
            {
                this._prevIndicator.visible = false;
            };
            if (this._nextIndicator)
            {
                this._nextIndicator.visible = false;
            };
        }

        protected function setPosition():void
        {
            var _local_4:Number;
            if (this._data == null)
            {
                return;
            };
            var _local_1:Number = ((this._direction == HORIZONTAL) ? this._scrollList.width : this._scrollList.height);
            var _local_2:Number = ((this._direction == HORIZONTAL) ? this._bounds.width : this._bounds.height);
            var _local_3:Number = ((this._direction == HORIZONTAL) ? this._scrollList.x : this._scrollList.y);
            if (isNaN(this.position))
            {
                if (this.selectedIndex != -1)
                {
                    _local_4 = ((this._direction == HORIZONTAL) ? this.selectedRenderer.x : this.selectedRenderer.y);
                    if (this.canScroll)
                    {
                        if ((_local_1 - _local_4) < _local_2)
                        {
                            this._position = (_local_2 - _local_1);
                        }
                        else
                        {
                            this._position = -(_local_4);
                        };
                    }
                    else
                    {
                        this._position = ((this.endListAlign) ? (_local_2 - _local_1) : 0);
                    };
                }
                else
                {
                    if (this._direction == HORIZONTAL)
                    {
                        this._scrollList.x = ((this.endListAlign) ? (_local_2 - _local_1) : 0);
                    }
                    else
                    {
                        this._scrollList.y = ((this.endListAlign) ? (_local_2 - _local_1) : 0);
                    };
                    this.setDataOnVisibleRenderers();
                    return;
                };
            }
            else
            {
                if (this.canScroll)
                {
                    if ((this._position + _local_1) < _local_2)
                    {
                        this._position = (_local_2 - _local_1);
                    }
                    else
                    {
                        if (this._position > 0)
                        {
                            this._position = 0;
                        };
                    };
                }
                else
                {
                    this._position = ((this.endListAlign) ? (_local_2 - _local_1) : 0);
                };
            };
            if (this._direction == HORIZONTAL)
            {
                this._scrollList.x = this._position;
            }
            else
            {
                this._scrollList.y = this._position;
            };
            this.setDataOnVisibleRenderers();
        }

        protected function addRenderer(_arg_1:int, _arg_2:Object):MobileListItemRenderer
        {
            var _local_5:MobileListItemRenderer;
            var _local_3:MobileListItemRenderer = this.acquireRenderer();
            _local_3.reset();
            var _local_4:Number = 0;
            if (_arg_1 > 0)
            {
                _local_5 = this.getRendererAt((_arg_1 - 1));
                _local_4 = ((_local_5.y + _local_5.height) + this._deltaBetweenButtons);
            };
            _local_3.y = _local_4;
            if (this._textOption === BSScrollingList.TEXT_OPTION_MULTILINE)
            {
                this.setRendererData(_local_3, _arg_2, _arg_1);
            };
            _local_3.visible = true;
            return (_local_3);
        }

        protected function addRendererListeners(_arg_1:MobileListItemRenderer):void
        {
            _arg_1.addEventListener(ITEM_SELECT, this.itemSelectHandler, false, 0, true);
            _arg_1.addEventListener(ITEM_RELEASE, this.itemReleaseHandler, false, 0, true);
            _arg_1.addEventListener(ITEM_RELEASE_OUTSIDE, this.itemReleaseOutsideHandler, false, 0, true);
        }

        protected function removeRenderer(_arg_1:int):void
        {
            var _local_2:MobileListItemRenderer = this._renderers[_arg_1];
            if (_local_2 != null)
            {
                _local_2.visible = false;
                _local_2.y = 0;
                this.releaseRenderer(_local_2);
            };
        }

        protected function removeRendererListeners(_arg_1:MobileListItemRenderer):void
        {
            _arg_1.removeEventListener(ITEM_SELECT, this.itemSelectHandler);
            _arg_1.removeEventListener(ITEM_RELEASE, this.itemReleaseHandler);
            _arg_1.removeEventListener(ITEM_RELEASE_OUTSIDE, this.itemReleaseOutsideHandler);
        }

        protected function getRendererAt(_arg_1:int):MobileListItemRenderer
        {
            if (((((this._data == null) || (this._renderers == null)) || (_arg_1 > (this._data.length - 1))) || (_arg_1 < 0)))
            {
                return (null);
            };
            if (this.endListAlign)
            {
                return (this._renderers[((this._data.length - 1) - _arg_1)]);
            };
            return (this._renderers[_arg_1]);
        }

        private function acquireRenderer():MobileListItemRenderer
        {
            var _local_1:MobileListItemRenderer;
            if (this._availableRenderers.length > 0)
            {
                return (this._availableRenderers.pop());
            };
            _local_1 = (FlashUtil.getLibraryItem(this, this._itemRendererLinkageId) as MobileListItemRenderer);
            this._scrollList.addChild(_local_1);
            if (this._rendererRect === null)
            {
                this._rendererRect = new Rectangle(_local_1.x, _local_1.y, _local_1.width, _local_1.height);
            };
            this.addRendererListeners(_local_1);
            return (_local_1);
        }

        private function releaseRenderer(_arg_1:MobileListItemRenderer):void
        {
            this._availableRenderers.push(_arg_1);
        }

        protected function resetPressState(_arg_1:MobileListItemRenderer):void
        {
            if (((!(_arg_1 == null)) && (!(_arg_1.data == null))))
            {
                if (this.selectedIndex == _arg_1.data.id)
                {
                    _arg_1.selectItem();
                }
                else
                {
                    _arg_1.unselectItem();
                };
            };
        }

        protected function itemSelectHandler(_arg_1:EventWithParams):void
        {
            var _local_2:MobileListItemRenderer;
            var _local_3:int;
            if (this.clickable)
            {
                _local_2 = (_arg_1.params.renderer as MobileListItemRenderer);
                _local_3 = _local_2.data.id;
                this._mousePressPos = ((this._direction == MobileScrollList.HORIZONTAL) ? stage.mouseX : stage.mouseY);
                this._tempSelectedIndex = _local_3;
                _local_2.pressItem();
            };
        }

        protected function itemReleaseHandler(_arg_1:EventWithParams):void
        {
            var _local_2:MobileListItemRenderer;
            var _local_3:int;
            if (this.clickable)
            {
                _local_2 = (_arg_1.params.renderer as MobileListItemRenderer);
                _local_3 = _local_2.data.id;
                if (this._tempSelectedIndex == _local_3)
                {
                    this.selectedIndex = _local_3;
                    this.dispatchEvent(new EventWithParams(MobileScrollList.ITEM_SELECT, {"renderer":_local_2}));
                };
            };
        }

        protected function itemReleaseOutsideHandler(_arg_1:EventWithParams):void
        {
            var _local_2:MobileListItemRenderer;
            if (this.clickable)
            {
                _local_2 = (_arg_1.params.renderer as MobileListItemRenderer);
                this.resetPressState(_local_2);
                this._tempSelectedIndex = -1;
            };
        }

        protected function createMask():void
        {
            this._scrollMask = this.createSprite(0xFF00FF, new Rectangle(this._bounds.x, this._bounds.y, this._bounds.width, this._bounds.height));
            addChild(this._scrollMask);
            this._scrollMask.mouseEnabled = false;
            this._scrollList.mask = this._scrollMask;
        }

        protected function createBackground():void
        {
            this._background = this.createSprite(this.backgroundColor, new Rectangle(this._bounds.x, this._bounds.y, this._bounds.width, this._bounds.height));
            this._background.x = this._bounds.x;
            this._background.y = this._bounds.y;
            addChildAt(this._background, 0);
        }

        protected function createSprite(_arg_1:int, _arg_2:Rectangle, _arg_3:Number=1):Sprite
        {
            var _local_4:* = new Sprite();
            _local_4.graphics.beginFill(_arg_1, _arg_3);
            _local_4.graphics.drawRect(_arg_2.x, _arg_2.y, _arg_2.width, _arg_2.height);
            _local_4.graphics.endFill();
            return (_local_4);
        }

        protected function enterFrameHandler(_arg_1:Event):void
        {
            var _local_2:*;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            if (((!(this._bounds == null)) && (this.canScroll)))
            {
                _local_2 = ((this._mouseDown) ? this.VELOCITY_MOUSE_DOWN_FACTOR : this.VELOCITY_MOUSE_UP_FACTOR);
                this._velocity = (this._velocity * _local_2);
                _local_3 = ((this._direction == HORIZONTAL) ? this._scrollList.width : this._scrollList.height);
                _local_4 = ((this._direction == HORIZONTAL) ? this._bounds.width : this._bounds.height);
                _local_5 = ((this._direction == HORIZONTAL) ? this._scrollList.x : this._scrollList.y);
                if (!this._mouseDown)
                {
                    _local_6 = 0;
                    if (((_local_5 >= 0) || (_local_3 <= _local_4)))
                    {
                        if (this.elasticity)
                        {
                            _local_6 = (-(_local_5) * this.BOUNCE_FACTOR);
                            this._position = ((_local_5 + this._velocity) + _local_6);
                        }
                        else
                        {
                            this._position = 0;
                        };
                    }
                    else
                    {
                        if ((_local_5 + _local_3) <= _local_4)
                        {
                            if (this.elasticity)
                            {
                                _local_6 = (((_local_4 - _local_3) - _local_5) * this.BOUNCE_FACTOR);
                                this._position = ((_local_5 + this._velocity) + _local_6);
                            }
                            else
                            {
                                this._position = (_local_4 - _local_3);
                            };
                        }
                        else
                        {
                            this._position = (_local_5 + this._velocity);
                        };
                    };
                    if (((Math.abs(this._velocity) > this.EPSILON) || (!(_local_6 == 0))))
                    {
                        if (this._direction == HORIZONTAL)
                        {
                            this._scrollList.x = this._position;
                        }
                        else
                        {
                            this._scrollList.y = this._position;
                        };
                        this.setDataOnVisibleRenderers();
                    };
                };
                if (this._prevIndicator)
                {
                    this._prevIndicator.visible = (_local_5 < 0);
                };
                if (this._nextIndicator)
                {
                    this._nextIndicator.visible = (_local_5 > (_local_4 - _local_3));
                };
            };
        }

        protected function mouseDownHandler(_arg_1:MouseEvent):void
        {
            if (((!(this._mouseDown)) && (this.canScroll)))
            {
                this._mouseDownPoint = new Point(_arg_1.stageX, _arg_1.stageY);
                this._prevMouseDownPoint = new Point(_arg_1.stageX, _arg_1.stageY);
                this._mouseDown = true;
                this._mouseDownPos = ((this._direction == HORIZONTAL) ? this._scrollList.x : this._scrollList.y);
                this._scrollList.stage.addEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler, false, 0, true);
                this._scrollList.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler, false, 0, true);
                BGSExternalInterface.call(null, "OnScrollingStarted");
            };
        }

        protected function mouseMoveHandler(_arg_1:MouseEvent):void
        {
            var _local_2:Point;
            var _local_3:Number;
            if (((this._mouseDown) && (this.canScroll)))
            {
                if (((!(isNaN(_arg_1.stageX))) && (!(isNaN(_arg_1.stageY)))))
                {
                    _local_2 = new Point(_arg_1.stageX, _arg_1.stageY);
                    if (this._direction == HORIZONTAL)
                    {
                        _local_3 = (_local_2.x - this._prevMouseDownPoint.x);
                        if (((this._scrollList.x >= this._bounds.x) || (this._scrollList.x <= (this._bounds.x - (this._scrollList.width - this._bounds.width)))))
                        {
                            if (this.elasticity)
                            {
                                this._scrollList.x = (this._scrollList.x + (_local_3 * this.RESISTANCE_OUT_BOUNDS));
                            }
                            else
                            {
                                if (!(((this._scrollList.x >= this._bounds.x) && (_local_3 > 0)) || ((this._scrollList.x <= (this._bounds.x - (this._scrollList.width - this._bounds.width))) && (_local_3 < 0))))
                                {
                                    this._scrollList.x = (this._scrollList.x + _local_3);
                                };
                            };
                        }
                        else
                        {
                            this._scrollList.x = (this._scrollList.x + _local_3);
                        };
                        this._position = this._scrollList.x;
                        if (Math.abs((_local_2.x - this._mousePressPos)) > this.DELTA_MOUSE_POS)
                        {
                            this.resetPressState(this.getRendererAt(this._tempSelectedIndex));
                            this._tempSelectedIndex = -1;
                        };
                        this._velocity = (this._velocity + ((_local_2.x - this._prevMouseDownPoint.x) * this.VELOCITY_MOVE_FACTOR));
                    }
                    else
                    {
                        _local_3 = (_local_2.y - this._prevMouseDownPoint.y);
                        if (((this._scrollList.y >= this._bounds.y) || (this._scrollList.y <= (this._bounds.y - (this._scrollList.height - this._bounds.height)))))
                        {
                            if (this.elasticity)
                            {
                                this._scrollList.y = (this._scrollList.y + (_local_3 * this.RESISTANCE_OUT_BOUNDS));
                            }
                            else
                            {
                                if (!(((this._scrollList.y >= this._bounds.y) && (_local_3 > 0)) || ((this._scrollList.y <= (this._bounds.y - (this._scrollList.height - this._bounds.height))) && (_local_3 < 0))))
                                {
                                    this._scrollList.y = (this._scrollList.y + _local_3);
                                };
                            };
                        }
                        else
                        {
                            this._scrollList.y = (this._scrollList.y + _local_3);
                        };
                        this._position = this._scrollList.y;
                        if (Math.abs((_local_2.y - this._mousePressPos)) > this.DELTA_MOUSE_POS)
                        {
                            this.resetPressState(this.getRendererAt(this._tempSelectedIndex));
                            this._tempSelectedIndex = -1;
                        };
                        this._velocity = (this._velocity + ((_local_2.y - this._prevMouseDownPoint.y) * this.VELOCITY_MOVE_FACTOR));
                    };
                    this._prevMouseDownPoint = _local_2;
                };
                if (((((((isNaN(this.mouseX)) || (isNaN(this.mouseY))) || (this.mouseY < this._bounds.y)) || (this.mouseY > (this._bounds.height + this._bounds.y))) || (this.mouseX < this._bounds.x)) || (this.mouseX > (this._bounds.width + this._bounds.x))))
                {
                    this.mouseUpHandler(null);
                };
                this.setDataOnVisibleRenderers();
            };
        }

        protected function mouseUpHandler(_arg_1:MouseEvent):void
        {
            if (((this._mouseDown) && (this.canScroll)))
            {
                this._mouseDown = false;
                this._scrollList.stage.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
                this._scrollList.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
                BGSExternalInterface.call(null, "OnScrollingStopped");
            };
        }

        private function setDataOnVisibleRenderers():void
        {
            var _local_2:Number;
            var _local_1:int;
            while (_local_1 < this._renderers.length)
            {
                if (this._renderers[_local_1].data === null)
                {
                    _local_2 = (this._scrollList.y + this._renderers[_local_1].y);
                    if (((_local_2 < (this._bounds.y + this._bounds.height)) && ((_local_2 + this._renderers[_local_1].height) > this._bounds.y)))
                    {
                        this.setRendererData(this._renderers[_local_1], this.data[_local_1], _local_1);
                    };
                };
                _local_1++;
            };
        }

        private function setRendererData(_arg_1:MobileListItemRenderer, _arg_2:Object, _arg_3:int):void
        {
            _arg_2.id = _arg_3;
            _arg_2.textOption = this._textOption;
            _arg_1.setData(_arg_2);
        }

        public function destroy():void
        {
            this.invalidateData();
        }


    }
}//package Mobile.ScrollList

