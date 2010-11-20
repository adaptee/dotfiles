QTerm.loadScript("smth.js");
QTerm.loadScript("block.js");

QTerm.onKeyPressEvent = function(key, modifiers, text)
{
    var msg = "The key pressed is: " + text + "," + modifiers + "," + key;
    QTerm.osdMessage(msg,1,1000);

    if (QTerm.pageState == QTerm.SMTH.List )
    {
        // goto first post
        if ( text ==  'g')
        {
            QTerm.sendParsedString('1') ;
            QTerm.sendParsedString('^M') ;
            QTerm.accepted = true;
            return
        }

        // goto last post
        if ( text ==  'G')
        {
            QTerm.sendParsedString('$') ;
            QTerm.accepted = true;
            return
        }

        // forward one page
        if ( text ==  'J')
        {
            QTerm.sendParsedString('N') ;
            QTerm.accepted = true;
            return
        }

        // backward one page
        if ( text ==  'K')
        {
            QTerm.sendParsedString('P') ;
            QTerm.accepted = true;
            return
        }
    }

    QTerm.accepted = false;
}


QTerm.onNewData = function()
{
    QTerm.accepted = false;
    QTerm.scriptEvent("QTerm: new data");

    // block bullshit :D
    //QTerm.blockID(/incisive/ig);

    // higglight some keywords with which I'm instrested
    QTerm.highlightKeywords(/qterm|kde|amule|konsole|vim|git|zsh|firefox|vimperator/ig);
    return false;
}
