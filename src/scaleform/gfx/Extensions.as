// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//scaleform.gfx.Extensions

package scaleform.gfx
{
    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    import flash.text.TextField;

    public final class Extensions 
    {

        public static const EDGEAA_INHERIT:uint = 0;
        public static const EDGEAA_ON:uint = 1;
        public static const EDGEAA_OFF:uint = 2;
        public static const EDGEAA_DISABLE:uint = 3;
        public static var isGFxPlayer:Boolean = false;
        public static var CLIK_addedToStageCallback:Function;
        public static var gfxProcessSound:Function;


        public static function set enabled(_arg_1:Boolean):void
        {
        }

        public static function get enabled():Boolean
        {
            return (false);
        }

        public static function set noInvisibleAdvance(_arg_1:Boolean):void
        {
        }

        public static function get noInvisibleAdvance():Boolean
        {
            return (false);
        }

        public static function getTopMostEntity(_arg_1:Number, _arg_2:Number, _arg_3:Boolean=true):DisplayObject
        {
            return (null);
        }

        public static function getMouseTopMostEntity(_arg_1:Boolean=true, _arg_2:uint=0):DisplayObject
        {
            return (null);
        }

        public static function setMouseCursorType(_arg_1:String, _arg_2:uint=0):void
        {
        }

        public static function getMouseCursorType(_arg_1:uint=0):String
        {
            return ("");
        }

        public static function get numControllers():uint
        {
            return (1);
        }

        public static function get visibleRect():Rectangle
        {
            return (new Rectangle(0, 0, 0, 0));
        }

        public static function getEdgeAAMode(_arg_1:DisplayObject):uint
        {
            return (EDGEAA_INHERIT);
        }

        public static function setEdgeAAMode(_arg_1:DisplayObject, _arg_2:uint):void
        {
        }

        public static function setIMEEnabled(_arg_1:TextField, _arg_2:Boolean):void
        {
        }

        public static function get isScaleform():Boolean
        {
            return (false);
        }


    }
}//package scaleform.gfx

