package de.flashforum.ffk11.model
{

    public interface IExample
    {

        function get name():String;

        [Bindable("nameChanged")]
        function set name(value:String):void;
    }
}
