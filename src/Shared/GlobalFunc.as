// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.GlobalFunc

package Shared
{
    import flash.utils.ByteArray;
    import Shared.AS3.SWFLoaderClip;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import scaleform.gfx.Extensions;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.display.DisplayObject;
    import flash.utils.getQualifiedClassName;
    import flash.utils.describeType;
    import flash.events.Event;
    import Shared.AS3.Data.BSUIDataManager;
    import Shared.AS3.Events.CustomEvent;
    import Shared.AS3.BSScrollingList;
    import Shared.AS3.BCGridList;
    import flash.system.fscommand;

    public class GlobalFunc 
    {

        public static const PIPBOY_GREY_OUT_ALPHA:Number = 0.5;
        public static const SELECTED_RECT_ALPHA:Number = 1;
        public static const DIMMED_ALPHA:Number = 0.65;
        public static const NUM_DAMAGE_TYPES:uint = 6;
        public static const PLAYER_ICON_TEXTURE_BUFFER:String = "AvatarTextureBuffer";
        public static const STORE_IMAGE_TEXTURE_BUFFER:String = "StoreTextureBuffer";
        public static const MAP_TEXTURE_BUFFER:String = "MapMenuTextureBuffer";
        protected static const CLOSE_ENOUGH_EPSILON:Number = 0.001;
        public static const MAX_TRUNCATED_TEXT_LENGTH:* = 42;
        public static const PLAY_FOCUS_SOUND:String = "GlobalFunc::playFocusSound";
        public static const PLAY_MENU_SOUND:String = "GlobalFunc::playMenuSound";
        public static const SHOW_HUD_MESSAGE:String = "GlobalFunc::showHUDMessage";
        public static const MENU_SOUND_OK:String = "UIMenuOK";
        public static const MENU_SOUND_CANCEL:String = "UIMenuCancel";
        public static const MENU_SOUND_PREV_NEXT:String = "UIMenuPrevNext";
        public static const MENU_SOUND_POPUP:String = "UIMenuPopupGeneric";
        public static const MENU_SOUND_FOCUS_CHANGE:String = "UIMenuFocus";
        public static const MENU_SOUND_FRIEND_PROMPT_OPEN:String = "UIMenuPromptFriendRequestBladeOpen";
        public static const MENU_SOUND_FRIEND_PROMPT_CLOSE:String = "UIMenuPromptFriendRequestBladeClose";
        public static const BUTTON_BAR_ALIGN_CENTER:uint = 0;
        public static const BUTTON_BAR_ALIGN_LEFT:uint = 1;
        public static const BUTTON_BAR_ALIGN_RIGHT:uint = 2;
        public static const COLOR_TEXT_BODY:uint = 16777163;
        public static const COLOR_TEXT_HEADER:uint = 16108379;
        public static const COLOR_TEXT_SELECTED:uint = 1580061;
        public static const COLOR_TEXT_FRIEND:uint = COLOR_TEXT_HEADER;//16108379
        public static const COLOR_TEXT_ENEMY:uint = 16741472;
        public static const COLOR_TEXT_UNAVAILABLE:uint = 5661031;
        public static const COLOR_BACKGROUND_BOX:uint = 3225915;
        public static const COOR_WARNING:uint = 15089200;
        public static const COLOR_WARNING_ACCENT:uint = 16151129;
        public static const COLOR_RARITY_LEGENDARY:uint = 15046481;
        public static const COLOR_RARITY_EPIC:uint = 10763770;
        public static const COLOR_RARITY_RARE:uint = 4960214;
        public static const COLOR_RARITY_COMMON:uint = 9043803;
        public static const FRAME_RARITY_NONE:String = "None";
        public static const FRAME_RARITY_COMMON:String = "Common";
        public static const FRAME_RARITY_RARE:String = "Rare";
        public static const FRAME_RARITY_EPIC:String = "Epic";
        public static const FRAME_RARITY_LEGENDARY:String = "Legendary";
        public static var TEXT_SIZE_VERYSMALL:Number = 16;
        public static var TEXT_SIZE_MIN:Number = 14;
        public static var TEXT_LEADING_MIN:Number = -2;
        public static const VOICE_STATUS_UNAVAILABLE:uint = 0;
        public static const VOICE_STATUS_AVAILABLE:uint = 1;
        public static const VOICE_STATUS_SPEAKING:uint = 2;
        public static const WORLD_TYPE_INVALID:uint = 0;
        public static const WORLD_TYPE_NORMAL:uint = 1;
        public static const WORLD_TYPE_SURVIVAL:uint = 2;
        public static const WORLD_TYPE_NWTEMP:uint = 3;
        public static const WORLD_TYPE_NUCLEARWINTER:uint = 4;
        public static const WORLD_TYPE_PRIVATE:uint = 5;
        public static const QUEST_DISPLAY_TYPE_NONE:uint = 0;
        public static const QUEST_DISPLAY_TYPE_MAIN:uint = 1;
        public static const QUEST_DISPLAY_TYPE_SIDE:uint = 2;
        public static const QUEST_DISPLAY_TYPE_MISC:uint = 3;
        public static const QUEST_DISPLAY_TYPE_EVENT:uint = 4;
        public static const QUEST_DISPLAY_TYPE_OTHER:uint = 5;
        public static const STAT_VALUE_TYPE_INTEGER:uint = 0;
        public static const STAT_VALUE_TYPE_TIME:uint = 1;
        public static const STAT_VALUE_TYPE_CAPS:uint = 2;
        public static var STAT_TYPE_INVALID:uint = 20;
        public static var STAT_TYPE_SURVIVAL_SCORE:* = 29;
        public static const EVENT_USER_CONTEXT_MENU_ACTION:String = "UserContextMenu::MenuOptionSelected";
        public static const EVENT_OPEN_USER_CONTEXT_MENU:String = "UserContextMenu::UserSelected";
        public static const USER_MENU_CONTEXT_ALL:uint = 0;
        public static const USER_MENU_CONTEXT_FRIENDS:uint = 1;
        public static const USER_MENU_CONTEXT_TEAM:uint = 2;
        public static const USER_MENU_CONTEXT_RECENT:uint = 3;
        public static const USER_MENU_CONTEXT_BLOCKED:uint = 4;
        public static const USER_MENU_CONTEXT_MAP:uint = 5;
        public static const MTX_CURRENCY_ATOMS:uint = 0;
        public static const ALIGN_LEFT:uint = 0;
        public static const ALIGN_CENTER:uint = 1;
        public static const ALIGN_RIGHT:uint = 2;
        public static const DURABILITY_MAX:uint = 100;
        public static const DIRECTION_NONE:* = 0;
        public static const DIRECTION_UP:* = 1;
        public static const DIRECTION_RIGHT:* = 2;
        public static const DIRECTION_DOWN:* = 3;
        public static const DIRECTION_LEFT:* = 4;
        public static const REWARD_TYPE_ENUM_ATOMS:* = 0;
        public static const REWARD_TYPE_ENUM_PERK_PACKS:* = 1;
        public static const REWARD_TYPE_ENUM_PHOTO_FRAMES:* = 2;
        public static const REWARD_TYPE_ENUM_EMOTES:* = 3;
        public static const REWARD_TYPE_ENUM_ICONS:* = 4;
        public static const REWARD_TYPE_ENUM_WEAPON:* = 5;
        public static const REWARD_TYPE_ENUM_WEAPON_MOD:* = 6;
        public static const REWARD_TYPE_ENUM_ARMOR:* = 7;
        public static const REWARD_TYPE_ENUM_ARMOR_MOD:* = 8;
        public static const REWARD_TYPE_ENUM_AMMO:* = 9;
        public static const REWARD_TYPE_ENUM_PHOTO_POSE:* = 10;
        public static const REWARD_TYPE_ENUM_COMPONENTS:* = 11;
        public static const REWARD_TYPE_ENUM_EXPERIENCE:* = 12;
        public static const REWARD_TYPE_ENUM_BADGES:* = 13;
        public static const REWARD_TYPE_ENUM_STIMPAKS:* = 14;
        public static const REWARD_TYPE_ENUM_CHEMS:* = 15;
        public static const REWARD_TYPE_ENUM_BOOK:* = 16;
        public static const REWARD_TYPE_ENUM_CAPS:* = 17;
        public static const REWARD_TYPE_ENUM_LEGENDARY_TOKENS:* = 18;
        public static const REWARD_TYPE_ENUM_POSSUM_BADGES:* = 19;
        public static const REWARD_TYPE_ENUM_TADPOLE_BADGES:* = 20;
        public static const REWARD_TYPE_ENUM_CUSTOM_ICON:* = 21;
        public static const REWARD_TYPE_ENUM_CAMP:* = 22;
        public static const REWARD_TYPE_ENUM_GOLD_BULLION:* = 23;
        public static const REWARD_TYPE_ENUM_SCORE:* = 24;
        public static const REWARD_TYPE_ENUM_REPAIR_KIT:* = 25;
        public static const REWARD_TYPE_ENUM_LUNCH_BOX:* = 26;
        public static const REWARD_TYPE_ENUM_PREMIUM:* = 27;
        public static const IMAGE_FRAME_MAP:Object = {
            "a":1,
            "b":2,
            "c":3,
            "d":4,
            "e":5,
            "f":6,
            "g":7,
            "h":8,
            "i":9,
            "j":10,
            "k":11,
            "l":12,
            "m":13,
            "n":14,
            "o":15,
            "p":16,
            "q":17,
            "r":18,
            "s":19,
            "t":20,
            "u":21,
            "v":22,
            "w":23,
            "x":24,
            "y":25,
            "z":26,
            "0":1,
            "1":2,
            "2":3,
            "3":4,
            "4":5,
            "5":6,
            "6":7,
            "7":8,
            "8":9,
            "9":10
        };


        public static function CloneObject(_arg_1:Object):*
        {
            var _local_2:ByteArray = new ByteArray();
            _local_2.writeObject(_arg_1);
            _local_2.position = 0;
            return (_local_2.readObject());
        }

        public static function Lerp(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Boolean):Number
        {
            var _local_7:Number = (_arg_1 + (((_arg_5 - _arg_3) / (_arg_4 - _arg_3)) * (_arg_2 - _arg_1)));
            if (_arg_6)
            {
                if (_arg_1 < _arg_2)
                {
                    _local_7 = Math.min(Math.max(_local_7, _arg_1), _arg_2);
                }
                else
                {
                    _local_7 = Math.min(Math.max(_local_7, _arg_2), _arg_1);
                };
            };
            return (_local_7);
        }

        public static function PadNumber(_arg_1:Number, _arg_2:uint):String
        {
            var _local_3:String = ("" + _arg_1);
            while (_local_3.length < _arg_2)
            {
                _local_3 = ("0" + _local_3);
            };
            return (_local_3);
        }

        public static function setChallengeRewardIcon(_arg_1:SWFLoaderClip, _arg_2:uint, _arg_3:String=""):MovieClip
        {
            var _local_4:String;
            switch (_arg_2)
            {
                case REWARD_TYPE_ENUM_ATOMS:
                    _local_4 = "IconCR_Atoms";
                    break;
                case REWARD_TYPE_ENUM_PERK_PACKS:
                    _local_4 = "IconCR_PerkPack";
                    break;
                case REWARD_TYPE_ENUM_PHOTO_FRAMES:
                    _local_4 = "IconCR_PhotoMode";
                    break;
                case REWARD_TYPE_ENUM_EMOTES:
                    _local_4 = "IconCR_Emote";
                    break;
                case REWARD_TYPE_ENUM_ICONS:
                    _local_4 = "IconCR_PlayerIcon";
                    break;
                case REWARD_TYPE_ENUM_WEAPON:
                    _local_4 = "IconCR_Weapon";
                    break;
                case REWARD_TYPE_ENUM_WEAPON_MOD:
                    _local_4 = "IconCR_WeaponMod";
                    break;
                case REWARD_TYPE_ENUM_ARMOR:
                    _local_4 = "IconCR_Armor";
                    break;
                case REWARD_TYPE_ENUM_ARMOR_MOD:
                    _local_4 = "IconCR_ArmorMod";
                    break;
                case REWARD_TYPE_ENUM_AMMO:
                    _local_4 = "IconCR_Ammo";
                    break;
                case REWARD_TYPE_ENUM_PHOTO_POSE:
                    _local_4 = "IconCR_PhotoMode";
                    break;
                case REWARD_TYPE_ENUM_COMPONENTS:
                    _local_4 = "IconCR_Components";
                    break;
                case REWARD_TYPE_ENUM_EXPERIENCE:
                    _local_4 = "IconCR_Experience";
                    break;
                case REWARD_TYPE_ENUM_BADGES:
                    _local_4 = "IconCR_Badges";
                    break;
                case REWARD_TYPE_ENUM_STIMPAKS:
                    _local_4 = "IconCR_Stimpaks";
                    break;
                case REWARD_TYPE_ENUM_CHEMS:
                    _local_4 = "IconCR_Chems";
                    break;
                case REWARD_TYPE_ENUM_BOOK:
                    _local_4 = "IconCR_Recipe";
                    break;
                case REWARD_TYPE_ENUM_CAPS:
                    _local_4 = "IconCR_Caps";
                    break;
                case REWARD_TYPE_ENUM_LEGENDARY_TOKENS:
                    _local_4 = "IconCR_LegendaryToken";
                    break;
                case REWARD_TYPE_ENUM_POSSUM_BADGES:
                case REWARD_TYPE_ENUM_TADPOLE_BADGES:
                    _local_4 = "IconCR_Caps";
                    break;
                case REWARD_TYPE_ENUM_CUSTOM_ICON:
                    if (_arg_3.length > 0)
                    {
                        _local_4 = _arg_3;
                    }
                    else
                    {
                        throw (new Error("GlobalFunc.setChallengeRewardIcon: No custom icon specified."));
                    };
                    break;
                case REWARD_TYPE_ENUM_CAMP:
                    _local_4 = "IconCR_Camp";
                    break;
                case REWARD_TYPE_ENUM_GOLD_BULLION:
                    _local_4 = "IconCR_GoldBullion";
                    break;
                case REWARD_TYPE_ENUM_SCORE:
                    _local_4 = "IconCR_Score";
                    break;
                case REWARD_TYPE_ENUM_REPAIR_KIT:
                    _local_4 = "IconCR_RepairKit";
                    break;
                case REWARD_TYPE_ENUM_LUNCH_BOX:
                    _local_4 = "IconCR_LunchBox";
                    break;
                case REWARD_TYPE_ENUM_PREMIUM:
                    _local_4 = "IconCR_Premium";
                    break;
            };
            return (_arg_1.setContainerIconClip(_local_4));
        }

        public static function parseStatValue(_arg_1:Number, _arg_2:uint):String
        {
            switch (_arg_2)
            {
                case GlobalFunc.STAT_VALUE_TYPE_TIME:
                    return (ShortTimeString(_arg_1));
            };
            return (_arg_1.toString());
        }

        public static function ShortTimeStringMinutes(_arg_1:Number):String
        {
            var _local_2:TextField = new TextField();
            var _local_3:Number = 0;
            var _local_4:Number = Math.floor((_arg_1 / 86400));
            _local_3 = (_arg_1 % 86400);
            var _local_5:Number = Math.floor((_local_3 / 3600));
            _local_3 = (_arg_1 % 3600);
            var _local_6:Number = Math.floor((_local_3 / 60));
            var _local_7:* = 0;
            if (_local_4 >= 1)
            {
                _local_2.text = "$ShortTimeDays";
                _local_7 = _local_4;
            }
            else
            {
                if (_local_5 >= 1)
                {
                    _local_2.text = "$ShortTimeHours";
                    _local_7 = _local_5;
                }
                else
                {
                    _local_2.text = "$ShortTimeMinutes";
                    _local_7 = _local_6;
                };
            };
            _local_2.text = _local_2.text.replace("{time}", _local_7.toString());
            return (_local_2.text);
        }

        public static function ShortTimeString(_arg_1:Number):String
        {
            var _local_2:Number = 0;
            var _local_3:TextField = new TextField();
            var _local_4:Number = Math.floor((_arg_1 / 86400));
            _local_2 = (_arg_1 % 86400);
            var _local_5:Number = Math.floor((_local_2 / 3600));
            _local_2 = (_arg_1 % 3600);
            var _local_6:Number = Math.floor((_local_2 / 60));
            _local_2 = (_arg_1 % 60);
            var _local_7:Number = Math.floor(_local_2);
            var _local_8:* = 0;
            if (_local_4 >= 1)
            {
                _local_3.text = "$ShortTimeDays";
                _local_8 = _local_4;
            }
            else
            {
                if (_local_5 >= 1)
                {
                    _local_3.text = "$ShortTimeHours";
                    _local_8 = _local_5;
                }
                else
                {
                    if (_local_6 >= 1)
                    {
                        _local_3.text = "$ShortTimeMinutes";
                        _local_8 = _local_6;
                    }
                    else
                    {
                        if (_local_7 >= 1)
                        {
                            _local_3.text = "$ShortTimeSeconds";
                            _local_8 = _local_7;
                        }
                        else
                        {
                            _local_3.text = "$ShortTimeSecond";
                            _local_8 = _local_7;
                        };
                    };
                };
            };
            if (_local_8 != 0)
            {
                _local_3.text = _local_3.text.replace("{time}", _local_8.toString());
                return (_local_3.text);
            };
            return ("0");
        }

        public static function SimpleTimeString(_arg_1:Number):String
        {
            var _local_2:Number = 0;
            var _local_3:TextField = new TextField();
            var _local_4:Number = Math.floor((_arg_1 / 86400));
            _local_2 = (_arg_1 % 86400);
            var _local_5:Number = Math.floor((_local_2 / 3600));
            _local_2 = (_arg_1 % 3600);
            var _local_6:Number = Math.floor((_local_2 / 60));
            _local_2 = (_arg_1 % 60);
            var _local_7:Number = Math.floor(_local_2);
            var _local_8:* = 0;
            if (_local_4 > 1)
            {
                _local_3.text = "$SimpleTimeDays";
                _local_8 = _local_4;
            }
            else
            {
                if (_local_4 == 1)
                {
                    _local_3.text = "$SimpleTimeDay";
                    _local_8 = _local_4;
                }
                else
                {
                    if (_local_5 > 1)
                    {
                        _local_3.text = "$SimpleTimeHours";
                        _local_8 = _local_5;
                    }
                    else
                    {
                        if (_local_5 == 1)
                        {
                            _local_3.text = "$SimpleTimeHour";
                            _local_8 = _local_5;
                        }
                        else
                        {
                            if (_local_6 > 1)
                            {
                                _local_3.text = "$SimpleTimeMinutes";
                                _local_8 = _local_6;
                            }
                            else
                            {
                                if (_local_6 == 1)
                                {
                                    _local_3.text = "$SimpleTimeMinute";
                                    _local_8 = _local_6;
                                }
                                else
                                {
                                    if (_local_7 > 1)
                                    {
                                        _local_3.text = "$SimpleTimeSeconds";
                                        _local_8 = _local_7;
                                    }
                                    else
                                    {
                                        if (_local_7 == 1)
                                        {
                                            _local_3.text = "$SimpleTimeSecond";
                                            _local_8 = _local_7;
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (_local_8 != 0)
            {
                _local_3.text = _local_3.text.replace("{time}", _local_8.toString());
                return (_local_3.text);
            };
            return ("0");
        }

        public static function FormatTimeString(_arg_1:Number):String
        {
            var _local_2:Number = 0;
            var _local_3:Number = Math.floor((_arg_1 / 86400));
            _local_2 = (_arg_1 % 86400);
            var _local_4:Number = Math.floor((_local_2 / 3600));
            _local_2 = (_arg_1 % 3600);
            var _local_5:Number = Math.floor((_local_2 / 60));
            _local_2 = (_arg_1 % 60);
            var _local_6:Number = Math.floor(_local_2);
            var _local_7:Boolean;
            var _local_8:* = "";
            if (_local_3 > 0)
            {
                _local_8 = PadNumber(_local_3, 2);
                _local_7 = true;
            };
            if (((_local_3 > 0) || (_local_4 > 0)))
            {
                if (_local_7)
                {
                    _local_8 = (_local_8 + ":");
                }
                else
                {
                    _local_7 = true;
                };
                _local_8 = (_local_8 + PadNumber(_local_4, 2));
            };
            if ((((_local_3 > 0) || (_local_4 > 0)) || (_local_5 > 0)))
            {
                if (_local_7)
                {
                    _local_8 = (_local_8 + ":");
                }
                else
                {
                    _local_7 = true;
                };
                _local_8 = (_local_8 + PadNumber(_local_5, 2));
            };
            if (((((_local_3 > 0) || (_local_4 > 0)) || (_local_5 > 0)) || (_local_6 > 0)))
            {
                if (_local_7)
                {
                    _local_8 = (_local_8 + ":");
                }
                else
                {
                    if ((((_local_3 == 0) && (_local_4 == 0)) && (_local_5 == 0)))
                    {
                        _local_8 = "0:";
                    };
                };
                _local_8 = (_local_8 + PadNumber(_local_6, 2));
            };
            return (_local_8);
        }

        public static function ImageFrameFromCharacter(_arg_1:String):uint
        {
            var _local_2:String;
            if (((!(_arg_1 == null)) && (_arg_1.length > 0)))
            {
                _local_2 = _arg_1.substring(0, 1).toLowerCase();
                if (IMAGE_FRAME_MAP[_local_2] != null)
                {
                    return (IMAGE_FRAME_MAP[_local_2]);
                };
            };
            return (1);
        }

        public static function GetAccountIconPath(_arg_1:String):String
        {
            if (((_arg_1 == null) || (_arg_1.length == 0)))
            {
                _arg_1 = "Textures/ATX/Storefront/Player/PlayerIcons/ATX_PlayerIcon_VaultBoy_76.dds";
            };
            return (_arg_1);
        }

        public static function RoundDecimal(_arg_1:Number, _arg_2:Number):Number
        {
            var _local_3:Number = Math.pow(10, _arg_2);
            return (Math.round((_local_3 * _arg_1)) / _local_3);
        }

        public static function CloseToNumber(_arg_1:Number, _arg_2:Number, _arg_3:Number=0.001):Boolean
        {
            return (Math.abs((_arg_1 - _arg_2)) < _arg_3);
        }

        public static function Clamp(_arg_1:Number, _arg_2:Number, _arg_3:Number):Number
        {
            return (Math.max(_arg_2, Math.min(_arg_3, _arg_1)));
        }

        public static function MaintainTextFormat():*
        {
            TextField.prototype.SetText = function (_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false):*
            {
                var _local_5:Number;
                var _local_6:Boolean;
                if (((!(_arg_1)) || (_arg_1 == "")))
                {
                    _arg_1 = " ";
                };
                if (((_arg_3) && (!(_arg_1.charAt(0) == "$"))))
                {
                    _arg_1 = _arg_1.toUpperCase();
                };
                var _local_4:TextFormat = this.getTextFormat();
                if (_arg_2)
                {
                    _local_5 = Number(_local_4.letterSpacing);
                    _local_6 = _local_4.kerning;
                    this.htmlText = _arg_1;
                    _local_4 = this.getTextFormat();
                    _local_4.letterSpacing = _local_5;
                    _local_4.kerning = _local_6;
                    this.setTextFormat(_local_4);
                    this.htmlText = _arg_1;
                }
                else
                {
                    this.text = _arg_1;
                    this.setTextFormat(_local_4);
                    this.text = _arg_1;
                };
            };
        }

        public static function SetText(_arg_1:TextField, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false, _arg_5:*=false):*
        {
            var _local_6:TextFormat;
            var _local_7:Number;
            var _local_8:Boolean;
            if (((!(_arg_2)) || (_arg_2 == "")))
            {
                _arg_2 = " ";
            };
            if (((_arg_4) && (!(_arg_2.charAt(0) == "$"))))
            {
                _arg_2 = _arg_2.toUpperCase();
            };
            if (_arg_3)
            {
                _local_6 = _arg_1.getTextFormat();
                _local_7 = Number(_local_6.letterSpacing);
                _local_8 = _local_6.kerning;
                _arg_1.htmlText = _arg_2;
                _local_6 = _arg_1.getTextFormat();
                _local_6.letterSpacing = _local_7;
                _local_6.kerning = _local_8;
                _arg_1.setTextFormat(_local_6);
            }
            else
            {
                _arg_1.text = _arg_2;
            };
            if (((_arg_5) && (_arg_1.text.length > MAX_TRUNCATED_TEXT_LENGTH)))
            {
                _arg_1.text = (_arg_1.text.slice(0, (MAX_TRUNCATED_TEXT_LENGTH - 3)) + "...");
            };
        }

        public static function LockToSafeRect(_arg_1:DisplayObject, _arg_2:String, _arg_3:Number=0, _arg_4:Number=0):*
        {
            var _local_5:Rectangle = Extensions.visibleRect;
            var _local_6:Point = new Point((_local_5.x + _arg_3), (_local_5.y + _arg_4));
            var _local_7:Point = new Point(((_local_5.x + _local_5.width) - _arg_3), ((_local_5.y + _local_5.height) - _arg_4));
            var _local_8:Point = _arg_1.parent.globalToLocal(_local_6);
            var _local_9:Point = _arg_1.parent.globalToLocal(_local_7);
            var _local_10:Point = Point.interpolate(_local_8, _local_9, 0.5);
            if (((((_arg_2 == "T") || (_arg_2 == "TL")) || (_arg_2 == "TR")) || (_arg_2 == "TC")))
            {
                _arg_1.y = _local_8.y;
            };
            if ((((_arg_2 == "CR") || (_arg_2 == "CC")) || (_arg_2 == "CL")))
            {
                _arg_1.y = _local_10.y;
            };
            if (((((_arg_2 == "B") || (_arg_2 == "BL")) || (_arg_2 == "BR")) || (_arg_2 == "BC")))
            {
                _arg_1.y = _local_9.y;
            };
            if (((((_arg_2 == "L") || (_arg_2 == "TL")) || (_arg_2 == "BL")) || (_arg_2 == "CL")))
            {
                _arg_1.x = _local_8.x;
            };
            if ((((_arg_2 == "TC") || (_arg_2 == "CC")) || (_arg_2 == "BC")))
            {
                _arg_1.x = _local_10.x;
            };
            if (((((_arg_2 == "R") || (_arg_2 == "TR")) || (_arg_2 == "BR")) || (_arg_2 == "CR")))
            {
                _arg_1.x = _local_9.x;
            };
        }

        public static function AddMovieExploreFunctions():*
        {
            MovieClip.prototype.getMovieClips = function ():Array
            {
                var _local_2:*;
                var _local_1:* = new Array();
                for (_local_2 in this)
                {
                    if (((this[_local_2] is MovieClip) && (!(this[_local_2] == this))))
                    {
                        _local_1.push(this[_local_2]);
                    };
                };
                return (_local_1);
            };
            MovieClip.prototype.showMovieClips = function ():*
            {
                var _local_1:*;
                for (_local_1 in this)
                {
                    if (((this[_local_1] is MovieClip) && (!(this[_local_1] == this))))
                    {
                        trace(this[_local_1]);
                        this[_local_1].showMovieClips();
                    };
                };
            };
        }

        public static function InspectObject(_arg_1:Object, _arg_2:Boolean=false, _arg_3:Boolean=false):*
        {
            var _local_4:String = getQualifiedClassName(_arg_1);
            trace(("Inspecting object with type " + _local_4));
            trace("{");
            InspectObjectHelper(_arg_1, _arg_2, _arg_3);
            trace("}");
			var tempval:* = "Inspecting object with type " + _local_4 + InspectObjectHelper(_arg_1, _arg_2, _arg_3);
			return tempval;
        }

        private static function InspectObjectHelper(aObject:Object, abRecursive:Boolean, abIncludeProperties:Boolean, astrIndent:String="\t"):void
        {
            var member:XML;
            var constMember:XML;
            var id:String;
            var prop:XML;
            var propName:String;
            var propValue:Object;
            var memberName:String;
            var memberValue:Object;
            var constMemberName:String;
            var constMemberValue:Object;
            var value:Object;
            var subid:String;
            var subvalue:Object;
            var typeDef:XML = describeType(aObject);
            if (abIncludeProperties)
            {
                for each (prop in typeDef.accessor.((@access == "readwrite") || (@access == "readonly")))
                {
                    propName = prop.@name;
                    propValue = aObject[prop.@name];
                    trace((((astrIndent + propName) + " = ") + propValue));
                    if (abRecursive)
                    {
                        InspectObjectHelper(propValue, abRecursive, abIncludeProperties, (astrIndent + "\t"));
                    };
                };
            };
            for each (member in typeDef.variable)
            {
                memberName = member.@name;
                memberValue = aObject[memberName];
                trace((((astrIndent + memberName) + " = ") + memberValue));
                if (abRecursive)
                {
                    InspectObjectHelper(memberValue, true, abIncludeProperties, (astrIndent + "\t"));
                };
            };
            for each (constMember in typeDef.constant)
            {
                constMemberName = constMember.@name;
                constMemberValue = aObject[constMemberName];
                trace(((((astrIndent + constMemberName) + " = ") + constMemberValue) + " --const"));
                if (abRecursive)
                {
                    InspectObjectHelper(constMemberValue, true, abIncludeProperties, (astrIndent + "\t"));
                };
            };
            for (id in aObject)
            {
                value = aObject[id];
                trace((((astrIndent + id) + " = ") + value));
                if (abRecursive)
                {
                    InspectObjectHelper(value, true, abIncludeProperties, (astrIndent + "\t"));
                }
                else
                {
                    for (subid in value)
                    {
                        subvalue = value[subid];
                        trace(((((astrIndent + "\t") + subid) + " = ") + subvalue));
                    };
                };
            };
        }

        public static function AddReverseFunctions():*
        {
            MovieClip.prototype.PlayReverseCallback = function (_arg_1:Event):*
            {
                if (_arg_1.currentTarget.currentFrame > 1)
                {
                    _arg_1.currentTarget.gotoAndStop((_arg_1.currentTarget.currentFrame - 1));
                }
                else
                {
                    _arg_1.currentTarget.removeEventListener(Event.ENTER_FRAME, _arg_1.currentTarget.PlayReverseCallback);
                };
            };
            MovieClip.prototype.PlayReverse = function ():*
            {
                if (this.currentFrame > 1)
                {
                    this.gotoAndStop((this.currentFrame - 1));
                    this.addEventListener(Event.ENTER_FRAME, this.PlayReverseCallback);
                }
                else
                {
                    this.gotoAndStop(1);
                };
            };
            MovieClip.prototype.PlayForward = function (_arg_1:String):*
            {
                delete this.onEnterFrame;
                this.gotoAndPlay(_arg_1);
            };
            MovieClip.prototype.PlayForward = function (_arg_1:Number):*
            {
                delete this.onEnterFrame;
                this.gotoAndPlay(_arg_1);
            };
        }

        public static function PlayMenuSound(_arg_1:String):*
        {
            BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND, {
                "soundID":_arg_1,
                "soundFormID":0
            }));
        }

        public static function PlayMenuSoundWithFormID(_arg_1:uint):*
        {
            BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND, {
                "soundID":"",
                "soundFormID":_arg_1
            }));
        }

        public static function ShowHUDMessage(_arg_1:String):*
        {
            BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.SHOW_HUD_MESSAGE, {"text":_arg_1}));
        }

        public static function updateConditionMeter(_arg_1:MovieClip, _arg_2:Number, _arg_3:Number, _arg_4:Number):void
        {
            var _local_5:MovieClip;
            if (_arg_3 > 0)
            {
                _arg_1.visible = true;
                _local_5 = _arg_1.MeterClip_mc;
                _arg_1.gotoAndStop(GlobalFunc.Lerp(_arg_1.totalFrames, 1, 0, DURABILITY_MAX, _arg_4, true));
                if (_arg_2 > 0)
                {
                    _local_5.gotoAndStop(GlobalFunc.Lerp(_local_5.totalFrames, 2, 0, (_arg_3 * 2), _arg_2, true));
                }
                else
                {
                    _local_5.gotoAndStop(1);
                };
            }
            else
            {
                _arg_1.visible = false;
            };
        }

        public static function updateVoiceIndicator(_arg_1:MovieClip, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean=true, _arg_6:Boolean=false):void
        {
            if (!_arg_2)
            {
                _arg_1.gotoAndStop("muted");
            }
            else
            {
                if (!_arg_4)
                {
                    _arg_1.gotoAndStop("hasMicSpeakingChannel");
                }
                else
                {
                    if (_arg_3)
                    {
                        _arg_1.gotoAndStop("hasMicSpeaking");
                    }
                    else
                    {
                        _arg_1.gotoAndStop("hasMic");
                    };
                };
            };
            if (_arg_1.Icon_mc)
            {
                if (_arg_6)
                {
                    _arg_1.Icon_mc.gotoAndStop("enemy");
                }
                else
                {
                    if (_arg_5)
                    {
                        _arg_1.Icon_mc.gotoAndStop("ally");
                    }
                    else
                    {
                        _arg_1.Icon_mc.gotoAndStop("neutral");
                    };
                };
            };
        }

        public static function quickMultiLineShrinkToFit(_arg_1:TextField, _arg_2:Number=0, _arg_3:Number=0):void
        {
            var _local_4:TextFormat = _arg_1.getTextFormat();
            if (_arg_2 == 0)
            {
                _arg_2 = (_local_4.size as Number);
            };
            _local_4.size = _arg_2;
            _local_4.leading = _arg_3;
            _arg_1.setTextFormat(_local_4);
            var _local_5:Boolean;
            if (getTextfieldSize(_arg_1) > _arg_1.height)
            {
                _local_4.size = TEXT_SIZE_VERYSMALL;
                _local_4.leading = TEXT_LEADING_MIN;
                _arg_1.setTextFormat(_local_4);
                _local_5 = true;
            };
            if (((_local_5) && (getTextfieldSize(_arg_1) > _arg_1.height)))
            {
                _local_4.size = TEXT_SIZE_MIN;
                _local_4.leading = TEXT_LEADING_MIN;
                _arg_1.setTextFormat(_local_4);
            };
        }

        public static function shrinkMultiLineTextToFit(_arg_1:TextField, _arg_2:Number=0):void
        {
            var _local_3:TextFormat = _arg_1.getTextFormat();
            if (_arg_2 == 0)
            {
                _arg_2 = (_local_3.size as Number);
            };
            var _local_4:Number = _arg_2;
            _local_3.size = _local_4;
            _arg_1.setTextFormat(_local_3);
            while (((getTextfieldSize(_arg_1) > _arg_1.height) && (_local_4 > TEXT_SIZE_MIN)))
            {
                _local_4--;
                _local_3.size = _local_4;
                _arg_1.setTextFormat(_local_3);
            };
        }

        public static function getTextfieldSize(_arg_1:TextField, _arg_2:Boolean=true):*
        {
            var _local_3:Number;
            var _local_4:uint;
            if (_arg_1.multiline)
            {
                _local_3 = 0;
                _local_4 = 0;
                while (_local_4 < _arg_1.numLines)
                {
                    _local_3 = (_local_3 + ((_arg_2) ? _arg_1.getLineMetrics(_local_4).height : _arg_1.getLineMetrics(_local_4).width));
                    _local_4++;
                };
                return (_local_3);
            };
            return ((_arg_2) ? _arg_1.textHeight : _arg_1.textWidth);
        }

        public static function getDisplayObjectSize(_arg_1:DisplayObject, _arg_2:Boolean=false):*
        {
            if ((_arg_1 is BSScrollingList))
            {
                return ((_arg_1 as BSScrollingList).shownItemsHeight);
            };
            if ((_arg_1 is BCGridList))
            {
                return ((_arg_1 as BCGridList).displayHeight);
            };
            if ((_arg_1 is MovieClip))
            {
                if (((!(_arg_1["Sizer_mc"] == undefined)) && (!(_arg_1["Sizer_mc"] == null))))
                {
                    return ((_arg_2) ? _arg_1["Sizer_mc"].height : _arg_1["Sizer_mc"].width);
                };
                if (_arg_1["textField"] != null)
                {
                    return (getTextfieldSize(_arg_1["textField"], _arg_2));
                };
                if (_arg_1["displayHeight"] != null)
                {
                    return (_arg_1["displayHeight"]);
                };
                return ((_arg_2) ? _arg_1.height : _arg_1.width);
            };
            if ((_arg_1 is TextField))
            {
                return (getTextfieldSize((_arg_1 as TextField), _arg_2));
            };
            throw (new Error("GlobalFunc.getDisplayObjectSize: unsupported object type"));
        }

        public static function arrangeItems(_arg_1:Array, _arg_2:Boolean, _arg_3:uint=0, _arg_4:Number=0, _arg_5:Boolean=false, _arg_6:Number=0):Number
        {
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:uint;
            var _local_12:Object;
            var _local_13:Array;
            var _local_14:uint;
            var _local_7:uint = _arg_1.length;
            var _local_8:Number = 0;
            if (_local_7 > 0)
            {
                _local_9 = 0;
                _local_10 = ((_arg_5) ? -1 : 1);
                _local_13 = [];
                _local_14 = _arg_1.length;
                _local_11 = 0;
                while (_local_11 < _local_14)
                {
                    if (_local_11 > 0)
                    {
                        _local_8 = (_local_8 + _arg_4);
                    };
                    _local_13[_local_11] = getDisplayObjectSize(_arg_1[_local_11], _arg_2);
                    _local_8 = (_local_8 + _local_13[_local_11]);
                    _local_11++;
                };
                if (_arg_3 == ALIGN_CENTER)
                {
                    _local_9 = (_local_8 * -0.5);
                }
                else
                {
                    if (_arg_3 == ALIGN_RIGHT)
                    {
                        _local_9 = (-(_local_8) - _local_13[0]);
                    };
                };
                if (_arg_5)
                {
                    _arg_1.reverse();
                    _local_13.reverse();
                };
                _local_9 = (_local_9 + _arg_6);
                _local_11 = 0;
                while (_local_11 < _local_14)
                {
                    if (_arg_2)
                    {
                        _arg_1[_local_11].y = _local_9;
                    }
                    else
                    {
                        _arg_1[_local_11].x = _local_9;
                    };
                    _local_9 = (_local_9 + (_local_13[_local_11] + _arg_4));
                    _local_11++;
                };
            };
            return (_local_8);
        }

        public static function StringTrim(_arg_1:String):String
        {
            var _local_5:String;
            var _local_2:Number = 0;
            var _local_3:Number = 0;
            var _local_4:Number = _arg_1.length;
            while (((((_arg_1.charAt(_local_2) == " ") || (_arg_1.charAt(_local_2) == "\n")) || (_arg_1.charAt(_local_2) == "\r")) || (_arg_1.charAt(_local_2) == "\t")))
            {
                _local_2++;
            };
            _local_5 = _arg_1.substring(_local_2);
            _local_3 = (_local_5.length - 1);
            while (((((_local_5.charAt(_local_3) == " ") || (_local_5.charAt(_local_3) == "\n")) || (_local_5.charAt(_local_3) == "\r")) || (_local_5.charAt(_local_3) == "\t")))
            {
                _local_3--;
            };
            _local_5 = _local_5.substring(0, (_local_3 + 1));
            return (_local_5);
        }

        public static function BSASSERT(_arg_1:Boolean, _arg_2:String):void
        {
            var _local_3:String;
            if (!_arg_1)
            {
                _local_3 = new Error().getStackTrace();
                fscommand("BSASSERT", ((_arg_2 + "\nCallstack:\n") + _local_3));
            };
        }

        public static function HasFFEvent(aDataObject:Object, asEventString:String):Boolean
        {
            var obj:Object;
            var result:Boolean;
            try
            {
                if (aDataObject.eventArray.length > 0)
                {
                    for each (obj in aDataObject.eventArray)
                    {
                        if (obj.eventName == asEventString)
                        {
                            result = true;
                            break;
                        };
                    };
                };
            }
            catch(e:Error)
            {
                trace((e.getStackTrace() + " The following Fire Forget Event object could not be parsed:"));
                GlobalFunc.InspectObject(aDataObject, true);
            };
            return (result);
        }

        public static function LocalizeFormattedString(_arg_1:String, ... _args):String
        {
            var _local_3:* = "";
            var _local_4:TextField = new TextField();
            _local_4.text = _arg_1;
            _local_3 = _local_4.text;
            var _local_5:uint;
            while (_local_5 < _args.length)
            {
                _local_4.text = _args[_local_5];
                _local_3 = _local_3.replace((("{" + (_local_5 + 1)) + "}"), _local_4.text);
                _local_5++;
            };
            return (_local_3);
        }

        public static function BuildLegendaryStarsGlyphString(_arg_1:Object):String
        {
            var _local_5:*;
            var _local_6:TextField;
            var _local_2:Boolean;
            var _local_3:Number = 0;
            var _local_4:* = "";
            if (((!(_arg_1 == null)) && (_arg_1.hasOwnProperty("isLegendary"))))
            {
                _local_2 = _arg_1.isLegendary;
                if (((_local_2) && (_arg_1.hasOwnProperty("numLegendaryStars"))))
                {
                    _local_3 = _arg_1.numLegendaryStars;
                    _local_5 = 0;
                    while (_local_5 < _local_3)
                    {
                        _local_6 = new TextField();
                        _local_6.text = "$LegendaryModGlyph";
                        _local_4 = (_local_4 + _local_6.text);
                        _local_5++;
                    };
                    _local_4 = (" " + _local_4);
                };
            };
            return (_local_4);
        }

        public static function TrimZeros(_arg_1:String):String
        {
            var _local_3:*;
            var _local_2:* = _arg_1.indexOf(".");
            if (_local_2 > -1)
            {
                _local_3 = (_arg_1.length - 1);
                while (_local_3 > _local_2)
                {
                    if (_arg_1.charAt(_local_3) != "0") break;
                    _local_3--;
                };
                _arg_1 = ((_local_3 == _local_2) ? _arg_1.substring(0, _local_2) : _arg_1.substring(0, (_local_3 + 1)));
            };
            return (_arg_1);
        }
		
    }
}//package Shared

