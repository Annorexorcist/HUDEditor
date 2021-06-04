// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.BCGridList

package Shared.AS3
{
    import flash.display.MovieClip;
    import __AS3__.vec.Vector;
    import flash.events.Event;
    import Shared.GlobalFunc;
    import flash.utils.getDefinitionByName;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import Shared.AS3.Events.PlatformChangeEvent;
    import flash.events.MouseEvent;
    import Shared.AS3.Events.CustomEvent;
    import flash.geom.Point;
    import __AS3__.vec.*;

    public class BCGridList extends MovieClip 
    {

        public static const TEXT_OPTION_NONE:String = "None";
        public static const TEXT_OPTION_SHRINK_TO_FIT:String = "Shrink To Fit";
        public static const TEXT_OPTION_MULTILINE:String = "Multi-Line";
        public static const SELECTION_CHANGE:String = "BCGridList::selectionChange";
        public static const ITEM_PRESS:String = "BCGridList::itemPress";
        public static const LIST_PRESS:String = "BCGridList::listPress";
        public static const MOUSE_OVER_ITEM:String = "BCGridList::mouseOverItem";
        public static const LIST_UPDATED:String = "BCGridList::listUpdated";
        public static const SELECTION_EDGE_BOUNCE:String = "BCGridList::selectionEdgeBounce";
        public static const ITEM_CLICKED:String = "BCGridList::itemClicked";

        public var Body_mc:MovieClip;
        public var ScrollUp_mc:MovieClip;
        public var ScrollDown_mc:MovieClip;
        public var ScrollLeft_mc:MovieClip;
        public var ScrollRight_mc:MovieClip;
        public var ScrollVert_mc:BSSlider;
        public var ScrollHoriz_mc:BSSlider;
        private var EntryHolder_mc:MovieClip;
        private var m_ListItemClassName:String = "BSScrollingListEntry";
        private var m_ListItemClass:Class;
        private var m_MaxRows:uint = 7;
        private var m_MaxCols:uint = 1;
        private var m_TextBehavior:String;
        private var m_ScrollVertical:Boolean = true;
        private var m_DisableSelection:Boolean = false;
        private var m_DisableInput:Boolean = false;
        private var m_WheelSelectionScroll:Boolean = false;
        private var m_SelectionScrollLock:Boolean = false;
        private var m_SelectionScrollLockOffset:int = 0;
        private var m_IdName:String = "";
        private var m_EntriesLayeredInOrder:Boolean = false;
        private var m_SetSelectedIndexOnFirstEntryDataInit:Boolean = false;
        private var m_SelectedIndex:int = -1;
        private var m_SelectedClip:BSScrollingListEntry;
        private var m_SelectedDisplayIndex:int = -1;
        protected var m_DisplayedItemCount:uint = 0;
        private var m_MaxDisplayedItems:uint = 0;
        protected var m_ListStartIndex:uint = 0;
        private var m_ShowSelectedItem:Boolean = true;
        private var m_PrevSelectedIndex:int = -1;
        private var m_IsDirty:Boolean = false;
        private var m_NeedRecalculateScrollMax:Boolean = true;
        private var m_NeedRecreateClips:Boolean = false;
        protected var m_NeedRedraw:Boolean = true;
        private var m_NeedSliderUpdate:Boolean = true;
        private var m_QueueSelectUnderMouse:Boolean = false;
        private var m_RowScrollPos:uint = 0;
        private var m_RowScrollPosMax:int = 0;
        private var m_ColScrollPos:uint = 0;
        private var m_ColScrollPosMax:int = 0;
        private var m_DisplayWidth:Number = 0;
        private var m_DisplayHeight:Number = 0;
        private var m_LastNavDirection:int = -1;
        private var m_SelectedEntryId:* = null;
        private var m_uiController:* = 0;
        protected var m_Entries:Array;
        protected var m_ClipVector:Vector.<BSScrollingListEntry>;

        public function BCGridList()
        {
            this.m_Entries = [];
            this.m_ClipVector = new Vector.<BSScrollingListEntry>();
            if (this.Body_mc == null)
            {
                throw (new Error("BCGridList : Required instance Body_mc null or invalid."));
            };
            this.EntryHolder_mc = new MovieClip();
            this.EntryHolder_mc.name = "EntryHolder_mc";
            this.Body_mc.addChildAt(this.EntryHolder_mc, this.EntryHolder_mc.numChildren);
            if (this.ScrollUp_mc != null)
            {
                this.ScrollUp_mc.visible = false;
            };
            if (this.ScrollDown_mc != null)
            {
                this.ScrollDown_mc.visible = false;
            };
            if (this.ScrollLeft_mc != null)
            {
                this.ScrollLeft_mc.visible = false;
            };
            if (this.ScrollRight_mc != null)
            {
                this.ScrollRight_mc.visible = false;
            };
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            if (this.ScrollHoriz_mc != null)
            {
                this.ScrollHoriz_mc.visible = false;
                this.ScrollHoriz_mc.handleSizeViaContents = true;
            };
            if (this.ScrollVert_mc != null)
            {
                this.ScrollVert_mc.bVertical = true;
                this.ScrollVert_mc.visible = false;
                this.ScrollVert_mc.handleSizeViaContents = true;
            };
        }

        public function set showSelectedItem(_arg_1:Boolean):void
        {
            this.m_ShowSelectedItem = _arg_1;
            this.m_NeedRedraw = true;
            this.setIsDirty();
        }

        public function get showSelectedItem():Boolean
        {
            return (this.m_ShowSelectedItem);
        }

        public function set maxRows(_arg_1:uint):void
        {
            this.m_MaxRows = _arg_1;
            this.m_NeedRecreateClips = true;
        }

        public function set maxCols(_arg_1:uint):void
        {
            this.m_MaxCols = _arg_1;
            this.m_NeedRecreateClips = true;
        }

        public function set scrollVertical(_arg_1:Boolean):void
        {
            this.m_ScrollVertical = _arg_1;
            this.m_NeedRecalculateScrollMax = true;
            this.m_NeedRedraw = true;
            this.setIsDirty();
        }

        public function get scrollVertical():Boolean
        {
            return (this.m_ScrollVertical);
        }

        public function get selectedEntry():Object
        {
            return (this.m_Entries[this.m_SelectedIndex]);
        }

        public function get rowScrollPos():int
        {
            return (this.m_RowScrollPos);
        }

        public function get colScrollPos():int
        {
            return (this.m_ColScrollPos);
        }

        public function get displayWidth():Number
        {
            return (this.m_DisplayWidth);
        }

        public function get displayHeight():Number
        {
            return (this.m_DisplayHeight);
        }

        public function set rowScrollPos(_arg_1:int):void
        {
            _arg_1 = GlobalFunc.Clamp(_arg_1, 0, this.m_RowScrollPosMax);
            if (_arg_1 != this.m_RowScrollPos)
            {
                this.m_RowScrollPos = _arg_1;
                this.m_NeedRedraw = true;
                this.m_NeedSliderUpdate = true;
                this.setIsDirty();
            };
        }

        public function set colScrollPos(_arg_1:int):void
        {
            _arg_1 = GlobalFunc.Clamp(_arg_1, 0, this.m_ColScrollPosMax);
            if (_arg_1 != this.m_ColScrollPos)
            {
                this.m_ColScrollPos = _arg_1;
                this.m_NeedRedraw = true;
                this.m_NeedSliderUpdate = true;
                this.setIsDirty();
            };
        }

        public function set disableInput(_arg_1:Boolean):void
        {
            this.m_DisableInput = _arg_1;
        }

        public function get selectedCol():uint
        {
            return (this.getColFromIndex(this.m_SelectedIndex));
        }

        public function get selectedRow():uint
        {
            return (this.getRowFromIndex(this.m_SelectedIndex));
        }

        public function get displayedItemCount():uint
        {
            return (this.m_DisplayedItemCount);
        }

        public function get maxDisplayedItems():uint
        {
            return (this.m_MaxDisplayedItems);
        }

        public function get entryCount():uint
        {
            return (this.m_Entries.length);
        }

        public function get idName():String
        {
            return (this.m_IdName);
        }

        public function set idName(_arg_1:String):void
        {
            this.m_IdName = _arg_1;
        }

        public function get selectedEntryId():*
        {
            return (this.m_SelectedEntryId);
        }

        public function get selectedIndex():int
        {
            return (this.m_SelectedIndex);
        }

        public function set selectedIndex(_arg_1:int):*
        {
            var _local_2:int = GlobalFunc.Clamp(_arg_1, -1, (this.m_Entries.length - 1));
            if (_local_2 != this.m_SelectedIndex)
            {
                this.m_PrevSelectedIndex = this.m_SelectedIndex;
                this.m_SelectedIndex = _local_2;
                if (((((!(this.idName == "")) && (this.entryData)) && (this.m_SelectedIndex < this.entryData.length)) && (this.m_SelectedIndex > -1)))
                {
                    this.m_SelectedEntryId = this.entryData[this.m_SelectedIndex][this.idName];
                };
                dispatchEvent(new Event(SELECTION_CHANGE, true, true));
                this.constrainScrollToSelection();
                this.m_NeedRedraw = true;
                this.setIsDirty();
            };
        }

        public function get selectedClip():BSScrollingListEntry
        {
            return (this.m_SelectedClip);
        }

        public function set listItemClassName(_arg_1:String):void
        {
            this.m_ListItemClass = (getDefinitionByName(_arg_1) as Class);
            this.m_ListItemClassName = _arg_1;
            this.m_NeedRedraw = true;
        }

        public function get entryData():Array
        {
            return (this.m_Entries);
        }

        public function set entryData(_arg_1:Array):void
        {
            var _local_2:uint;
            this.m_Entries = _arg_1;
            this.m_NeedRecalculateScrollMax = true;
            this.m_NeedRedraw = true;
            if (((((this.setSelectedIndexOnFirstEntryDataInit) && (_arg_1)) && (_arg_1.length > 0)) && (this.selectedIndex <= -1)))
            {
                this.selectedIndex = 0;
            }
            else
            {
                if (((!(this.idName == "")) && (!(this.selectedEntryId == null))))
                {
                    _local_2 = 0;
                    while (_local_2 < this.entryData.length)
                    {
                        if (this.entryData[_local_2][this.idName] === this.selectedEntryId)
                        {
                            this.selectedIndex = _local_2;
                            break;
                        };
                        _local_2++;
                    };
                };
            };
            this.setIsDirty();
        }

        public function set needRedraw(_arg_1:*):void
        {
            this.m_NeedRedraw = _arg_1;
        }

        public function set wheelSelectionScroll(_arg_1:Boolean):void
        {
            this.m_WheelSelectionScroll = _arg_1;
        }

        public function get wheelSelectionScroll():Boolean
        {
            return (this.m_WheelSelectionScroll);
        }

        public function set selectionScrollLockOffset(_arg_1:int):void
        {
            this.m_SelectionScrollLockOffset = _arg_1;
        }

        public function get selectionScrollLockOffset():int
        {
            return (this.m_SelectionScrollLockOffset);
        }

        public function set selectionScrollLock(_arg_1:Boolean):void
        {
            this.m_SelectionScrollLock = _arg_1;
        }

        public function get selectionScrollLock():Boolean
        {
            return (this.m_SelectionScrollLock);
        }

        public function get lastNavDirection():int
        {
            return (this.m_LastNavDirection);
        }

        public function set entriesLayeredInOrder(_arg_1:Boolean):void
        {
            this.m_EntriesLayeredInOrder = _arg_1;
        }

        public function get entriesLayeredInOrder():Boolean
        {
            return (this.m_EntriesLayeredInOrder);
        }

        public function set setSelectedIndexOnFirstEntryDataInit(_arg_1:Boolean):void
        {
            this.m_SetSelectedIndexOnFirstEntryDataInit = _arg_1;
        }

        public function get setSelectedIndexOnFirstEntryDataInit():Boolean
        {
            return (this.m_SetSelectedIndexOnFirstEntryDataInit);
        }

        public function get prevSelectedIndex():int
        {
            return (this.m_PrevSelectedIndex);
        }

        private function getRowFromIndex(_arg_1:int):uint
        {
            if (_arg_1 > 0)
            {
                return (Math.floor((_arg_1 / (this.m_MaxCols + this.m_ColScrollPosMax))));
            };
            return (0);
        }

        private function getColFromIndex(_arg_1:int):uint
        {
            if (_arg_1 > 0)
            {
                return (_arg_1 % (this.m_MaxCols + this.m_ColScrollPosMax));
            };
            return (0);
        }

        public function setIsDirty():void
        {
            if (!this.m_IsDirty)
            {
                addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
                this.m_IsDirty = true;
            };
        }

        private function onEnterFrame(_arg_1:Event):void
        {
            this.selectedIndex = this.selectedIndex;
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            this.m_IsDirty = false;
            if (this.m_NeedRecalculateScrollMax)
            {
                this.calculateListScrollMax();
            };
            if (this.m_NeedRecreateClips)
            {
                this.createEntryClips();
            };
            if (((this.m_NeedRedraw) || (this.m_QueueSelectUnderMouse)))
            {
                this.m_ListStartIndex = ((this.m_ScrollVertical) ? (this.m_MaxCols * this.m_RowScrollPos) : (this.m_MaxRows * this.m_ColScrollPos));
            };
            if (this.m_QueueSelectUnderMouse)
            {
                this.selectItemUnderMouse();
            };
            if (this.m_NeedRedraw)
            {
                this.redrawList();
            };
        }

        public function getIndexFromGridPos(_arg_1:uint, _arg_2:uint):int
        {
            return ((_arg_1 * this.m_MaxCols) + _arg_2);
        }

        private function constrainScrollToSelection():void
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            if (this.m_NeedRecalculateScrollMax)
            {
                this.calculateListScrollMax();
            };
            if (this.selectedIndex > 0)
            {
                _local_1 = this.selectedRow;
                _local_2 = this.selectedCol;
                if (this.m_SelectionScrollLock)
                {
                    if (this.m_ScrollVertical)
                    {
                        this.rowScrollPos = (_local_1 + this.m_SelectionScrollLockOffset);
                    }
                    else
                    {
                        this.colScrollPos = (_local_2 + this.m_SelectionScrollLockOffset);
                    };
                }
                else
                {
                    if (this.m_ScrollVertical)
                    {
                        _local_3 = this.m_RowScrollPos;
                        _local_4 = ((this.m_RowScrollPos + this.m_MaxRows) - 1);
                        if (_local_1 < _local_3)
                        {
                            this.rowScrollPos = _local_1;
                        }
                        else
                        {
                            if (_local_1 > _local_4)
                            {
                                this.rowScrollPos = (_local_1 - (this.m_MaxRows - 1));
                            };
                        };
                    }
                    else
                    {
                        _local_5 = this.m_ColScrollPos;
                        _local_6 = ((this.m_ColScrollPos + this.m_MaxCols) - 1);
                        if (_local_2 < _local_5)
                        {
                            this.colScrollPos = _local_2;
                        }
                        else
                        {
                            if (_local_2 > _local_6)
                            {
                                this.colScrollPos = (_local_2 - (this.m_MaxCols - 1));
                            };
                        };
                    };
                };
            }
            else
            {
                this.rowScrollPos = 0;
                this.colScrollPos = 0;
            };
        }

        public function onKeyDown(_arg_1:KeyboardEvent):*
        {
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:Boolean;
            if (!this.m_DisableInput)
            {
                _local_2 = this.selectedRow;
                _local_3 = this.selectedCol;
                _local_4 = false;
                switch (_arg_1.keyCode)
                {
                    case Keyboard.UP:
                        if (_local_2 > 0)
                        {
                            _local_4 = true;
                            _local_2--;
                        };
                        _arg_1.stopPropagation();
                        break;
                    case Keyboard.DOWN:
                        if (_local_2 < this.getRowFromIndex((this.m_Entries.length - 1)))
                        {
                            _local_4 = true;
                            _local_2++;
                        };
                        _arg_1.stopPropagation();
                        break;
                    case Keyboard.LEFT:
                        if (_local_3 > 0)
                        {
                            _local_4 = true;
                            _local_3--;
                        };
                        _arg_1.stopPropagation();
                        break;
                    case Keyboard.RIGHT:
                        if (((_local_3 < ((this.m_MaxCols - 1) + this.m_ColScrollPosMax)) && (this.selectedIndex < (this.entryCount - 1))))
                        {
                            _local_4 = true;
                            _local_3++;
                        };
                        _arg_1.stopPropagation();
                        break;
                };
                this.m_LastNavDirection = _arg_1.keyCode;
                if (_local_4)
                {
                    this.selectedIndex = this.getIndexFromGridPos(_local_2, _local_3);
                }
                else
                {
                    dispatchEvent(new Event(SELECTION_EDGE_BOUNCE, true, true));
                };
            };
        }

        public function onKeyUp(_arg_1:KeyboardEvent):*
        {
            if ((((!(this.m_DisableInput)) && (!(this.m_DisableSelection))) && (_arg_1.keyCode == Keyboard.ENTER)))
            {
                this.onItemPress(_arg_1);
                _arg_1.stopPropagation();
            };
        }

        private function onItemClick(_arg_1:Event):void
        {
            if (((this.m_WheelSelectionScroll) && (this.m_uiController == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE)))
            {
                if ((_arg_1.target as BSScrollingListEntry).itemIndex != this.m_SelectedIndex)
                {
                    this.selectedIndex = (_arg_1.target as BSScrollingListEntry).itemIndex;
                }
                else
                {
                    if ((((!(this.m_DisableInput)) && (!(this.m_DisableSelection))) && (!(this.m_SelectedIndex == -1))))
                    {
                        dispatchEvent(new Event(ITEM_CLICKED, true, true));
                    };
                    this.onItemPress(_arg_1);
                };
            }
            else
            {
                if ((((!(this.m_DisableInput)) && (!(this.m_DisableSelection))) && (!(this.m_SelectedIndex == -1))))
                {
                    dispatchEvent(new Event(ITEM_CLICKED, true, true));
                };
                this.onItemPress(_arg_1);
            };
        }

        public function onItemPress(_arg_1:Event):void
        {
            if ((((!(this.m_DisableInput)) && (!(this.m_DisableSelection))) && (!(this.m_SelectedIndex == -1))))
            {
                dispatchEvent(new Event(ITEM_PRESS, true, true));
            }
            else
            {
                dispatchEvent(new Event(LIST_PRESS, true, true));
            };
        }

        private function onItemMouseOver(_arg_1:MouseEvent):void
        {
            if (((((!(this.m_DisableInput)) && (!(this.m_DisableSelection))) && (!(this.m_WheelSelectionScroll))) && (this.m_uiController == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE)))
            {
                this.selectedIndex = (_arg_1.currentTarget as BSScrollingListEntry).itemIndex;
                dispatchEvent(new Event(MOUSE_OVER_ITEM, true, true));
            };
        }

        private function onMouseWheel(_arg_1:MouseEvent):void
        {
            var _local_2:Boolean;
            if (((!(this.m_DisableInput)) && (this.m_uiController == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE)))
            {
                _local_2 = (_arg_1.delta < 0);
                if (this.m_WheelSelectionScroll)
                {
                    if (_local_2)
                    {
                        this.selectedIndex++;
                    }
                    else
                    {
                        if (this.selectedIndex > 0)
                        {
                            this.selectedIndex--;
                        };
                    };
                }
                else
                {
                    this.m_QueueSelectUnderMouse = true;
                    if (this.m_ScrollVertical)
                    {
                        this.scrollRow(_local_2);
                    }
                    else
                    {
                        this.scrollCol(_local_2);
                    };
                };
                _arg_1.stopPropagation();
            };
        }

        public function scrollRow(_arg_1:Boolean, _arg_2:*=false):void
        {
            var _local_3:int = ((_arg_1) ? (this.m_RowScrollPos + 1) : (this.m_RowScrollPos - 1));
            if (_arg_2)
            {
                if (_local_3 < 0)
                {
                    _local_3 = (this.m_RowScrollPosMax - 1);
                }
                else
                {
                    if (_local_3 >= this.m_RowScrollPosMax)
                    {
                        _local_3 = 0;
                    };
                };
            }
            else
            {
                _local_3 = Math.max(0, _local_3);
            };
            this.rowScrollPos = _local_3;
        }

        public function scrollCol(_arg_1:Boolean, _arg_2:*=false):void
        {
            var _local_3:int = ((_arg_1) ? (this.m_ColScrollPos + 1) : (this.m_ColScrollPos - 1));
            if (_arg_2)
            {
                if (_local_3 < 0)
                {
                    _local_3 = (this.m_ColScrollPosMax - 1);
                }
                else
                {
                    if (_local_3 >= this.m_ColScrollPosMax)
                    {
                        _local_3 = 0;
                    };
                };
            }
            else
            {
                _local_3 = Math.max(0, _local_3);
            };
            this.colScrollPos = _local_3;
        }

        private function onSliderValueChange(_arg_1:CustomEvent):void
        {
            if ((((this.m_ScrollVertical) && (!(this.ScrollVert_mc == null))) && (_arg_1.target == this.ScrollVert_mc)))
            {
                this.rowScrollPos = (_arg_1.params as uint);
            };
            if ((((!(this.m_ScrollVertical)) && (!(this.ScrollHoriz_mc == null))) && (_arg_1.target == this.ScrollHoriz_mc)))
            {
                this.colScrollPos = (_arg_1.params as uint);
            };
        }

        private function onPlatformChange(_arg_1:PlatformChangeEvent):void
        {
            this.m_uiController = _arg_1.uiController;
        }

        private function onAddedToStage(e:Event):void
        {
            if (this.ScrollUp_mc != null)
            {
                this.ScrollUp_mc.addEventListener(MouseEvent.CLICK, function (_arg_1:MouseEvent):*
                {
                    scrollRow(false);
                });
            };
            if (this.ScrollDown_mc != null)
            {
                this.ScrollDown_mc.addEventListener(MouseEvent.CLICK, function (_arg_1:MouseEvent):*
                {
                    scrollRow(true);
                });
            };
            if (this.ScrollLeft_mc != null)
            {
                this.ScrollLeft_mc.addEventListener(MouseEvent.CLICK, function (_arg_1:MouseEvent):*
                {
                    scrollCol(false);
                });
            };
            if (this.ScrollRight_mc != null)
            {
                this.ScrollRight_mc.addEventListener(MouseEvent.CLICK, function (_arg_1:MouseEvent):*
                {
                    scrollCol(true);
                });
            };
            addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
            addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            addEventListener(BSSlider.VALUE_CHANGED, this.onSliderValueChange);
            stage.addEventListener(PlatformChangeEvent.PLATFORM_CHANGE, this.onPlatformChange);
            stage.focus = this;
        }

        protected function populateEntryClip(aEntryClip:BSScrollingListEntry, aEntryData:Object):*
        {
            if (aEntryClip != null)
            {
                aEntryClip.selected = ((aEntryData == this.selectedEntry) && (this.m_ShowSelectedItem));
                if (aEntryClip.selected)
                {
                    this.m_SelectedClip = aEntryClip;
                };
                try
                {
                    aEntryClip.SetEntryText(aEntryData, this.m_TextBehavior);
                }
                catch(e:Error)
                {
                    trace(("BCGridList::populateEntryClip -- SetEntryText error: " + e.getStackTrace()));
                };
            };
        }

        private function calculateListScrollMax():void
        {
            var _local_1:uint;
            var _local_2:uint;
            if (this.m_ScrollVertical)
            {
                this.m_ColScrollPosMax = 0;
                _local_1 = Math.ceil((this.m_Entries.length / this.m_MaxCols));
                this.m_RowScrollPosMax = (_local_1 - this.m_MaxRows);
                if (this.ScrollVert_mc != null)
                {
                    this.ScrollVert_mc.dispatchOnValueChange = false;
                    this.ScrollVert_mc.minValue = 0;
                    this.ScrollVert_mc.maxValue = this.m_RowScrollPosMax;
                    this.ScrollVert_mc.dispatchOnValueChange = true;
                };
            }
            else
            {
                this.m_RowScrollPosMax = 0;
                _local_2 = Math.ceil((this.m_Entries.length / this.m_MaxRows));
                this.m_ColScrollPosMax = (_local_2 - this.m_MaxCols);
                if (this.ScrollHoriz_mc != null)
                {
                    this.ScrollHoriz_mc.dispatchOnValueChange = false;
                    this.ScrollHoriz_mc.minValue = 0;
                    this.ScrollHoriz_mc.maxValue = this.m_ColScrollPosMax;
                    this.ScrollHoriz_mc.dispatchOnValueChange = true;
                };
            };
            this.m_NeedRecalculateScrollMax = false;
            this.m_NeedRedraw = true;
        }

        public function clearList():void
        {
            this.m_Entries.splice(0, this.m_Entries.length);
        }

        private function getNewEntryClip():BSScrollingListEntry
        {
            return (new this.m_ListItemClass() as BSScrollingListEntry);
        }

        private function createEntryClip(_arg_1:uint, _arg_2:uint, _arg_3:uint):Boolean
        {
            var _local_4:BSScrollingListEntry = this.getNewEntryClip();
            if (_local_4 != null)
            {
                _local_4.parentClip = (this.parent as MovieClip);
                _local_4.clipIndex = _arg_1;
                _local_4.clipRow = _arg_2;
                _local_4.clipCol = _arg_3;
                _local_4.addEventListener(MouseEvent.MOUSE_OVER, this.onItemMouseOver);
                _local_4.addEventListener(MouseEvent.CLICK, this.onItemClick);
                if (this.m_EntriesLayeredInOrder)
                {
                    this.EntryHolder_mc.addChildAt(_local_4, 0);
                }
                else
                {
                    this.EntryHolder_mc.addChild(_local_4);
                };
                this.m_ClipVector.push(_local_4);
                return (true);
            };
            trace("BCGridList::createEntryClip -- m_ListItemClass is invalid or does not derive from BSScrollingListEntry.");
            return (false);
        }

        private function createEntryClips():void
        {
            var _local_4:BSScrollingListEntry;
            while (this.EntryHolder_mc.numChildren > 0)
            {
                _local_4 = this.getClipByIndex(0);
                _local_4.Dtor();
                this.EntryHolder_mc.removeChildAt(0);
            };
            this.m_ClipVector = new Vector.<BSScrollingListEntry>();
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            if (this.m_ScrollVertical)
            {
                _local_2 = 0;
                while (_local_2 < this.m_MaxRows)
                {
                    _local_3 = 0;
                    while (_local_3 < this.m_MaxCols)
                    {
                        if (this.createEntryClip(_local_1, _local_2, _local_3))
                        {
                            _local_1++;
                        };
                        _local_3++;
                    };
                    _local_2++;
                };
            }
            else
            {
                _local_3 = 0;
                while (_local_3 < this.m_MaxCols)
                {
                    _local_2 = 0;
                    while (_local_2 < this.m_MaxRows)
                    {
                        if (this.createEntryClip(_local_1, _local_2, _local_3))
                        {
                            _local_1++;
                        };
                        _local_2++;
                    };
                    _local_3++;
                };
            };
            this.m_MaxDisplayedItems = _local_1;
            this.m_NeedRecreateClips = false;
        }

        public function getClipByIndex(_arg_1:uint):BSScrollingListEntry
        {
            return ((_arg_1 < this.EntryHolder_mc.numChildren) ? (this.m_ClipVector[_arg_1] as BSScrollingListEntry) : null);
        }

        private function updateScrollIndicators():void
        {
            if (this.ScrollUp_mc != null)
            {
                this.ScrollUp_mc.visible = ((this.m_ScrollVertical) && (this.m_RowScrollPos > 0));
            };
            if (this.ScrollDown_mc != null)
            {
                this.ScrollDown_mc.visible = ((this.m_ScrollVertical) && (this.m_RowScrollPos < this.m_RowScrollPosMax));
            };
            if (this.ScrollLeft_mc != null)
            {
                this.ScrollLeft_mc.visible = ((!(this.m_ScrollVertical)) && (this.m_ColScrollPos > 0));
            };
            if (this.ScrollRight_mc != null)
            {
                this.ScrollRight_mc.visible = ((!(this.m_ScrollVertical)) && (this.m_ColScrollPos < this.m_ColScrollPosMax));
            };
            if (this.ScrollVert_mc != null)
            {
                if (((this.m_ScrollVertical) && (this.m_RowScrollPosMax > 0)))
                {
                    if (this.m_NeedSliderUpdate)
                    {
                        this.ScrollVert_mc.doSetValue(this.m_RowScrollPos, false);
                    };
                    this.ScrollVert_mc.visible = true;
                }
                else
                {
                    this.ScrollVert_mc.visible = false;
                };
            };
            if (this.ScrollHoriz_mc != null)
            {
                if (((!(this.m_ScrollVertical)) && (this.m_ColScrollPosMax > 0)))
                {
                    if (this.m_NeedSliderUpdate)
                    {
                        this.ScrollHoriz_mc.doSetValue(this.m_ColScrollPos, false);
                    };
                    this.ScrollHoriz_mc.visible = true;
                }
                else
                {
                    this.ScrollHoriz_mc.visible = false;
                };
            };
            this.m_NeedSliderUpdate = false;
        }

        private function selectItemUnderMouse():void
        {
            var _local_1:uint;
            var _local_2:BSScrollingListEntry;
            var _local_3:MovieClip;
            var _local_4:Point;
            if ((((!(this.m_DisableSelection)) && (!(this.m_DisableInput))) && (this.m_uiController == PlatformChangeEvent.PLATFORM_PC_KB_MOUSE)))
            {
                this.m_QueueSelectUnderMouse = false;
                _local_1 = 0;
                while (_local_1 < this.m_MaxDisplayedItems)
                {
                    _local_2 = this.m_ClipVector[_local_1];
                    _local_3 = (_local_2 as MovieClip);
                    if (_local_2.Sizer_mc != null)
                    {
                        _local_3 = _local_2.Sizer_mc;
                    };
                    _local_4 = localToGlobal(new Point(mouseX, mouseY));
                    if (_local_3.hitTestPoint(_local_4.x, _local_4.y, false))
                    {
                        this.selectedIndex = (this.m_ListStartIndex + _local_1);
                    };
                    _local_1++;
                };
            };
        }

        protected function redrawList():void
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:uint;
            var _local_11:BSScrollingListEntry;
            this.m_DisplayWidth = 0;
            this.m_DisplayHeight = 0;
            this.m_DisplayedItemCount = 0;
            this.m_SelectedClip = null;
            if (this.m_MaxDisplayedItems > 0)
            {
                _local_1 = this.m_ListStartIndex;
                _local_2 = this.m_Entries.length;
                _local_3 = 0;
                _local_6 = 0;
                _local_7 = 0;
                _local_8 = 0;
                _local_9 = 0;
                _local_10 = 0;
                while (_local_10 < this.m_MaxDisplayedItems)
                {
                    _local_11 = this.m_ClipVector[_local_10];
                    if (_local_11 != null)
                    {
                        if ((_local_10 + _local_1) < _local_2)
                        {
                            _local_11.itemIndex = (_local_10 + _local_1);
                            this.populateEntryClip(_local_11, this.m_Entries[(_local_10 + _local_1)]);
                            this.m_DisplayedItemCount++;
                            if (_local_11.Sizer_mc != null)
                            {
                                _local_4 = _local_11.Sizer_mc.width;
                                _local_5 = _local_11.Sizer_mc.height;
                            }
                            else
                            {
                                _local_4 = _local_11.width;
                                _local_5 = _local_11.height;
                            };
                            _local_11.visible = true;
                            _local_11.x = (_local_4 * _local_11.clipCol);
                            _local_11.y = (_local_5 * _local_11.clipRow);
                            _local_8 = Math.max(_local_8, (_local_11.x + _local_4));
                            _local_9 = Math.max(_local_9, (_local_11.y + _local_5));
                        }
                        else
                        {
                            _local_11.visible = false;
                            _local_11.itemIndex = int.MAX_VALUE;
                        };
                    };
                    _local_10++;
                };
                this.m_DisplayWidth = _local_8;
                this.m_DisplayHeight = _local_9;
                this.updateScrollIndicators();
            }
            else
            {
                trace(("BCGridList::redrawList -- List configuration resulted in m_MaxDisplayedItems < 1 (unable to display any items) - " + this.name));
            };
            dispatchEvent(new Event(LIST_UPDATED, true, true));
            this.m_NeedRedraw = false;
        }


    }
}//package Shared.AS3

