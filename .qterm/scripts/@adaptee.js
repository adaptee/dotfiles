QTerm.loadScript("smth.js");

articleListKeyEvent = function ( key, modifiers, text)
{
        // goto first post
        if ( text ==  'g')
        {
            QTerm.sendParsedString('1') ;
            QTerm.sendParsedString('^M') ;
            QTerm.accepted = true;
        }
        // goto last post
        else if ( text ==  'G')
        {
            QTerm.sendParsedString('$') ;
            QTerm.accepted = true;
        }
        // forward one page
        else if ( text ==  'J')
        {
            QTerm.sendParsedString('N') ;
            QTerm.accepted = true;
        }
        // backward one page
        else if ( text ==  'K')
        {
            QTerm.sendParsedString('P') ;
            QTerm.accepted = true;
        }
        else
        {
            QTerm.accepted = false;
        }
}

postTempFile = '/tmp/qterm-post.txt' ;

editPostInGvim = function ()
{
        var output = new QFile(postTempFile);
        if(output.open(QIODevice.WriteOnly))
        {
            // truncate it in a ugly way
            output.resize(0);

            var writer = new QTextStream(output);

            var rows = QTerm.rows();
            var blankLinePattern = /^\s+$/ ;

            // the last line is irrevalant
            for (var i = 0; i < rows - 1 ; i++)
            {
                var line = QTerm.getLine(i);
                var text = line.getText();
                //var text = line.getAttrText();

                // make blank line really blank
                if ( text.match(blankLinePattern) )
                    text = "";

                writer.writeString( text + '\n' );
            }
            writer.flush();
        }
        output.close()

        process = new QProcess();
        // '-f' is very important!
        // otherwise QProcess would think gvim has already finished when it not
        process.start('/usr/bin/gvim',
                      [ '-f', postTempFile, '-c', 'normal gg0i'],
                      QIODevice.ReadWrite);
        //process.start('kate', ['/tmp/qterm-article.txt'], QIODevice.ReadWrite);
        var flag = process.waitForFinished(-1);
        //QtCore.connect( process, finished(), Qterm, gvimreplay() );

        var input = new QFile(postTempFile);
        if(input.open(QIODevice.ReadOnly))
        {
            var reader = new QTextStream(input);

            var quotePattern =  /^【 在 / ;

                while(!reader.atEnd())
                {
                    var line = reader.readLine();

                    // quotation should be discarded
                    if( line.match(quotePattern) )
                        break;

                    QTerm.sendString(line);
                    QTerm.sendString('\n');
                }
        }
        input.close()
}


sleep = function (delay)
{
    var dieTime = QTime.currentTime().addMSecs(delay);
    while( QTime.currentTime() < dieTime )
        ;
}

articleKeyEvent = function(key, modifiers, text)
{
    if ( text ==  'V')
    {
        QTerm.sendString('r\n');

        // FIXME: how to ask qterm to refresh its display?
        sleep(2000);

        editPostInGvim() ;

        QTerm.accepted = true;
    }
    else
    {
        QTerm.accepted = false;
    }
}

unknownKeyEvent = function(key, modifiers, text)
{

    if ( text ==  'V')
    {
        editPostInGvim() ;
        QTerm.accepted = true;
    }
    else
    {
        QTerm.accepted = false;
    }
}


QTerm.onKeyPressEvent = function(key, modifiers, text)
{
    //var msg = "The pateState is: " + QTerm.pageState
    //QTerm.osdMessage(msg, 1, 1000);

    // only apply in article list mode
    if (QTerm.pageState == QTerm.SMTH.List )
    {
        articleListKeyEvent(key, modifiers, text)

    }
    else if (QTerm.pageState == QTerm.SMTH.Unknown )
    {
        unknownKeyEvent(key, modifiers, text)
    }
    else if (QTerm.pageState == QTerm.SMTH.Article )
    {
        articleKeyEvent(key, modifiers, text)
    }
    else
    {
        QTerm.accepted = false;
    }

}

QTerm.onNewData = function()
{
    QTerm.accepted = false;
    QTerm.scriptEvent("QTerm: new data");

    // block ID of bullshit talks :D
    //QTerm.blockID(/incisive/ig);

    // higglight some keywords with which I'm instrested
    QTerm.highlightKeywords(/qterm|kde|amule|konsole|vim|git|zsh|firefox|vimperator/ig);
    return false;
}
