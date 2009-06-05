.. _tut-intro:

****************************************
Um dich auf den Geschmack zu bringen
****************************************

Wenn du viel am Computer arbeitest, kommst du irgendwann zu dem Schluss, dass es
eine Aufgabe gibt, die du gern automatisieren würdest. Beispielsweise könntest du
dir ein Suchen-und-Ersetzen für eine Vielahl von Dateien wünschen oder eine
Möglichkeit einen Haufen Fotodateien in einer komplizierten Art und Weise
umzubenennen oder umzuräumen. Vielleicht würdest du auch gerne eine kleine
Datenbank nach Maß, eine spezialisierte GUI-Applikation oder ein einfaches Spiel
schreiben.

Falls du ein professioneller Softwareentwickler bist, musst du vielleicht mit
mehreren C/C++/Java Bibliotheken arbeiten, aber du findest den gewöhnlichen
Schreiben/Kompilieren/Testen/Re-Kompilieren Zyklus zu langsam. Vielleicht
schreibst du auch eine Testsuite für solch eine Bibliothek und hälst den
Testcode zu schreiben für eine ermüdende Aufgabe. Oder vielleicht hast du auch
ein Programm geschrieben, das eine Erweiterungssprache gebrauchen könnte, du
aber nicht eine ganz neue Sprache für dein Programm entwerfen und implementieren
willst.

Python ist genau die richtige Sprache für dich.

Du könntest ein Unix Shellskripte oder Windows Batchdateien für ein paar dieser
Aufgaben schreiben, Shellskripte sind am Besten darin Dateien zu
verschieben und Textdaten zu verändern, passen aber nicht so gut zu
GUI-Applikationen oder Spielen. Du könntest ein C/C++/Java Programm dafür
schreiben, aber es kann viel Entwicklungszeit kosten, um überhaupt einen ersten
Entwurf des Programmes zu bekommen. Python ist einfacher zu nutzen, verfügbar
auf Windows-, Mac OS X- und Unix-Betriebssystemen und wird dir dabei helfen die
Aufgabe schneller zu erledigen.

Python ist einfach zu benutzen, aber eine echte Programmiersprache, die viel
mehr Struktur und Unterstützung für große Programme bietet, als Shellskripte
oder Batchdateien es könnten. Auf der anderen Seite bietet Python auch mehr
Fehlerüberprüfungen als C und, da Python eine stark abstrahierende Hochsprache
ist, hat es abstrakte Datentypen wie flexible Arrays und
Wörterbücher(Dictionaries) eingebaut. Aufgrund seiner allgemeineren Datentypen
ist Python auf eine weit größere Problemdomäne anwendbar als Awk oder sogar
Perl, aber viele Dinge sind in Python mindestens so einfach wie in diesen
Sprachen.

Python erlaubt dir dein Programm in Module aufzuteilen, die in anderen Python
Programmen wiederverwendet werden können. Python kommt mit einer großen Sammlung
von Standardmodulen, die du als Grundlage für deine Programme nutzen kannst -
oder als Beispiele, um in Python Programmieren zu lernen. Manche der Module
stellen Datei-I/O, Systemaufrufe, Sockets und sogar Schnittstellen zu
GUI-Toolkits wie Tk bereit.

Python ist eine interpretierte Sprache, was dir während der Programmentwicklung
erheblich Zeit sparen kann, da Kompilieren und Linken nicht nötig ist. Der
Interpreter kann interaktiv genutzt werden, was es leicht macht mit den
Fähigkeiten der Sprache zu experimentieren, Wegwerf-Code zu schreiben oder
Funktionen während der Bottom-Up Programmentwicklung zu testen. Es ist auch ein
praktischer Tischrechner.

Python ermöglicht es, dass Programme kompakt und lesbar geschrieben werden.
Programme, die in Python geschrieben sind, sind aus mehreren Gründen viel kürzer
als C/C++/Java Äquivalente:
* Die abstrakten Datentypen erlauben dir komplexe Operationen in einer einzigen
Anweisung auszudrücken;
* Anweisungen werden durch Einrückungen und nicht durch öffnende und
schliessende Klammern gruppiert;
* Variablen- oder Argumentdeklarationen sind nicht nötig.

Python ist *erweiterbar*: Wenn du in C programmieren kannst, ist es leicht eine
neue eingebaute Funktion oder Modul zum Interpreter hinzuzufügen. Entweder um
kritische Operationen mit maximaler Geschwindigkeit auszuführen oder um
Pythonprogramme zu Bibliotheken zu linken die nur in binärer Form (wie
beispielsweise Herstellerspezifische Grafikbibliotheken) verfügbar sind. Sobald
du wirklich drin bist, kannst du den Pythoninterpreter zu in C geschriebenen
Applikationen linken und es als eine Erweiterung oder Kommandosprache für diese
Applikation nutzen.

So nebenbei: Die Sprache ist nach der BBC-Sendung "Monty Python's Flying Circus"
benannt und hat nichts mit Reptilien zu tun. Referenzen auf Monty
Python-Sketche in Dokumentation zu benutzen ist nicht nur erlaubt, sondern wird
unterstützt!

So jetzt, da du schon ganz heiss auf Python bist, willst du es wohl
detaillierter untersuchen wollen. Weil der beste Weg eine Sprache zu erlernen,
sie zu benutzen ist, läd das Tutorial dich dazu ein, während dem Lesen mit dem
Pythoninterpreter zu spielen.

Im nächsten Kapitel werden die Mechaniken der Interpreternutzung erläutert. Das
ist eher nüchterne Information, aber essentiell um die später gezeigten
Beispiele auszuprobieren.

Der Rest des Tutorials stellt durch Beispiele verschiedene Fähigkeiten der
Sprache und des Systems Python vor. Beginnend mit einfachen
Ausdrücken (Expressions), Anweisungen (Statements) und Datentypen, weiter mit
Funktionen und Modulen und schliesslich werden fortgeschrittene Konzepte wie
Ausnahmen (Exceptions) und benutzerdefinierte Klassen behandelt.
