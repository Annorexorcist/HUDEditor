// Decompiled by AS3 Sorcerer 4.98
// www.as3sorcerer.com

//com.adobe.serialization.json.JSONDecoder

package com.adobe.serialization.json
{
    public class JSONDecoder 
    {

        private var strict:Boolean;
        private var value:*;
        private var tokenizer:JSONTokenizer;
        private var token:JSONToken;

        public function JSONDecoder(_arg_1:String, _arg_2:Boolean)
        {
            this.strict = _arg_2;
            this.tokenizer = new JSONTokenizer(_arg_1, _arg_2);
            this.nextToken();
            this.value = this.parseValue();
            if (((_arg_2) && (!(this.nextToken() == null))))
            {
                this.tokenizer.parseError("Unexpected characters left in input stream");
            };
        }

        public function getValue():*
        {
            return (this.value);
        }

        final private function nextToken():JSONToken
        {
            return (this.token = this.tokenizer.getNextToken());
        }

        final private function nextValidToken():JSONToken
        {
            this.token = this.tokenizer.getNextToken();
            this.checkValidToken();
            return (this.token);
        }

        final private function checkValidToken():void
        {
            if (this.token == null)
            {
                this.tokenizer.parseError("Unexpected end of input");
            };
        }

        final private function parseArray():Array
        {
            var _local_1:Array = new Array();
            this.nextValidToken();
            if (this.token.type == JSONTokenType.RIGHT_BRACKET)
            {
                return (_local_1);
            };
            if (((!(this.strict)) && (this.token.type == JSONTokenType.COMMA)))
            {
                this.nextValidToken();
                if (this.token.type == JSONTokenType.RIGHT_BRACKET)
                {
                    return (_local_1);
                };
                this.tokenizer.parseError(("Leading commas are not supported.  Expecting ']' but found " + this.token.value));
            };
            while (true)
            {
                _local_1.push(this.parseValue());
                this.nextValidToken();
                if (this.token.type == JSONTokenType.RIGHT_BRACKET)
                {
                    return (_local_1);
                };
                if (this.token.type == JSONTokenType.COMMA)
                {
                    this.nextToken();
                    if (!this.strict)
                    {
                        this.checkValidToken();
                        if (this.token.type == JSONTokenType.RIGHT_BRACKET)
                        {
                            return (_local_1);
                        };
                    };
                }
                else
                {
                    this.tokenizer.parseError(("Expecting ] or , but found " + this.token.value));
                };
            };
            return (null); //dead code
        }

        final private function parseObject():Object
        {
            var _local_2:String;
            var _local_1:Object = new Object();
            this.nextValidToken();
            if (this.token.type == JSONTokenType.RIGHT_BRACE)
            {
                return (_local_1);
            };
            if (((!(this.strict)) && (this.token.type == JSONTokenType.COMMA)))
            {
                this.nextValidToken();
                if (this.token.type == JSONTokenType.RIGHT_BRACE)
                {
                    return (_local_1);
                };
                this.tokenizer.parseError(("Leading commas are not supported.  Expecting '}' but found " + this.token.value));
            };
            while (true)
            {
                if (this.token.type == JSONTokenType.STRING)
                {
                    _local_2 = String(this.token.value);
                    this.nextValidToken();
                    if (this.token.type == JSONTokenType.COLON)
                    {
                        this.nextToken();
                        _local_1[_local_2] = this.parseValue();
                        this.nextValidToken();
                        if (this.token.type == JSONTokenType.RIGHT_BRACE)
                        {
                            return (_local_1);
                        };
                        if (this.token.type == JSONTokenType.COMMA)
                        {
                            this.nextToken();
                            if (!this.strict)
                            {
                                this.checkValidToken();
                                if (this.token.type == JSONTokenType.RIGHT_BRACE)
                                {
                                    return (_local_1);
                                };
                            };
                        }
                        else
                        {
                            this.tokenizer.parseError(("Expecting } or , but found " + this.token.value));
                        };
                    }
                    else
                    {
                        this.tokenizer.parseError(("Expecting : but found " + this.token.value));
                    };
                }
                else
                {
                    this.tokenizer.parseError(("Expecting string but found " + this.token.value));
                };
            };
            return (null); //dead code
        }

        final private function parseValue():Object
        {
            this.checkValidToken();
            switch (this.token.type)
            {
                case JSONTokenType.LEFT_BRACE:
                    return (this.parseObject());
                case JSONTokenType.LEFT_BRACKET:
                    return (this.parseArray());
                case JSONTokenType.STRING:
                case JSONTokenType.NUMBER:
                case JSONTokenType.TRUE:
                case JSONTokenType.FALSE:
                case JSONTokenType.NULL:
                    return (this.token.value);
                case JSONTokenType.NAN:
                    if (!this.strict)
                    {
                        return (this.token.value);
                    };
                    this.tokenizer.parseError(("Unexpected " + this.token.value));
                default:
                    this.tokenizer.parseError(("Unexpected " + this.token.value));
            };
            return (null);
        }


    }
}//package com.adobe.serialization.json

