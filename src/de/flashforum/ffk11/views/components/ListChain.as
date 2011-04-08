package de.flashforum.ffk11.views.components
{
    import mx.collections.IList;
    import mx.events.FlexEvent;

    import spark.components.HGroup;
    import spark.components.List;
    import spark.events.IndexChangeEvent;

    public class ListChain extends HGroup
    {

        private var _dataProvider:IList;

        private var _dataProviderChanged:Boolean;

        public function get dataProvider():IList
        {
            return _dataProvider;
        }

        public function set dataProvider(value:IList):void
        {
            if (_dataProvider == value)
            {
                return;
            }
            _dataProvider = value;
            _dataProviderChanged = true;
            invalidateProperties();
        }

        private var _firstList:List;

        private var _lists:Vector.<List>;

        public function ListChain()
        {
            addEventListener(FlexEvent.PREINITIALIZE, preinitialize);
        }

        private function preinitialize(event:FlexEvent):void
        {
            _lists = new Vector.<List>();
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if(_dataProviderChanged)
            {
                _dataProviderChanged = false;
                _firstList.dataProvider = _dataProvider;
            }
        }


        override protected function createChildren():void
        {
            super.createChildren();

            if(!_firstList)
            {
                _firstList = new List();
                _firstList.addEventListener(IndexChangeEvent.CHANGE, firstList_changeHandler);
                _firstList.addEventListener(IndexChangeEvent.CHANGING, firstList_changingHandler);
                _lists[0] = List(addElement(_firstList));
            }
        }

        private function firstList_changeHandler(event:IndexChangeEvent):void
        {
            trace("firstList_changeHandler");
        }

        private function firstList_changingHandler(event:IndexChangeEvent):void
        {
            trace("firstList_changingHandler");
        }
    }
}
