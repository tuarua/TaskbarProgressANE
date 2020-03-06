package {

import com.tuarua.FreSharp;
import com.tuarua.FreSwift;
import com.tuarua.TaskbarProgress;

import flash.desktop.NativeApplication;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.text.AntiAliasType;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Timer;

public class Main extends Sprite {
    public static const FONT:Font = new FiraSansSemiBold();
    private var freSharpANE:FreSharp = new FreSharp(); // must create before all others
    private var freSwiftANE:FreSwift = new FreSwift(); // must create before all others
    private var hasActivated:Boolean;
    private var statusLabel:TextField = new TextField();

    public function Main() {
        super();
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        var tf:TextFormat = new TextFormat(Main.FONT.fontName, 13, 0x222222);
        tf.align = "center";

        statusLabel.defaultTextFormat = tf;
        statusLabel.width = stage.stageWidth;
        statusLabel.y = 75;
        statusLabel.wordWrap = statusLabel.multiline = false;
        statusLabel.selectable = false;
        statusLabel.embedFonts = true;
        statusLabel.antiAliasType = AntiAliasType.ADVANCED;
        statusLabel.sharpness = -100;
        addChild(statusLabel);

        NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExiting);
        this.addEventListener(Event.ACTIVATE, onActivated);
    }


    private function onActivated(event:Event):void {
        if (hasActivated) return;
        TaskbarProgress.init(TaskbarProgress.STYLE_NORMAL);

        var timer:Timer = new Timer(50);
        timer.addEventListener(TimerEvent.TIMER, onTimer);
        timer.start();
        hasActivated = true;
    }

    private function onTimer(event:TimerEvent):void {
        var timer:Timer = event.target as Timer;
        if (timer.currentCount > 55) {
            timer.reset();
            timer.stop();
            TaskbarProgress.style = TaskbarProgress.STYLE_PAUSED;
            return;
        }

        TaskbarProgress.progress = timer.currentCount / 100;
        statusLabel.text = timer.currentCount + "%";

    }

    private function onExiting(event:Event):void {
        TaskbarProgress.dispose();
        FreSwift.dispose();
        FreSharp.dispose();
    }
}
}
