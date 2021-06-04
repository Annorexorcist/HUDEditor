// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.SecureTradeShared

package Shared.AS3
{
    import flash.display.MovieClip;

    public class SecureTradeShared 
    {

        public static const MODE_CONTAINER:uint = 0;
        public static const MODE_PLAYERVENDING:uint = 1;
        public static const MODE_NPCVENDING:uint = 2;
        public static const MODE_VENDING_MACHINE:int = 3;
        public static const MODE_DISPLAY_CASE:int = 4;
        public static const MODE_CAMP_DISPENSER:int = 5;
        public static const MODE_FERMENTER:int = 6;
        public static const MODE_REFRIGERATOR:int = 7;
        public static const MODE_ALLY:int = 8;
        public static const MODE_INVALID:uint = uint.MAX_VALUE;//0xFFFFFFFF
        public static const SUB_MODE_STANDARD:uint = 0;
        public static const SUB_MODE_LEGENDARY_VENDOR:uint = 1;
        public static const SUB_MODE_LEGENDARY_VENDING_MACHINE:uint = 2;
        public static const SUB_MODE_POSSUM_VENDING_MACHINE:uint = 3;
        public static const SUB_MODE_TADPOLE_VENDING_MACHINE:uint = 4;
        public static const SUB_MODE_DISPENSER_AID_ONLY:uint = 5;
        public static const SUB_MODE_DISPENSER_AMMO_ONLY:uint = 6;
        public static const SUB_MODE_DISPENSER_JUNK_ONLY:uint = 7;
        public static const SUB_MODE_ARMOR_RACK:uint = 8;
        public static const SUB_MODE_ALLY:uint = 11;
        public static const CURRENCY_CAPS:uint = 0;
        public static const CURRENCY_LEGENDARY_TOKENS:uint = 1;
        public static const CURRENCY_POSSUM_BADGES:uint = 2;
        public static const CURRENCY_TADPOLE_BADGES:uint = 3;
        public static const CURRENCY_GOLD_BULLION:uint = 4;
        public static const CURRENCY_PERK_COINS:uint = 5;
        public static const CURRENCY_INVALID:uint = uint.MAX_VALUE;//0xFFFFFFFF
        public static const MACHINE_TYPE_INVALID:* = 0;
        public static const MACHINE_TYPE_VENDING:* = 1;
        public static const MACHINE_TYPE_DISPLAY:* = 2;
        public static const MACHINE_TYPE_DISPENSER:* = 3;
        public static const MACHINE_TYPE_FERMENTER:* = 4;
        public static const MACHINE_TYPE_REFRIGERATOR:* = 5;
        public static const MACHINE_TYPE_ALLY:* = 6;


        public static function IsCampVendingMenuType(_arg_1:uint):Boolean
        {
            return ((((((_arg_1 == SecureTradeShared.MODE_VENDING_MACHINE) || (_arg_1 == SecureTradeShared.MODE_DISPLAY_CASE)) || (_arg_1 == SecureTradeShared.MODE_ALLY)) || (_arg_1 == SecureTradeShared.MODE_CAMP_DISPENSER)) || (_arg_1 == SecureTradeShared.MODE_FERMENTER)) || (_arg_1 == SecureTradeShared.MODE_REFRIGERATOR));
        }

        public static function DoesMachineTypeMatchMode(_arg_1:uint, _arg_2:uint):Boolean
        {
            return ((_arg_1 == MACHINE_TYPE_VENDING) ? (_arg_2 == MODE_VENDING_MACHINE) : ((_arg_1 == MACHINE_TYPE_DISPLAY) ? (_arg_2 == MODE_DISPLAY_CASE) : ((_arg_1 == MACHINE_TYPE_DISPENSER) ? (_arg_2 == MODE_CAMP_DISPENSER) : ((_arg_1 == MACHINE_TYPE_FERMENTER) ? (_arg_2 == MODE_FERMENTER) : ((_arg_1 == MACHINE_TYPE_REFRIGERATOR) ? (_arg_2 == MODE_REFRIGERATOR) : ((_arg_1 == MACHINE_TYPE_ALLY) ? (_arg_2 == MODE_ALLY) : false))))));
        }

        public static function setCurrencyIcon(_arg_1:SWFLoaderClip, _arg_2:uint, _arg_3:Boolean=false):MovieClip
        {
            var _local_4:String;
            switch (_arg_2)
            {
                case CURRENCY_CAPS:
                    if (_arg_3)
                    {
                        _local_4 = "IconCu_CapsHUD";
                    }
                    else
                    {
                        _local_4 = "IconCu_Caps";
                    };
                    break;
                case CURRENCY_LEGENDARY_TOKENS:
                    if (_arg_3)
                    {
                        _local_4 = "IconCu_LegendaryTokenHUD";
                    }
                    else
                    {
                        _local_4 = "IconCu_LegendaryToken";
                    };
                    break;
                case CURRENCY_POSSUM_BADGES:
                    _local_4 = "IconCu_Possum";
                    break;
                case CURRENCY_TADPOLE_BADGES:
                    _local_4 = "IconCu_Tadpole";
                    break;
                case CURRENCY_GOLD_BULLION:
                    if (_arg_3)
                    {
                        _local_4 = "IconCu_GBHUD";
                    }
                    else
                    {
                        _local_4 = "IconCu_GB";
                    };
                    break;
                case CURRENCY_PERK_COINS:
                    if (_arg_3)
                    {
                        _local_4 = "IconCu_LGNPerkCoinHUD";
                    }
                    else
                    {
                        _local_4 = "IconCu_LGNPerkCoin";
                    };
                    break;
            };
            return (_arg_1.setContainerIconClip(_local_4));
        }


    }
}//package Shared.AS3

