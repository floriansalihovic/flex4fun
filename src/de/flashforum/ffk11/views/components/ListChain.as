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

            if (_dataProviderChanged)
            {
                _dataProviderChanged = false;
                _firstList.dataProvider = _dataProvider;
            }
        }


        override protected function createChildren():void
        {
            super.createChildren();

            if (!_firstList)
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
            const ex:IExample = oldList.selectedItem as IExample;

            if (!ex)
            {
                return;
            }

            const nextList:List = getNextListAndClear(oldList);

            nextList.dataProvider = ex.children;
            addElement(nextList);

            _lists.addItem(nextList);
        }

        private function getNextList(list:List):List
        {
            if (!list || isLastList(list))
            {
                return newList();
            }

            return getListAfter(list);
        }

        private function getListAfter(list:List):List
        {
            if (!list)
            {
                return newList();
            }

            return List(_lists.getItemAt(_lists.getItemIndex(list + 1)));
        }

        private function isFirstList(list:List):Boolean
        {
            return list == _firstList;
        }

        private function isLastList(list:List):Boolean
        {
            if (!list)
            {
                return false;
            }

            return list == _lists.getItemAt(_lists.length - 1);
        }

        private function hasMoreLists(list:List):Boolean
        {
            return !isLastList(list);
        }


        private function getNextListAndClear(list:List):List
        {
            // the list passed is the last list
            if (!hasMoreLists(list))
            {
                return newList();
            }

            var nextList:List = getNextList(list);

            if (hasMoreLists(nextList))
            {
                hideListsAfter(nextList);
            }

            return nextList;
        }

        private function hideListsAfter(list:List):void
        {
            if (!list)
            {
                return
            }

            const length:uint = _lists.length;
            var i:int = _lists.getItemIndex(list);

            for (; i < length; i++)
            {
                var list:List = List(_lists.getItemAt(i));
                list.visible = list.includeInLayout = false;
            }
        }

        private function firstList_changingHandler(event:IndexChangeEvent):void
        {
            trace("firstList_changingHandler");
        }
    }
}
