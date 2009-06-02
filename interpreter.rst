.. _tut-using:

********************************
Benutzung des Pythoninterpreters
********************************

.. _tut-invoking:

Aufrufen des Interpreters
=========================

Der Pythoninterpreter ist auf den Rechnern, auf denen er vorhanden ist,
normalerweise unter :file:`/usr/local/bin/python/python3.1` installiert. Indem
man :file:`/usr/local/bin` in den Suchpfad der Unixshell setzt, ermöglicht man
der Shell den Interpreter durch folgendes Befehl aufzurufeni[#]_::
    
    python3.1

Da die Auswahl des Installationspfades des Interpreters eine Installationsoption
ist, sind auch andere Orte möglich; das ist mit dem örtlichen Python-Guru oder
dem Systemadministrator zu klären. (Zum Beispiel ist :file:`/usr/local/python`
eine populäre Alternative.)

Auf Windows-Rechnern befindet sich die Pythoninstallation meist unter
:file:`C:\\Python31`, auch wenn man das während dem Installationsvorgang ändern
kann. Um dieses Verzeichnis zu deinem Suchpfad hinzuzufügen, kannst du folgendes
Kommando in die DOS-Eingabeaufforderung eingeben::

    set path=%path%;C:\python31

Indem man das End-Of-File Zeichen (EOF; :kbd:`Strg-D` unter Unix, :kbd:`Strg-Z`
unter Windows) in der primären Eingabeaufforderung des Interpreters eingibt,
bringt man den Interpreter dazu sich mit einem Rückgabewert von null zu
beenden. Falls er das nicht tut, kannst du den Interpreter durch Eingabe der
folgenden Befehlen beenden: ``import sys; sys.exit(1)``.

Die Möglichkeiten des Interpreters was das Bearbeiten der Zeile angeht sind
ziemlich beschränkt. Unter Unix könnte derjenige, der den Interpreter
installiert hat, jedoch die Unterstützung für die GNU readline Bibliothek
aktiviert haben, was umfangreichere, interaktive Bearbeitungsmöglichkeiten
hinzufügt. Der vielleicht schnellste Weg zu überprüfen ob die Bearbeitung der
Kommandozeile unterstütz wird ist, :kbd:`Strg-P` in die erste
Eingabeaufforderung zu tippen, die du siehst. Piepst es, ist es unterstützt;
siehe Anhang :ref:`tut-interacting` für eine Einführung zu den Tasten. Falls
nichts zu passieren scheint oder ``^P`` wiedergegeben wird, wird es nicht
unterstützt; du wirst nur die Möglichkeit haben die Rücktaste zu benutzen, um
Zeichen der aktuellen Zeile zu entfernen.

Der Interpreter agiert ähnlich einer Unixshell: Wird er mit der Standardeingabe
verbunden mit einem tty Gerät aufgerufen, liest und führt er interaktiv Befehle
aus. Wird er mit einem Dateinamen als Argument oder mit einer Datei als
Standardeingabe aufgerufen, liest und führt es ein *Skript* von dieser Datei
aus.

Ein zweiter Weg den Pythoninterpreter zu starten ist ``python -c Befehl [arg]
...``, was die Anweisung(en) in diesem *Befehl* ausführt, analog zur
:option:`-c` Option der Shell. Da Pythonanweisungen oft Leerzeichen oder andere
Zeichen die die Shell speziell behandelt enthält, wird es normalerweise
empfohlen den kompletten *Befehl* mit einfachen Anührungszeichen anzugeben. 

Einige Pythonmodule sind auch als Skripte nützlich. Diese können mit ``python -m
Modul [arg] ...`` aufgerufen werden, was den Quelltext von *Modul* ausführt, als
ob du den kompletten Namen auf der Kommandozeile geschrieben hättest.

Bemerke, dass es einen Unterschied zwischen ``python Datei`` und ``python
<Datei`` gibt. Im zweiten Fall werden Eingabeanfragen des Programms, wie
beispielsweise der Aufruf ``sys.stdin.read()``, von *Datei* befriedigt. Da diese
Datei aber schon bis zum Ende vom Parser gelesen wurde, bevor das Programm
beginnt ausgeführt zu werden, wird das Programm sofort auf ein end-of-file
stossen. In ersterem Falle (was normalerweise das ist was man willst), werden sie
durch egal welche Datei oder Gerät befriedigt das dem Pythoninterpreter als
Standardeingabe zur Verfügung steht.

Wenn eine Skriptdatei benutzt wird, is es manchmal nützlich das Skript
auszuführen und danach den interaktiven Modus zu betreten. Bewerkstelligt kann
dies durch das übergeben der Option :option:`-i` vor dem Skript. (Dies
funktioniert, aus dem im vorherigen Absatz genannten Grund, nicht, falls das
Skript von der Standardeingabe gelesen wird.
