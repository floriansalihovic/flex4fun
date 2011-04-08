package de.flashforum.ffk11.views.components
{
    import de.flashforum.ffk11.model.IExample;

    import mx.collections.ArrayList;

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

        private var _lists:IList;

        public function ListChain()
        {
            addEventListener(FlexEvent.PREINITIALIZE, preinitialize);
        }

        private function preinitialize(event:FlexEvent):void
        {
            _lists = new ArrayList();
            clipAndEnableScrolling = true;
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
                _firstList = newList();
                _lists.addItem(List(addElement(_firstList)));
            }
        }

        private function newList():List
        {
            const list:List = new List();
            list.addEventListener(IndexChangeEvent.CHANGE, firstList_changeHandler);
            list.addEventListener(IndexChangeEvent.CHANGING, firstList_changingHandler);
            list.percentHeight = 100;

            return list;
        }

        private function firstList_changeHandler(event:IndexChangeEvent):void
        {
            trace("firstList_changeHandler");

            const oldList:List = List(event.target);
            const index:uint = _lists.getItemIndex(oldList);
            const ex:IExample = oldList.selectedItem as IExample;

            if (!ex)
            {
                return;
            }

            var nextList:List;

            if (index == _lists.length - 1)
            {
                nextList = newList();
            }
            else if (index < _lists.length - 2)
            {
                nextList = List(_lists.getItemAt(index + 1));
            }
            else
            {
                nextList = List(_lists.getItemAt(index + 1));
                removeListsAfter(index + 1);
            }

            nextList.dataProvider = ex.children;
            addElement(nextList);

            _lists.addItem(nextList);
        }

        private function removeListsAfter(index:int):void
        {
            const length:int = _lists.length - 1;
            for (var i:uint = length; i > index; i--)
            {
                _lists.removeItemAt(i);
                removeElementAt(i);
            }
        }

        private function firstList_changingHandler(event:IndexChangeEvent):void
        {
            trace("firstList_changingHandler");
        }
    }
}
