package {

import com.tuarua.FreSwift;
import com.tuarua.TaskbarProgressANE;

import flash.desktop.NativeApplication;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.text.TextField;
import flash.utils.Timer;

public class Main extends Sprite {
    private var freSwiftANE:FreSwift = new FreSwift();
    private var hasActivated:Boolean;
    private var ane:TaskbarProgressANE;
    private var textField:TextField = new TextField();
    public function Main() {

        NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExiting);
        addChild(textField);

        this.addEventListener(Event.ACTIVATE, onActivated);
    }


    private function onActivated(event:Event):void {
        if (!hasActivated) {
            ane = new TaskbarProgressANE();
            ane.init(TaskbarProgressANE.STYLE_NORMAL);

            var timer:Timer = new Timer(50);
            timer.addEventListener(TimerEvent.TIMER, onTimer);
            timer.start();
        }
        hasActivated = true;
    }

    private function onTimer(event:TimerEvent):void {
        var timer:Timer = event.target as Timer;
        if (timer.currentCount > 55) {
            timer.reset();
            timer.stop();
            ane.setStyle(TaskbarProgressANE.STYLE_PAUSED);
            return;
        }

        ane.setProgress(timer.currentCount / 100);
        textField.text = timer.currentCount + "%";

    }

    private function onExiting(event:Event):void {
        ane.dispose();
        freSwiftANE.dispose();
    }
}
}
