/**
 * Created by Local Eoin Landy on 28/05/2017.
 */
package com.tuarua {
import com.tuarua.fre.ANEContext;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.StatusEvent;
import flash.external.ExtensionContext;

public class TaskbarProgressANE extends EventDispatcher {
    private static const name:String = "TaskbarProgressANE";
    public static const STYLE_NOPROGRESS:int = 0;
    public static const STYLE_INDETERMINATE:int = 0x1;
    public static const STYLE_NORMAL:int = 0x2;
    public static const STYLE_ERROR:int = 0x4;
    public static const STYLE_PAUSED:int = 0x8;

    public function TaskbarProgressANE() {
        initiate();
    }

    private function initiate():void {
        trace("[" + name + "] Initalizing ANE...");
        try {
            ANEContext.ctx = ExtensionContext.createExtensionContext("com.tuarua." + name, null);
            ANEContext.ctx.addEventListener(StatusEvent.STATUS, gotEvent);
        } catch (e:Error) {
            trace("[" + name + "] ANE Not loaded properly.  Future calls will fail.");
        }
    }

    private function gotEvent(event:StatusEvent):void {
        switch (event.level) {
            case "TRACE":
                trace(event.code);
                break;
        }
    }

    public function init(style:int = STYLE_NORMAL):void {
        ANEContext.ctx.call("init", style);
    }

    public function setStyle(value:int):void {
        ANEContext.ctx.call("setStyle", value);
    }

    public function setProgress(value:Number):void {
        ANEContext.ctx.call("setProgress", Math.round(value * 100));
    }

    public function dispose():void {
        if (!ANEContext.ctx) {
            trace("[" + name + "] Error. ANE Already in a disposed or failed state...");
            return;
        }
        trace("[" + name + "] Unloading ANE...");
        ANEContext.ctx.dispose();
        ANEContext.ctx = null;
    }
}
}
