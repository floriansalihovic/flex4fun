package de.flashforum.ffk11.model
{
    import flash.events.Event;
    import flash.events.EventDispatcher;

    public class ExampleDTO extends EventDispatcher implements IExample
    {

        private var _name:String;

        public function get name():String
        {
            return _name;
        }

        [Bindable("nameChanged")]
        public function set name(value:String):void
        {
            if (_name == value)
            {
                return;
            }

            _name = value;
            dispatchEvent(new Event("nameChanged"));
        }

        public function ExampleDTO()
        {
        }
    }
}