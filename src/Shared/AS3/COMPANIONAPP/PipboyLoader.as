// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//Shared.AS3.COMPANIONAPP.PipboyLoader

package Shared.AS3.COMPANIONAPP
{
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    import flash.external.ExternalInterface;

    public class PipboyLoader extends Loader 
    {

        private var _request:URLRequest;
        private var _context:LoaderContext;


        override public function load(_arg_1:URLRequest, _arg_2:LoaderContext=null):void
        {
            if (CompanionAppMode.isOn)
            {
                if (ExternalInterface.available)
                {
                    this._request = _arg_1;
                    this._context = _arg_2;
                    ExternalInterface.call.apply(null, ["GetAssetPath", _arg_1.url, this]);
                }
                else
                {
                    trace("PipboyLoader::load -- ExternalInterface is not available!");
                };
            }
            else
            {
                super.load(_arg_1, _arg_2);
            };
        }

        public function OnGetAssetPathResult(_arg_1:String):void
        {
            this._request.url = _arg_1;
            super.load(this._request, this._context);
            this._request = null;
            this._context = null;
        }


    }
}//package Shared.AS3.COMPANIONAPP

