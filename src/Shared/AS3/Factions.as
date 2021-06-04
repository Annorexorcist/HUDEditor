// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.Factions

package Shared.AS3
{
    import flash.display.MovieClip;
    import Shared.GlobalFunc;

    public class Factions 
    {

        public static const THRESHOLD_TIER_HOSTILE:uint = 0;
        public static const THRESHOLD_TIER_CAUTIOUS:uint = 1;
        public static const THRESHOLD_TIER_NEUTRAL:uint = 2;
        public static const THRESHOLD_TIER_COOPERATIVE:uint = 3;
        public static const THRESHOLD_TIER_FRIENDLY:uint = 4;
        public static const THRESHOLD_TIER_NEIGHBORLY:uint = 5;
        public static const THRESHOLD_TIER_ALLY:uint = 6;


        public static function updateFaceIcon(_arg_1:MovieClip, _arg_2:Object):void
        {
            _arg_1.gotoAndStop(_arg_2.code);
            _arg_1.Face_mc.gotoAndStop(getReputationFaceFromFromTier(_arg_2.tier));
            _arg_1.Backer_mc.gotoAndStop(getReputationBackerFrameFromTier(_arg_2.tier));
        }

        public static function getFactionByID(_arg_1:uint, _arg_2:Array):Object
        {
            var _local_3:uint;
            while (_local_3 < _arg_2.length)
            {
                if (_arg_2[_local_3].factionID == _arg_1)
                {
                    return (_arg_2[_local_3]);
                };
                _local_3++;
            };
            return (null);
        }

        public static function buildFactionInfo(_arg_1:Object):Array
        {
            var _local_4:Object;
            var _local_5:String;
            var _local_6:int;
            var _local_7:uint;
            var _local_2:Array = new Array();
            var _local_3:Array = ["Crater", "Foundation"];
            var _local_8:uint;
            while (_local_8 < _local_3.length)
            {
                _local_5 = _local_3[_local_8];
                _local_4 = _arg_1[("factionData" + _local_5)];
                _local_6 = _arg_1[("playerRep" + _local_5)];
                _local_7 = getReputationTier(_local_6, _local_4.reputationTiers);
                _local_2[_local_8] = {
                    "name":_local_4.szFactionName,
                    "code":_local_3[_local_8].toLowerCase(),
                    "tier":_local_7,
                    "factionID":_local_4.uFactionID,
                    "tierPercent":getNextReputationTierPercent(_local_6, _local_7, _local_4.reputationTiers)
                };
                _local_8++;
            };
            return (_local_2);
        }

        public static function getNextReputationTierPercent(_arg_1:int, _arg_2:uint, _arg_3:Array):Number
        {
            if ((_arg_2 + 1) >= _arg_3.length)
            {
                return (1);
            };
            var _local_4:Object = _arg_3[_arg_2];
            var _local_5:Object = _arg_3[(_arg_2 + 1)];
            var _local_6:Number = ((_arg_1 - _local_4.fValue) / (_local_5.fValue - _local_4.fValue));
            return (GlobalFunc.Clamp(_local_6, 0, 1));
        }

        public static function getReputationTier(_arg_1:int, _arg_2:Array):uint
        {
            var _local_3:uint = (_arg_2.length - 1);
            while (_local_3 > 0)
            {
                if (_arg_1 >= _arg_2[_local_3].fValue) break;
                _local_3--;
            };
            return (_local_3);
        }

        public static function getReputationBackerFrameFromTier(_arg_1:uint):String
        {
            var _local_2:* = "";
            switch (_arg_1)
            {
                case THRESHOLD_TIER_HOSTILE:
                    _local_2 = "hostile";
                    break;
                case THRESHOLD_TIER_ALLY:
                    _local_2 = "ally";
                    break;
                default:
                    _local_2 = "neutral";
            };
            return (_local_2);
        }

        public static function getReputationFaceFromFromTier(_arg_1:uint):String
        {
            var _local_2:* = "";
            switch (_arg_1)
            {
                case THRESHOLD_TIER_HOSTILE:
                    _local_2 = "hostile";
                    break;
                case THRESHOLD_TIER_CAUTIOUS:
                    _local_2 = "cautious";
                    break;
                case THRESHOLD_TIER_NEUTRAL:
                    _local_2 = "neutral";
                    break;
                case THRESHOLD_TIER_COOPERATIVE:
                    _local_2 = "cooperative";
                    break;
                case THRESHOLD_TIER_FRIENDLY:
                    _local_2 = "friendly";
                    break;
                case THRESHOLD_TIER_NEIGHBORLY:
                    _local_2 = "neighborly";
                    break;
                case THRESHOLD_TIER_ALLY:
                    _local_2 = "ally";
                    break;
            };
            return (_local_2);
        }


    }
}//package Shared.AS3

