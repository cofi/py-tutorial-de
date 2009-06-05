.. _tut-using:

********************************
Verwendung des Python-Interpreters
********************************

.. _tut-invoking:

Aufrufen des Interpreters
=========================

Sofern der Python-Interpreter auf einem Rechner installiert ist, findet man ihn normalerweise
unter :file:`/usr/local/bin/python/python3.1`. Wenn man :file:`/usr/local/bin`
in den Suchpfad der Unix-Shell setzt, kann man den Interpreter aufrufen durchi[#]_::
    
    python3.1

Die Auswahl des Installationspfades für den Interpreter ist eine Installationsoption, so dass auch
eine Installation an anderer Stelle möglich ist. Das ist mit dem örtlichen Python-Guru oder
dem Systemadministrator zu klären. (Eine populäre Alternative ist etwa :file:`/usr/local/python`)

Auf Windows-Rechnern befindet sich die Pythoninstallation meist unter
:file:`C:\\Python31`, auch wenn man das während des Installationsvorgangs ändern
kann. Um dieses Verzeichnis zum Suchpfad hinzuzufügen, kann man folgendes
Kommando in die DOS-Eingabeaufforderung eingeben::

    set path=%path%;C:\python31

Durch Eingabe eines End-Of-File Zeichens (EOF; :kbd:`Strg-D` unter Unix, :kbd:`Strg-Z`
unter Windows) in der Eingabeaufforderung des Interpreters wird der Interpreter mit
dem Rückgabewert Null beendet. Falls er das nicht tut, kann man den Interpreter
durch folgende Befehlszeile beenden: ``import sys; sys.exit(1)``.

Die Möglichkeiten des Interpreters hinsichtlich des Editierens der Eingabe sind
ziemlich beschränkt, lassen sich aber durch Einsatz der GNU readline Bibliothek
erweitern. Ob diese erweiterten Möglichkeiten verfügbar sind, lässt sich überprüfen,
indem man ein :kbd:`Strg-P` in die Eingabeaufforderung tippt. Wenn es piepst, ist die
"readline"-Unterstützung vorhanden. In diesem Fall findet man im Anhang
:ref:`tut-interacting` eine Einführung zu den einzelnen Tasten. Falls kein Piepton zu hören ist
oder ``^P`` erscheint, ist keine "readline"-Unterstützung vorhanden und die einzige Möglichkeit
zum Editiern ist die Verwendung der Rücktaste (Backspace), um Zeichen in der aktuellen
Eingabezeile zu entfernen.

Grundsätzlich ist der Interpreter ähnlich zu bedienen wie eine Unix-Shell: Wird er mit der Standardeingabe
verbunden mit einem tty Gerät aufgerufen, liest und führt er interaktiv Befehle
aus. Wird er mit einem Dateinamen als Argument oder mit einer Datei als
Standardeingabe aufgerufen, liest und führt es ein *Skript* von dieser Datei
aus.

Eine zweite Möglichkeit zum Starten des Python-Interpreters ist ``python -c Befehl [arg]
...``, wodurch die Anweisung(en) in diesem *Befehl* ausgeführt werden, analog zur
:option:`-c`-Option der Shell. Da Python-Anweisungen oft Leerzeichen oder sonstige Zeichen enthält, die von
der Shell besonders behandelt werden, sollte man den kompletten *Befehl* in einfache
Anführungszeichen setzen.

Einige Python-Module sind auch als Skripte nützlich und können mit ``python -m
Modul [arg] ...`` aufgerufen werden. Dadurch wird der Quelltext von *Modul* ausgeführt,
so als hätte man den vollständigen Namen in die Kommandozeile eingegeben.

Achtung: Es gibt es einen Unterschied zwischen ``python Datei`` und ``python
<Datei``! Im zweiten Fall werden Eingabeanfragen des Programms, wie
beispielsweise der Aufruf ``sys.stdin.read()``, von *Datei* erledigt. Da diese
Datei aber schon bis zum Ende vom Parser gelesen wurde, bevor mit der Ausführung begonnen wird,
trifft das Programm sofort auf ein End-Of-File. In ersterem Fall passiert das, was man normalerweise erwartet:
Die Eingabeanfragen werden durch diejenige Datei oder das Gerät erledigt, die bzw. das als Standardeingabe zur Verfügung steht.

Wenn eine Skriptdatei verwendet wird, ist es oft hilfreich, das Skript
auszuführen und danach in den interaktiven Modus zu wechseln.
Dies erreicht man durch die Option :option:`-i` vor dem Skript. Falls das Skript von der Standardeingabe
gelesen wird, funktioniert dies - wie oben erläutert - nicht.


.. _tut-argpassing:

Übergabe von Argumenten
-----------------------

Wenn dem Interpreter Skriptname und zusätzliche Argumente bekannt sind, werden
sie danach dem Skript in der Variablen ``sys.argv``, was eine Liste von Strings
ist, zur Verfügung gestellt. Ihre Länge ist mindestens eins; wenn kein Skript
und keine Argumente übergeben wurden, ist ``sys.argv[0]`` ein leerer String.
Wenn der Skriptname als ``'-'`` (was die Standardeingabe darstellt) gegeben ist,
so wird ``sys.argv[0]`` auf ``'-'`` gesetzt. Wird :option:`-c` *Befehl* benutzt,
so wird ``sys.argv[0]`` auf ``'-c'`` gesetzt. Wird :option:`-m` *Modul* benutzt,
so wird ``sys.argv[0]`` auf den vollqualifizierten Namen des gefundenen Moduls
gesetzt. Optionen, die sich nach :option:`-c` *Befehl* oder :option:`-m`
*Modul* befinden, werden nicht vom Pythoninterpreter aufgebraucht, sondern bleiben
dem Befehl oder Modul in ``sys.argv`` zur Benutzung erhalten.

.. _tut-interactive:

Interaktiver Modus
------------------

Werden Befehle von einem tty gelesen, sagt man, dass sich der Interpreter im
*interaktiven Modus* befindet. In diesem Modus fragt er nach dem nächsten Befehl
mit der *primären Eingabeaufforderung*, normalerweise drei größer-als Zeichen
(``>>>``); nach Fortsetzungszeilen fragt er mit der *sekundären
Eingabeaufforderung*, standardmäßig drei Punkte (``...``). Der Interpreter zeigt
eine Willkommensbotschaft an, die seine Versionsnummer und einen
Copyrighthinweis anzeigt, bevor die erste Eingabeaufforderung angezeigt wird::

   $ python3.1
   Python 3.1a1 (py3k, Sep 12 2007, 12:21:02)
   [GCC 3.4.6 20060404 (Red Hat 3.4.6-8)] on linux2
   Type "help", "copyright", "credits" or "license" for more information.
   >>>

Fortsetzungszeilen sind nötig, wenn mehrzeilige Konstrukte eingegeben werden.
Wirf zum Beispiel einen Blick auf diese :keyword:`if`-Anweisung::

   >>> the_world_is_flat = 1
   >>> if the_world_is_flat:
   ...     print("Be careful not to fall off!")
   ...
   Be careful not to fall off!

.. _tut-interp:

Der Interpreter und seine Umgebung
==================================

.. _tut-error:

Fehlerbehandlung
----------------

Tritt ein Fehler auf, so zeigt der Interpreter eine Fehlermeldung und einen
Stacktrace an. Im interaktiven Modus kehrt er dann zurück zur primären
Eingabeaufforderung; kam die Eingabe von einer Datei, beendet er mit einem von
null verschiedenen Rückgabewert, nachdem er den Stacktrace ausgegeben hat.
(Ausnahmen die von einer :keyword:`except`-Klausel in einer
:keyword:`try`-Anweisung behandelt werden, sind keine Ausnahmen in diesem
Kontext.) Manche Fehler sind bedingungslos tödlich und veranlassen ein Beenden
mit einem von null verschiedenen Rückgabewert; dies trifft bei internen
Inkonsistenzen und manchmal in Fällen von Speichermangel zu. Alle
Fehlermeldungen werden in den Standardfehlerausgabestrom geschrieben;
gewöhnliche Ausgabe von ausgeführten Befehlen wird in die Standardausgabe
geschrieben.

Die Eingabe des Interruptzeichens (normalerweise :kbd:`Strg-C` oder ENTF) bei
der primären oder sekundären Eingabeaufforderung bricht die Eingabe ab und kehrt
zur primären Eingabeaufforderung zurück. [#]_ Ein Interrupt während ein Befehl
ausgeführt wird, verursacht die :exc:`KeyboardInterrupt`-Ausnahme, die durch
eine :keyword:`try`-Anweisung behandelt werden kann.


.. _tut-scripts:

Ausführbare Pythonskripte
-------------------------

Auf BSD-ähnlichen Unixsystemen können Pythonskripte direkt ausführbar, ähnlich
Shellskripten, indem man die Zeile ::

    #!/usr/bin/env python3.1

(unter der Annahme, dass der Interpreter im :envvar:`PATH` des Benutzers ist) an
den Anfang des Skripts schreibt und der Datei Ausführungsrechte gibt. Die ``#!``
müssen die ersten zwei Zeichen der Datei sein. Auf manchen Plattformen muss
diese erste Zeile mit einem unixoiden Zeilenende (``'\n'``) enden und nicht mit
einem Windows (``'\r\n'``) Zeilenende. Bemerke, dass das Hashzeichen, oder
Raute, ``'#'``, benutzt wird um einen Kommentar in Python zu beginnen.

Dem Skript können Ausführungsrechte mit Hilfe des Befehls :program:`chmod`
verliehen werden::

    $ chmod +x myscript.py

Auf Windowssystemen gibt es keine Nennung von "Ausführungsrechten". Das
Python-Installationsprogramm verknüpft automatisch ``.py``-Dateien mit
``python.exe``, sodass ein Doppelklick auf eine Pythondatei diese als Skript
ausführen wird. Die Dateinamenserweiterung kann auch ``.pyw`` lauten, in diesem
Fall wird das normalerweise auftauchende Konsolenfenster unterdrückt.

Kodierung von Quellcode
-----------------------

Standardmäßig werden Pythonquellcode-Dateien als in UTF-8 kodiert behandelt. In
dieser Kodierung können die Zeichen der meisten Sprachen der Welt gleichzeitig
in Stringliteralen, Bezeichnern und Kommentaren benutzt werden --- jedoch
benutzt die Standardbibliothek nur ASCII-Zeichen für Bezeichner, eine Konvention
der jeder portable Code folgen sollte. Um alle diese Zeichen korrekt
darzustellen, muss dein Editor erkennen, dass die Datei UTF-8 kodiert ist und
einen Font benutzen, der alle Zeichen der Datei unterstützt.

Es ist auch möglich eine andere Kodierung für Quellcode-Dateien festzulegen. Um
das zu tun, muss man noch eine andere spezielle Kommentarzeile gleich hinter der
``#!`` Zeile einfügen, um die Kodierung der Datei festzulegen::

    # -*- coding: Kodierung -*-

Mit dieser Angabe wird alles in der Quellcode-Datei so behandelt, als hätte es
die Kodierung *Kodierung* anstatt UTF-8. Die Liste der möglichen Kodierungen
kann in der Python Library Reference, in der Sektion zu :mod:`codecs`, gefunden
werden.

Wenn dein Lieblingseditor beispielsweise keine UTF-8 kodierten Dateien
unterstützt und auf die Benutzung einer anderen Kodierung besteht, sagen wir mal
Windows-1252, kannst du folgendes schreiben::

    # -*- coding: cp-1252 -*-

und immernoch alle Zeichen des Windows-1252 Zeichensatzes in den
Quellcode-Dateien benutzen. Dieser spezielle Kodierungskommentar muss in der
*ersten oder zweiten* Zeile der Datei stehen.

.. _tut-startup:

Die interaktive Startup-Datei
-----------------------------------

Wenn man Python interaktiv benutzt, ist es oft nützlich ein paar Standardbefehle
auszuführen jedes Mal wenn der Interpreter gestartet wird. Das kannst du
erreichen, indem du eine Umgebungsvariable namens :env:`PYTHONSTARTUP`
erstellst, die auf eine Datei verweist, die deine Startupbefehle enthält.
Dies ist der :file:`.profile`-Fähigkeit von Unixshells ähnlich.

Diese Datei wird nur in interaktiven Sitzungen gelesen und weder wenn Python
Befehle aus einem Skript ausführt, noch wenn :file:`/dev/tty` explizit als die
Quelle von Befehlen angegeben wird (was sich ansonsten wie eine interaktive
Sitzung verhält). Sie wird im selben Namensraum wie interaktive Befehle
ausgeführt, so dass Objekte die sie definiert oder importiert ohne
Qualifizierung in der interaktiven Sitzung genutzt werden können. Du kannst auch
die Eingabeaufforderungen ``sys.ps1`` und ``sys.ps2`` in dieser Datei ändern.

Falls du noch eine weitere Startup-Datei aus dem aktuellen Verzeichnis
lesen willst, kannst du dies in der globalen Datei mit Code wie ``if
os.path.isfile('.pythonrc.py'): exec(open('.pythonrc.py').read())``
programmieren. Falls du die Startup-Datei in einem Skript benutzen willst,
musst du das explizit in dem Skript tun::

    import os
    filename = os.environ.get('PYTHONSTARTUP')
    if filename and os.path.isfile(filename):
        exec(open(filename).read())

.. rubric:: Fußnoten

.. [#] Unter Unix wird der 3.1 Interpreter nicht standardmäßig als die
   ausführbare Datei namens ``python`` installiert, damit es nicht mit einer
   gleichzeitig installierten Python 2.x Version kollidiert

.. [#] Ein Problem mit dem GNU readline Paket kann dies verhindern.
