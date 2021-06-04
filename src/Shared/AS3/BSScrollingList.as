// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.BSScrollingList

package Shared.AS3
{
    import flash.display.MovieClip;
    import Mobile.ScrollList.MobileScrollList;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import Shared.AS3.COMPANIONAPP.CompanionAppMode;
    import Shared.AS3.Events.PlatformChangeEvent;
    import flash.ui.Keyboard;
    import Shared.GlobalFunc;
    import flash.geom.Point;
    import flash.utils.getDefinitionByName;
    import __AS3__.vec.Vector;
    import Shared.AS3.COMPANIONAPP.BSScrollingListInterface;
    import Mobile.ScrollList.MobileListItemRenderer;
    import Mobile.ScrollList.EventWithParams;
    import __AS3__.vec.*;

    public class BSScrollingList extends MovieClip 
    {

        public static const TEXT_OPTION_NONE:String = "None";
        public static const TEXT_OPTION_SHRINK_TO_FIT:String = "Shrink To Fit";
        public static const TEXT_OPTION_MULTILINE:String = "Multi-Line";
        public static const MOUSEWHEEL_SCROLL_DISTANCE_CTRLSHIFT:uint = 9;
        public static const MOUSEWHEEL_SCROLL_DISTANCE_CTRL:uint = 6;
        public static const MOUSEWHEEL_SCROLL_DISTANCE_SHIFT:uint = 3;
        public static const MOUSEWHEEL_SCROLL_DISTANCE_BASE:uint = 1;
        public static const SELECTION_CHANGE:String = "BSScrollingList::selectionChange";
        public static const ITEM_PRESS:String = "BSScrollingList::itemPress";
        public static const LIST_PRESS:String = "BSScrollingList::listPress";
        public static const LIST_ITEMS_CREATED:String = "BSScrollingList::listItemsCreated";
        public static const PLAY_FOCUS_SOUND:String = "BSScrollingList::playFocusSound";
        public static const MOBILE_ITEM_PRESS:String = "BSScrollingList::mobileItemPress";

        public var scrollList:MobileScrollList;
        protected var _itemRendererClassName:String = "BSScrollingListEntry";
        public var border:MovieClip;
        public var ScrollUp:MovieClip;
        public var ScrollDown:MovieClip;
        public var Mask_mc:MovieClip;
        protected var EntriesA:Array;
        protected var EntryHolder_mc:MovieClip;
        protected var _filterer:ListFilterer;
        protected var iSelectedIndex:int;
        protected var bRestoreListIndex:Boolean;
        protected var iListItemsShown:uint;
        protected var uiNumListItems:uint;
        protected var ListEntryClass:Class;
        protected var fListHeight:Number;
        protected var fVerticalSpacing:Number;
        protected var iScrollPosition:uint;
        protected var iMaxScrollPosition:uint;
        protected var bMouseDrivenNav:Boolean;
        protected var fShownItemsHeight:Number;
        protected var uiPlatform:uint;
        protected var uiController:uint;
        protected var bInitialized:Boolean;
        protected var strTextOption:String;
        protected var bDisableSelection:Boolean;
        protected var bAllowSelectionDisabledListNav:Boolean;
        protected var bDisableInput:Boolean;
        protected var bReverseList:Boolean;
        protected var bReverseOrder:Boolean = false;
        protected var bUpdated:Boolean;
        private var fBorderHeight:Number = 0;
        private var _DisplayNumListItems:uint = 0;

        public function BSScrollingList()
        {
            this.EntriesA = new Array();
            this._filterer = new ListFilterer();
            addEventListener(ListFilterer.FILTER_CHANGE, this.onFilterChange, false, 0, true);
            this.strTextOption = TEXT_OPTION_NONE;
            this.fVerticalSpacing = 0;
            this.uiNumListItems = 0;
            this.bRestoreListIndex = true;
            this.bDisableSelection = false;
            this.bAllowSelectionDisabledListNav = false;
            this.bDisableInput = false;
            this.bMouseDrivenNav = false;
            this.bReverseList = false;
            this.bUpdated = false;
            this.bInitialized = false;
            if (loaderInfo != null)
            {
                loaderInfo.addEventListener(Event.INIT, this.onComponentInit, false, 0, true);
            };
            addEventListener(Event.ADDED_TO_STAGE, this.onStageInit);
            addEventListener(Event.RENDER, this.onRender);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onStageDestruct, false, 0, true);
            addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false, 0, true);
            addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false, 0, true);
            if (!this.needMobileScrollList)
            {
                addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel, false, 0, true);
            };
            if (this.border == null)
            {
                throw (new Error("No 'border' clip found.  BSScrollingList requires a border rect to define its extents."));
            };
            this.fBorderHeight = this.border.height;
            this.EntryHolder_mc = new MovieClip();
            this.EntryHolder_mc.name = "EntryHolder_mc";
            this.addChildAt(this.EntryHolder_mc, (this.getChildIndex(this.border) + 1));
            this.iSelectedIndex = -1;
            this.iScrollPosition = 0;
            this.iMaxScrollPosition = 0;
            this.iListItemsShown = 0;
            this.fListHeight = 0;
            this.uiPlatform = 1;
            if (this.ScrollUp != null)
            {
                this.ScrollUp.visible = false;
            };
            if (this.ScrollDown != null)
            {
                this.ScrollDown.visible = false;
            };
        }

        protected function get needMobileScrollList():Boolean
        {
            return (CompanionAppMode.isOn);
        }

        public function onComponentInit(_arg_1:Event):*
        {
            if (this.needMobileScrollList)
            {
                this.createMobileScrollingList();
                if (this.border != null)
                {
                    this.border.alpha = 0;
                };
            };
            if (loaderInfo != null)
            {
                loaderInfo.removeEventListener(Event.INIT, this.onComponentInit);
            };
            if (!this.bInitialized)
            {
                this.SetNumListItems(this.uiNumListItems);
            };
        }

        protected function onStageInit(_arg_1:Event):*
        {
            stage.addEventListener(PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatform);
            if (!this.bInitialized)
            {
                this.SetNumListItems(this.uiNumListItems);
            };
            if (((!(this.ScrollUp == null)) && (!(CompanionAppMode.isOn))))
            {
                this.ScrollUp.addEventListener(MouseEvent.CLICK, this.onScrollArrowClick, false, 0, true);
            };
            if (((!(this.ScrollDown == null)) && (!(CompanionAppMode.isOn))))
            {
                this.ScrollDown.addEventListener(MouseEvent.CLICK, this.onScrollArrowClick, false, 0, true);
            };
            removeEventListener(Event.ADDED_TO_STAGE, this.onStageInit);
        }

        protected function onStageDestruct(_arg_1:Event):*
        {
            var _local_3:BSScrollingListEntry;
            stage.removeEventListener(PlatformChangeEvent.PLATFORM_CHANGE, this.onSetPlatform);
            removeEventListener(ListFilterer.FILTER_CHANGE, this.onFilterChange);
            loaderInfo.removeEventListener(Event.INIT, this.onComponentInit);
            removeEventListener(Event.REMOVED_FROM_STAGE, this.onStageDestruct);
            removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            if (this.ScrollUp)
            {
                this.ScrollUp.removeEventListener(MouseEvent.CLICK, this.onScrollArrowClick);
            };
            if (this.ScrollDown)
            {
                this.ScrollDown.removeEventListener(MouseEvent.CLICK, this.onScrollArrowClick);
            };
            var _local_2:uint;
            while (_local_2 < this.EntryHolder_mc.numChildren)
            {
                _local_3 = this.GetClipByIndex(_local_2);
                _local_3.removeEventListener(MouseEvent.MOUSE_OVER, this.onEntryRollover);
                _local_3.removeEventListener(MouseEvent.CLICK, this.onEntryPress);
                _local_2++;
            };
            if (this.needMobileScrollList)
            {
                this.destroyMobileScrollingList();
            };
        }

        protected function onRender(_arg_1:Event):*
        {
            if (!this.bInitialized)
            {
                this.SetNumListItems(this.uiNumListItems);
            };
            removeEventListener(Event.RENDER, this.onRender);
        }

        public function onScrollArrowClick(_arg_1:Event):*
        {
            if (((!(this.bDisableInput)) && ((!(this.bDisableSelection)) || (this.bAllowSelectionDisabledListNav))))
            {
                this.doSetSelectedIndex(-1);
                if (((_arg_1.target == this.ScrollUp) || (_arg_1.target.parent == this.ScrollUp)))
                {
                    this.scrollPosition = (this.scrollPosition - 1);
                }
                else
                {
                    if (((_arg_1.target == this.ScrollDown) || (_arg_1.target.parent == this.ScrollDown)))
                    {
                        this.scrollPosition = (this.scrollPosition + 1);
                    };
                };
                _arg_1.stopPropagation();
            };
        }

        public function onEntryRollover(_arg_1:Event):*
        {
            var _local_2:*;
            if (this.uiPlatform == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE)
            {
                this.bMouseDrivenNav = true;
                if (((!(this.bDisableInput)) && (!(this.bDisableSelection))))
                {
                    _local_2 = this.iSelectedIndex;
                    this.doSetSelectedIndex((_arg_1.currentTarget as BSScrollingListEntry).itemIndex);
                    if (_local_2 != this.iSelectedIndex)
                    {
                        dispatchEvent(new Event(PLAY_FOCUS_SOUND, true, true));
                    };
                };
            };
        }

        public function onEntryPress(_arg_1:MouseEvent):*
        {
            _arg_1.stopPropagation();
            this.bMouseDrivenNav = true;
            this.onItemPress();
        }

        public function ClearList():*
        {
            this.EntriesA.splice(0, this.EntriesA.length);
        }

        public function GetClipByIndex(_arg_1:uint):BSScrollingListEntry
        {
            return ((_arg_1 < this.EntryHolder_mc.numChildren) ? (this.EntryHolder_mc.getChildAt(_arg_1) as BSScrollingListEntry) : null);
        }

        public function FindClipForEntry(_arg_1:int):BSScrollingListEntry
        {
            var _local_4:*;
            var _local_5:BSScrollingListEntry;
            if (!this.bUpdated)
            {
                trace("WARNING: FindClipForEntry will always fail to find a clip before Update() has been called at least once");
                _local_4 = new Error();
                trace(_local_4.getStackTrace());
            };
            if ((((_arg_1 == -1) || (_arg_1 == int.MAX_VALUE)) || (_arg_1 >= this.EntriesA.length)))
            {
                return (null);
            };
            var _local_2:BSScrollingListEntry;
            var _local_3:uint;
            while (_local_3 < this.EntryHolder_mc.numChildren)
            {
                _local_5 = this.GetClipByIndex(_local_3);
                if (((_local_5.visible == true) && (_local_5.itemIndex == _arg_1)))
                {
                    _local_2 = _local_5;
                    break;
                };
                _local_3++;
            };
            return (_local_2);
        }

        public function GetEntryFromClipIndex(_arg_1:uint):int
        {
            var _local_2:BSScrollingListEntry = this.GetClipByIndex(_arg_1);
            return ((_local_2) ? _local_2.itemIndex : -1);
        }

        public function onKeyDown(_arg_1:KeyboardEvent):*
        {
            if (!this.bDisableInput)
            {
                if (_arg_1.keyCode == Keyboard.UP)
                {
                    this.moveSelectionUp();
                    _arg_1.stopPropagation();
                }
                else
                {
                    if (_arg_1.keyCode == Keyboard.DOWN)
                    {
                        this.moveSelectionDown();
                        _arg_1.stopPropagation();
                    };
                };
            };
        }

        public function onKeyUp(_arg_1:KeyboardEvent):*
        {
            if ((((!(this.bDisableInput)) && (!(this.bDisableSelection))) && (_arg_1.keyCode == Keyboard.ENTER)))
            {
                this.onItemPress();
                _arg_1.stopPropagation();
            };
        }

        public function onMouseWheel(_arg_1:MouseEvent):*
        {
            var _local_2:uint;
            var _local_3:*;
            var _local_4:*;
            if ((((!(this.bDisableInput)) && ((!(this.bDisableSelection)) || (this.bAllowSelectionDisabledListNav))) && (this.iMaxScrollPosition > 0)))
            {
                _local_2 = MOUSEWHEEL_SCROLL_DISTANCE_BASE;
                if (((_arg_1.ctrlKey) && (_arg_1.shiftKey)))
                {
                    _local_2 = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_CTRLSHIFT, this.numListItems_Inspectable);
                }
                else
                {
                    if (_arg_1.ctrlKey)
                    {
                        _local_2 = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_CTRL, this.numListItems_Inspectable);
                    }
                    else
                    {
                        if (_arg_1.shiftKey)
                        {
                            _local_2 = Math.min(MOUSEWHEEL_SCROLL_DISTANCE_SHIFT, this.numListItems_Inspectable);
                        };
                    };
                };
                _local_3 = this.scrollPosition;
                _local_4 = _local_3;
                if (_arg_1.delta < 0)
                {
                    _local_4 = (this.scrollPosition + _local_2);
                }
                else
                {
                    if (_arg_1.delta > 0)
                    {
                        _local_4 = (this.scrollPosition - _local_2);
                    };
                };
                this.scrollPosition = GlobalFunc.Clamp(_local_4, 0, this.iMaxScrollPosition);
                this.SetFocusUnderMouse();
                _arg_1.stopPropagation();
                if (_local_3 != this.scrollPosition)
                {
                    dispatchEvent(new Event(PLAY_FOCUS_SOUND, true, true));
                };
            };
        }

        private function SetFocusUnderMouse():*
        {
            var _local_2:BSScrollingListEntry;
            var _local_3:MovieClip;
            var _local_4:Point;
            var _local_1:int;
            while (_local_1 < this.iListItemsShown)
            {
                _local_2 = this.GetClipByIndex(_local_1);
                _local_3 = _local_2.border;
                _local_4 = localToGlobal(new Point(mouseX, mouseY));
                if (_local_2.hitTestPoint(_local_4.x, _local_4.y, false))
                {
                    this.selectedIndex = _local_2.itemIndex;
                };
                _local_1++;
            };
        }

        public function get hasBeenUpdated():Boolean
        {
            return (this.bUpdated);
        }

        public function get mouseDrivenNav():Boolean
        {
            return (this.bMouseDrivenNav);
        }

        public function set mouseDrivenNav(_arg_1:Boolean):void
        {
            this.bMouseDrivenNav = _arg_1;
        }

        public function get filterer():ListFilterer
        {
            return (this._filterer);
        }

        public function get itemsShown():uint
        {
            return (this.iListItemsShown);
        }

        public function get initialized():Boolean
        {
            return (this.bInitialized);
        }

        public function get selectedIndex():int
        {
            return (this.iSelectedIndex);
        }

        public function set selectedIndex(_arg_1:int):*
        {
            this.doSetSelectedIndex(_arg_1);
        }

        public function get selectedClipIndex():int
        {
            var _local_1:BSScrollingListEntry = this.FindClipForEntry(this.iSelectedIndex);
            return ((_local_1 != null) ? _local_1.clipIndex : -1);
        }

        public function set selectedClipIndex(_arg_1:int):*
        {
            this.doSetSelectedIndex(this.GetEntryFromClipIndex(_arg_1));
        }

        public function set filterer(_arg_1:ListFilterer):*
        {
            this._filterer = _arg_1;
        }

        public function get shownItemsHeight():Number
        {
            return (this.fShownItemsHeight);
        }

        protected function doSetSelectedIndex(_arg_1:int):*
        {
            var _local_3:int;
            var _local_4:BSScrollingListEntry;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:uint;
            var _local_10:int;
            var _local_11:uint;
            var _local_2:BSScrollingListEntry;
            if (((!(this.bDisableSelection)) && (!(_arg_1 == this.iSelectedIndex))))
            {
                _local_3 = this.iSelectedIndex;
                this.iSelectedIndex = _arg_1;
                if (this.EntriesA.length == 0)
                {
                    this.iSelectedIndex = -1;
                };
                if (((!(_local_3 == -1)) && (_local_3 < this.EntriesA.length)))
                {
                    _local_4 = this.FindClipForEntry(_local_3);
                    if (_local_4 != null)
                    {
                        this.SetEntry(_local_4, this.EntriesA[_local_3]);
                    };
                };
                if (this.iSelectedIndex != -1)
                {
                    this.iSelectedIndex = this._filterer.ClampIndex(this.iSelectedIndex);
                    if (this.iSelectedIndex == int.MAX_VALUE)
                    {
                        this.iSelectedIndex = -1;
                    };
                };
                if (this.iSelectedIndex != -1)
                {
                    _local_2 = this.FindClipForEntry(this.iSelectedIndex);
                    if (_local_2 == null)
                    {
                        this.InvalidateData();
                        _local_2 = this.FindClipForEntry(this.iSelectedIndex);
                    };
                    if (((!(this.iSelectedIndex == -1)) && (!(_local_3 == this.iSelectedIndex))))
                    {
                        if (_local_2 != null)
                        {
                            this.SetEntry(_local_2, this.EntriesA[this.iSelectedIndex]);
                        }
                        else
                        {
                            if (this.iListItemsShown > 0)
                            {
                                _local_5 = this.GetEntryFromClipIndex(0);
                                _local_6 = this.GetEntryFromClipIndex((this.iListItemsShown - 1));
                                _local_8 = 0;
                                if (this.iSelectedIndex < _local_5)
                                {
                                    _local_7 = _local_5;
                                    do 
                                    {
                                        _local_7 = this._filterer.GetPrevFilterMatch(_local_7);
                                        _local_8--;
                                    } while ((((!(_local_7 == this.iSelectedIndex)) && (!(_local_7 == -1))) && (!(_local_7 == int.MAX_VALUE))));
                                }
                                else
                                {
                                    if (this.iSelectedIndex > _local_6)
                                    {
                                        _local_7 = _local_6;
                                        do 
                                        {
                                            _local_7 = this._filterer.GetNextFilterMatch(_local_7);
                                            _local_8++;
                                        } while ((((!(_local_7 == this.iSelectedIndex)) && (!(_local_7 == -1))) && (!(_local_7 == int.MAX_VALUE))));
                                    };
                                };
                                this.scrollPosition = (this.scrollPosition + _local_8);
                            };
                        };
                        if (this.textOption_Inspectable == TEXT_OPTION_MULTILINE)
                        {
                            _local_9 = 0;
                            _local_2 = this.FindClipForEntry(this.iSelectedIndex);
                            while ((((_local_9 < this.uiNumListItems) && (!(_local_2 == null))) && ((_local_2.y + _local_2.height) > this.fListHeight)))
                            {
                                this.scrollPosition = (this.scrollPosition + 1);
                                _local_2 = this.FindClipForEntry(this.iSelectedIndex);
                                _local_9++;
                            };
                            if (_local_9 == this.uiNumListItems)
                            {
                                throw (new Error("Force-exited list selection loop before the selected entry could be fully scrolled on-screen.  Shouldn't be possible!"));
                            };
                        };
                    };
                };
                if (_local_3 != this.iSelectedIndex)
                {
                    dispatchEvent(new Event(SELECTION_CHANGE, true, true));
                };
                if (this.needMobileScrollList)
                {
                    if (this.scrollList != null)
                    {
                        if (this.iSelectedIndex != -1)
                        {
                            _local_10 = this.selectedClipIndex;
                            _local_11 = 0;
                            while (_local_11 < this.scrollList.data.length)
                            {
                                if (this.EntriesA[this.iSelectedIndex] == this.scrollList.data[_local_11])
                                {
                                    _local_10 = _local_11;
                                    break;
                                };
                                _local_11++;
                            };
                            this.scrollList.selectedIndex = _local_10;
                        }
                        else
                        {
                            this.scrollList.selectedIndex = -1;
                        };
                    };
                };
            };
        }

        public function get scrollPosition():uint
        {
            return (this.iScrollPosition);
        }

        public function get maxScrollPosition():uint
        {
            return (this.iMaxScrollPosition);
        }

        public function set scrollPosition(_arg_1:uint):*
        {
            if ((((!(_arg_1 == this.iScrollPosition)) && (_arg_1 >= 0)) && (_arg_1 <= this.iMaxScrollPosition)))
            {
                this.updateScrollPosition(_arg_1);
            };
        }

        protected function updateScrollPosition(_arg_1:uint):*
        {
            this.iScrollPosition = _arg_1;
            this.UpdateList();
        }

        public function get selectedEntry():Object
        {
            return (this.EntriesA[this.iSelectedIndex]);
        }

        public function get entryList():Array
        {
            return (this.EntriesA);
        }

        public function set entryList(_arg_1:Array):*
        {
            this.EntriesA = _arg_1;
            if (this.EntriesA == null)
            {
                this.EntriesA = new Array();
            };
        }

        public function get disableInput_Inspectable():Boolean
        {
            return (this.bDisableInput);
        }

        public function set disableInput_Inspectable(_arg_1:Boolean):*
        {
            this.bDisableInput = _arg_1;
        }

        public function get textOption_Inspectable():String
        {
            return (this.strTextOption);
        }

        public function set textOption_Inspectable(_arg_1:String):*
        {
            this.strTextOption = _arg_1;
            if (((this.strTextOption == TEXT_OPTION_MULTILINE) && (this.Mask_mc == null)))
            {
                this.Mask_mc = new MovieClip();
                this.Mask_mc.name = "MultilineMask_mc";
                this.Mask_mc.graphics.clear();
                this.Mask_mc.graphics.beginFill(0xFFFFFF);
                this.Mask_mc.graphics.drawRect(0, 0, this.border.width, this.border.height);
                this.Mask_mc.graphics.endFill();
                this.addChildAt(this.Mask_mc, (getChildIndex(this.EntryHolder_mc) + 1));
                this.Mask_mc.x = this.border.x;
                this.Mask_mc.y = this.border.y;
                this.Mask_mc.mouseEnabled = false;
                this.Mask_mc.alpha = 0;
                this.EntryHolder_mc.mask = this.Mask_mc;
            };
        }

        public function get verticalSpacing_Inspectable():*
        {
            return (this.fVerticalSpacing);
        }

        public function set verticalSpacing_Inspectable(_arg_1:Number):*
        {
            this.fVerticalSpacing = _arg_1;
        }

        public function get numListItems_Inspectable():uint
        {
            return (this.uiNumListItems);
        }

        public function set numListItems_Inspectable(_arg_1:uint):*
        {
            this.uiNumListItems = _arg_1;
        }

        public function get listEntryClass_Inspectable():String
        {
            return (this._itemRendererClassName);
        }

        public function set listEntryClass_Inspectable(_arg_1:String):*
        {
            this.ListEntryClass = (getDefinitionByName(_arg_1) as Class);
            this._itemRendererClassName = _arg_1;
        }

        public function get restoreListIndex_Inspectable():Boolean
        {
            return (this.bRestoreListIndex);
        }

        public function set restoreListIndex_Inspectable(_arg_1:Boolean):*
        {
            this.bRestoreListIndex = _arg_1;
        }

        public function get disableSelection_Inspectable():Boolean
        {
            return (this.bDisableSelection);
        }

        public function set disableSelection_Inspectable(_arg_1:Boolean):*
        {
            this.bDisableSelection = _arg_1;
        }

        public function set allowWheelScrollNoSelectionChange(_arg_1:Boolean):*
        {
            this.bAllowSelectionDisabledListNav = _arg_1;
        }

        public function get reverseOrder():Boolean
        {
            return (this.bReverseOrder);
        }

        public function set reverseOrder(_arg_1:Boolean):*
        {
            this.bReverseOrder = _arg_1;
        }

        public function SetNumListItems(_arg_1:uint):*
        {
            var _local_2:uint;
            var _local_3:MovieClip;
            if (_arg_1 != this._DisplayNumListItems)
            {
                this._DisplayNumListItems = _arg_1;
                if (((!(this.ListEntryClass == null)) && (_arg_1 > 0)))
                {
                    while (this.EntryHolder_mc.numChildren > 0)
                    {
                        this.EntryHolder_mc.removeChildAt(0);
                    };
                    _local_2 = 0;
                    while (_local_2 < _arg_1)
                    {
                        _local_3 = this.GetNewListEntry(_local_2);
                        if (_local_3 != null)
                        {
                            _local_3.clipIndex = _local_2;
                            _local_3.name = (this._itemRendererClassName + _local_2.toString());
                            _local_3.addEventListener(MouseEvent.MOUSE_OVER, this.onEntryRollover);
                            _local_3.addEventListener(MouseEvent.CLICK, this.onEntryPress);
                            this.EntryHolder_mc.addChild(_local_3);
                        }
                        else
                        {
                            trace((("BSScrollingList::SetNumListItems -- List Entry Class " + this._itemRendererClassName) + " is invalid or does not derive from BSScrollingListEntry."));
                        };
                        _local_2++;
                    };
                    this.bInitialized = true;
                    dispatchEvent(new Event(LIST_ITEMS_CREATED, true, true));
                };
            };
        }

        protected function GetNewListEntry(_arg_1:uint):BSScrollingListEntry
        {
            return (new this.ListEntryClass() as BSScrollingListEntry);
        }

        public function UpdateList():*
        {
            var _local_6:BSScrollingListEntry;
            var _local_7:BSScrollingListEntry;
            var _local_1:Number = 0;
            var _local_2:Number = this._filterer.FindArrayIndexOfFilteredPosition(this.iScrollPosition);
            var _local_3:Number = _local_2;
            var _local_4:uint;
            while (_local_4 < this.uiNumListItems)
            {
                _local_6 = this.GetClipByIndex(_local_4);
                if (_local_6)
                {
                    _local_6.visible = false;
                    _local_6.itemIndex = int.MAX_VALUE;
                };
                _local_4++;
            };
            var _local_5:Vector.<Object> = new Vector.<Object>();
            this.iListItemsShown = 0;
            if (this.needMobileScrollList)
            {
                while (((((!(_local_3 == int.MAX_VALUE)) && (!(_local_3 == -1))) && (_local_3 < this.EntriesA.length)) && (_local_1 <= this.fListHeight)))
                {
                    _local_5.push(this.EntriesA[_local_3]);
                    _local_3 = this._filterer.GetNextFilterMatch(_local_3);
                };
            };
            while ((((((!(_local_2 == int.MAX_VALUE)) && (!(_local_2 == -1))) && (_local_2 < this.EntriesA.length)) && (this.iListItemsShown < this.uiNumListItems)) && (_local_1 <= this.fListHeight)))
            {
                _local_7 = this.GetClipByIndex(this.iListItemsShown);
                if (_local_7)
                {
                    this.SetEntry(_local_7, this.EntriesA[_local_2]);
                    _local_7.itemIndex = _local_2;
                    _local_7.visible = (!(this.needMobileScrollList));
                    if (_local_7.Sizer_mc)
                    {
                        _local_1 = (_local_1 + _local_7.Sizer_mc.height);
                    }
                    else
                    {
                        _local_1 = (_local_1 + _local_7.height);
                    };
                    if (((_local_1 <= this.fListHeight) && (this.iListItemsShown < this.uiNumListItems)))
                    {
                        _local_1 = (_local_1 + this.fVerticalSpacing);
                        this.iListItemsShown++;
                    }
                    else
                    {
                        if (this.textOption_Inspectable != TEXT_OPTION_MULTILINE)
                        {
                            _local_7.itemIndex = int.MAX_VALUE;
                            _local_7.visible = false;
                        }
                        else
                        {
                            this.iListItemsShown++;
                        };
                    };
                };
                _local_2 = this._filterer.GetNextFilterMatch(_local_2);
            };
            if (this.needMobileScrollList)
            {
                this.setMobileScrollingListData(_local_5);
            };
            this.PositionEntries();
            if (this.ScrollUp != null)
            {
                this.ScrollUp.visible = (this.scrollPosition > 0);
            };
            if (this.ScrollDown != null)
            {
                this.ScrollDown.visible = (this.scrollPosition < this.iMaxScrollPosition);
            };
            this.bUpdated = true;
        }

        protected function PositionEntries():*
        {
            var _local_3:BSScrollingListEntry;
            var _local_5:int;
            var _local_1:Number = 0;
            var _local_2:Number = this.border.y;
            var _local_4:Number = 1;
            if (this.reverseOrder)
            {
                _local_4 = -1;
            };
            if (this.iListItemsShown > 0)
            {
                if (this.reverseOrder)
                {
                    _local_2 = this.fBorderHeight;
                    _local_3 = this.GetClipByIndex(_local_5);
                    if (_local_3.Sizer_mc)
                    {
                        _local_2 = (_local_2 - _local_3.Sizer_mc.height);
                    }
                    else
                    {
                        _local_2 = (_local_2 - _local_3.height);
                    };
                };
                _local_5 = 0;
                while (_local_5 < this.iListItemsShown)
                {
                    _local_3 = this.GetClipByIndex(_local_5);
                    _local_3.y = (_local_2 + (_local_1 * _local_4));
                    if (_local_3.Sizer_mc)
                    {
                        _local_1 = (_local_1 + (_local_3.Sizer_mc.height + this.fVerticalSpacing));
                    }
                    else
                    {
                        _local_1 = (_local_1 + (_local_3.height + this.fVerticalSpacing));
                    };
                    _local_5++;
                };
            };
            this.fShownItemsHeight = _local_1;
        }

        public function InvalidateData():*
        {
            var _local_7:int;
            var _local_1:int = ((this.bUpdated) ? this.selectedClipIndex : -1);
            var _local_2:Boolean;
            this._filterer.filterArray = this.EntriesA;
            var _local_3:Object = this.border.getBounds(this);
            var _local_4:Point = new Point(_local_3.x, _local_3.y);
            var _local_5:Point = new Point((_local_3.x + _local_3.width), (_local_3.y + _local_3.height));
            this.localToGlobal(_local_4);
            this.localToGlobal(_local_5);
            this.fListHeight = (_local_5.y - _local_4.y);
            this.CalculateMaxScrollPosition();
            if (this.iSelectedIndex >= this.EntriesA.length)
            {
                this.iSelectedIndex = (this.EntriesA.length - 1);
                _local_2 = true;
            };
            var _local_6:* = false;
            if (!this._filterer.IsValidIndex(this.iSelectedIndex))
            {
                _local_7 = this._filterer.GetPrevFilterMatch(this.iSelectedIndex);
                if (_local_7 == int.MAX_VALUE)
                {
                    if (this._filterer.GetNextFilterMatch(this.iSelectedIndex) == int.MAX_VALUE)
                    {
                        this.iSelectedIndex = -1;
                    };
                }
                else
                {
                    this.iSelectedIndex = _local_7;
                    _local_2 = true;
                    _local_6 = true;
                };
            };
            if (this.iScrollPosition > this.iMaxScrollPosition)
            {
                this.iScrollPosition = this.iMaxScrollPosition;
            };
            this.UpdateList();
            if (((((!(_local_1 == -1)) && (this.restoreListIndex_Inspectable)) && (!(this.needMobileScrollList))) && (!(_local_6))))
            {
                this.selectedClipIndex = _local_1;
            }
            else
            {
                if (_local_2)
                {
                    dispatchEvent(new Event(SELECTION_CHANGE, true, true));
                };
            };
        }

        public function UpdateSelectedEntry():*
        {
            var _local_1:BSScrollingListEntry;
            if (this.iSelectedIndex != -1)
            {
                _local_1 = this.FindClipForEntry(this.iSelectedIndex);
                if (_local_1 != null)
                {
                    this.SetEntry(_local_1, this.EntriesA[this.iSelectedIndex]);
                };
            };
        }

        public function UpdateEntry(_arg_1:int):*
        {
            var _local_2:Object = this.EntriesA[_arg_1];
            var _local_3:BSScrollingListEntry = this.FindClipForEntry(_arg_1);
            this.SetEntry(_local_3, _local_2);
        }

        public function onFilterChange():*
        {
            this.iSelectedIndex = this._filterer.ClampIndex(this.iSelectedIndex);
            this.CalculateMaxScrollPosition();
        }

        protected function CalculateMaxScrollPosition():*
        {
            var _local_2:Number;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_1:int = ((this._filterer.EntryMatchesFilter(this.EntriesA[(this.EntriesA.length - 1)])) ? (this.EntriesA.length - 1) : this._filterer.GetPrevFilterMatch((this.EntriesA.length - 1)));
            if (_local_1 == int.MAX_VALUE)
            {
                this.iMaxScrollPosition = 0;
            }
            else
            {
                _local_2 = this.GetEntryHeight(_local_1);
                _local_3 = _local_1;
                _local_4 = 1;
                while ((((!(_local_3 == int.MAX_VALUE)) && (_local_2 < this.fListHeight)) && (_local_4 < this.uiNumListItems)))
                {
                    _local_5 = _local_3;
                    _local_3 = this._filterer.GetPrevFilterMatch(_local_3);
                    if (_local_3 != int.MAX_VALUE)
                    {
                        _local_2 = (_local_2 + (this.GetEntryHeight(_local_3) + this.fVerticalSpacing));
                        if (_local_2 < this.fListHeight)
                        {
                            _local_4++;
                        }
                        else
                        {
                            _local_3 = _local_5;
                        };
                    };
                };
                if (_local_3 == int.MAX_VALUE)
                {
                    this.iMaxScrollPosition = 0;
                }
                else
                {
                    _local_6 = 0;
                    _local_7 = this._filterer.GetPrevFilterMatch(_local_3);
                    while (_local_7 != int.MAX_VALUE)
                    {
                        _local_6++;
                        _local_7 = this._filterer.GetPrevFilterMatch(_local_7);
                    };
                    this.iMaxScrollPosition = _local_6;
                };
            };
        }

        protected function GetEntryHeight(_arg_1:Number):Number
        {
            var _local_2:BSScrollingListEntry = this.GetClipByIndex(0);
            var _local_3:Number = 0;
            if (_local_2 != null)
            {
                if (((_local_2.hasDynamicHeight) || (this.textOption_Inspectable == TEXT_OPTION_MULTILINE)))
                {
                    this.SetEntry(_local_2, this.EntriesA[_arg_1]);
                    if (_local_2.Sizer_mc)
                    {
                        _local_3 = _local_2.Sizer_mc.height;
                    }
                    else
                    {
                        _local_3 = _local_2.height;
                    };
                }
                else
                {
                    _local_3 = _local_2.defaultHeight;
                };
            };
            return (_local_3);
        }

        public function moveSelectionUp():*
        {
            var _local_1:Number;
            var _local_2:*;
            if (!this.bDisableSelection)
            {
                if (this.selectedIndex > 0)
                {
                    _local_1 = this._filterer.GetPrevFilterMatch(this.selectedIndex);
                    if (_local_1 != int.MAX_VALUE)
                    {
                        this.selectedIndex = _local_1;
                        this.bMouseDrivenNav = false;
                        dispatchEvent(new Event(PLAY_FOCUS_SOUND, true, true));
                    };
                };
            }
            else
            {
                if (this.bAllowSelectionDisabledListNav)
                {
                    _local_2 = this.scrollPosition;
                    this.scrollPosition = (this.scrollPosition - 1);
                    if (_local_2 != this.scrollPosition)
                    {
                        dispatchEvent(new Event(PLAY_FOCUS_SOUND, true, true));
                    };
                };
            };
        }

        public function moveSelectionDown():*
        {
            var _local_1:Number;
            var _local_2:*;
            if (!this.bDisableSelection)
            {
                if (this.selectedIndex < (this.EntriesA.length - 1))
                {
                    _local_1 = this._filterer.GetNextFilterMatch(this.selectedIndex);
                    if (_local_1 != int.MAX_VALUE)
                    {
                        this.selectedIndex = _local_1;
                        this.bMouseDrivenNav = false;
                        dispatchEvent(new Event(PLAY_FOCUS_SOUND, true, true));
                    };
                };
            }
            else
            {
                if (this.bAllowSelectionDisabledListNav)
                {
                    _local_2 = this.scrollPosition;
                    this.scrollPosition = (this.scrollPosition + 1);
                    if (_local_2 != this.scrollPosition)
                    {
                        dispatchEvent(new Event(PLAY_FOCUS_SOUND, true, true));
                    };
                };
            };
        }

        protected function onItemPress():*
        {
            if ((((!(this.bDisableInput)) && (!(this.bDisableSelection))) && (!(this.iSelectedIndex == -1))))
            {
                dispatchEvent(new Event(ITEM_PRESS, true, true));
            }
            else
            {
                dispatchEvent(new Event(LIST_PRESS, true, true));
            };
        }

        protected function SetEntry(aEntryClip:BSScrollingListEntry, aEntryObject:Object):*
        {
            if (aEntryClip != null)
            {
                aEntryClip.selected = (aEntryObject == this.selectedEntry);
                try
                {
                    aEntryClip.SetEntryText(aEntryObject, this.strTextOption);
                }
                catch(e:Error)
                {
                    trace(("BSScrollingList::SetEntry -- SetEntryText error: " + e.getStackTrace()));
                };
            };
        }

        protected function onSetPlatform(_arg_1:Event):*
        {
            var _local_2:PlatformChangeEvent = (_arg_1 as PlatformChangeEvent);
            this.SetPlatform(_local_2.uiPlatform, _local_2.bPS3Switch, _local_2.uiController, _local_2.uiKeyboard);
        }

        public function SetPlatform(_arg_1:uint, _arg_2:Boolean, _arg_3:uint, _arg_4:uint):*
        {
            this.uiPlatform = _arg_1;
            this.uiController = this.uiController;
            this.bMouseDrivenNav = ((this.uiController == 0) ? true : false);
        }

        protected function createMobileScrollingList():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:String;
            var _local_5:Boolean;
            var _local_6:Boolean;
            if (this._itemRendererClassName != null)
            {
                _local_1 = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).maskDimension;
                _local_2 = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).spaceBetweenButtons;
                _local_3 = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).scrollDirection;
                _local_4 = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).linkageId;
                _local_5 = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).clickable;
                _local_6 = BSScrollingListInterface.GetMobileScrollListProperties(this._itemRendererClassName).reversed;
                this.scrollList = new MobileScrollList(_local_1, _local_2, _local_3);
                this.scrollList.itemRendererLinkageId = _local_4;
                this.scrollList.noScrollShortList = true;
                this.scrollList.clickable = _local_5;
                this.scrollList.endListAlign = _local_6;
                this.scrollList.textOption = this.strTextOption;
                this.scrollList.setScrollIndicators(this.ScrollUp, this.ScrollDown);
                this.scrollList.x = 0;
                this.scrollList.y = 0;
                addChild(this.scrollList);
                this.scrollList.addEventListener(MobileScrollList.ITEM_SELECT, this.onMobileScrollListItemSelected, false, 0, true);
            };
        }

        protected function destroyMobileScrollingList():void
        {
            if (this.scrollList != null)
            {
                this.scrollList.removeEventListener(MobileScrollList.ITEM_SELECT, this.onMobileScrollListItemSelected);
                removeChild(this.scrollList);
                this.scrollList.destroy();
            };
        }

        protected function onMobileScrollListItemSelected(_arg_1:EventWithParams):void
        {
            var _local_2:MobileListItemRenderer = (_arg_1.params.renderer as MobileListItemRenderer);
            if (_local_2.data == null)
            {
                return;
            };
            var _local_3:int = _local_2.data.id;
            var _local_4:* = this.iSelectedIndex;
            this.iSelectedIndex = this.GetEntryFromClipIndex(_local_3);
            var _local_5:uint;
            while (_local_5 < this.EntriesA.length)
            {
                if (this.EntriesA[_local_5] == _local_2.data)
                {
                    this.iSelectedIndex = _local_5;
                    break;
                };
                _local_5++;
            };
            if (!this.EntriesA[this.iSelectedIndex].isDivider)
            {
                if (_local_4 != this.iSelectedIndex)
                {
                    dispatchEvent(new Event(SELECTION_CHANGE, true, true));
                    if (this.scrollList.itemRendererLinkageId == BSScrollingListInterface.PIPBOY_MESSAGE_RENDERER_LINKAGE_ID)
                    {
                        this.onItemPress();
                    };
                    dispatchEvent(new Event(MOBILE_ITEM_PRESS, true, true));
                }
                else
                {
                    if ((((((this.scrollList.itemRendererLinkageId == BSScrollingListInterface.RADIO_RENDERER_LINKAGE_ID) || (this.scrollList.itemRendererLinkageId == BSScrollingListInterface.QUEST_RENDERER_LINKAGE_ID)) || (this.scrollList.itemRendererLinkageId == BSScrollingListInterface.QUEST_OBJECTIVES_RENDERER_LINKAGE_ID)) || (this.scrollList.itemRendererLinkageId == BSScrollingListInterface.INVENTORY_RENDERER_LINKAGE_ID)) || (this.scrollList.itemRendererLinkageId == BSScrollingListInterface.PIPBOY_MESSAGE_RENDERER_LINKAGE_ID)))
                    {
                        this.onItemPress();
                    };
                };
            };
        }

        protected function setMobileScrollingListData(_arg_1:Vector.<Object>):void
        {
            if (_arg_1 != null)
            {
                if (_arg_1.length > 0)
                {
                    this.scrollList.setData(_arg_1);
                }
                else
                {
                    this.scrollList.invalidateData();
                };
            }
            else
            {
                trace("setMobileScrollingListData::Error: No data received to display List Items!");
            };
        }


    }
}//package Shared.AS3

