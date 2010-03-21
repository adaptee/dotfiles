QTerm.loadScript("utils.js");

var SendDelay = SendDelay ? SendDelay : new Object;
SendDelay.stringQueue = new Array;

SendDelay.t = new QTimer;

SendDelay.q = new QEventLoop;

SendDelay.text = "";
SendDelay.times = 0;
SendDelay.delay = 0;

SendDelay.send = function(text, times, delay)
{
    SendDelay.text = text;
    SendDelay.times = times;
    SendDelay.delay = delay;
    for (var i = 0; i < times; i++) {
        this.addSendString(text);
    }
    this.t.start(delay);
    this.t.timeout.connect(this,this.sendOneChar);
    QTerm.eventFinished.connect(this,this.q.quit);
    this.q.exec();
    QTerm.showMessage("QTerm","Send String Finished");
    this.t.timeout.disconnect(this,this.sendOneChar);
    QTerm.eventFinished.disconnect(this,this.q.quit);
}

SendDelay.addSendString = function(str)
{
    this.stringQueue[this.stringQueue.length] = str;
}

SendDelay.sendOneChar = function()
{
    var text = this.stringQueue.shift();
    QTerm.sendParsedString(text);
    if (this.stringQueue.length == 0) {
        this.t.stop();
        QTerm.eventFinished();
        return;
    }
}

QTerm.SendDelay = SendDelay;

QTerm.onSendDelay = function()
{
    var UIloader = new QUiLoader(this);
    var uifile = new QFile(QTerm.findFile("ui/senddelay.ui"));
    uifile.open(QIODevice.ReadOnly);
    var dialog = UIloader.load(uifile, this);
    uifile.close();

    dialog.stringLineEdit.text = QTerm.SendDelay.text;
    dialog.repeatingSpinBox.value = QTerm.SendDelay.times;
    dialog.delaySpinBox.value = QTerm.SendDelay.delay/1000;

    if ( dialog.exec() == 0 )
        return;

    var text = dialog.stringLineEdit.text;
    var times = dialog.repeatingSpinBox.value;
    var delay = dialog.delaySpinBox.value*1000;

    if (text.length != 0 && times != 0) {
        QTerm.osdMessage("send \""+text+"\" "+times+" times with "+delay+" ms delay", QTerm.OSDType.Info, 2000);
        QTerm.SendDelay.send(text,times,delay);
    }
}

if (QTerm.addPopupMenu( "sendDelay", "Send String With Delay..." ) ) {
        QTerm.sendDelay.triggered.connect(QTerm.onSendDelay);
}


