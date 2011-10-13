.. _tut-interacting:

**********************************************************
Interaktive Eingabe-Bearbeitung und Ersetzung des Verlaufs
**********************************************************

Einige Versionen des Python-Interpreters unterstützen die Bearbeitung der
aktuellen Zeile und die Ersetzung des Verlaufs ähnlich der Möglichkeiten die die
Korn-Shell oder die GNU Bash-Shell bieten. Dies wird durch die Benutzung der
`GNU Readline`_-Bibliothek implementiert, die eine Bearbeitung im Emacs- oder
vi-Stil ermöglicht. Da diese Bibliothek eine eigene Dokumentation hat, wird sie
hier nicht neu geschrieben, aber die Grundlagen lassen sich einfach erklären.
Die hier beschriebenen Möglichkeiten sind in der Unix- und Cygwin-Version des
Interpreters optional vorhanden.

Dieses Kapitel beschäftigt sich weder mit den Bearbeitungsmöglichkeiten, die
Mark Hammonds PythonWin-Paket bereitstellt, noch mit denen der auf Tk basierten
Entwicklungsumgebung IDLE, die mit Python verteilt wird. Der
Kommandozeilen-Rückruf, den es innerhalb der DOS-Boxen unter NT und ein paar
anderen DOS- und Windows-Versionen gibt, ist auch eine ganz andere
Angelegenheit.


.. _tut-lineediting:

Zeilenbearbeitung
=================

Falls unterstützt, ist die Bearbeitung der Eingabezeile immer dann aktiv, wenn
der Interpreter eine primäre oder sekundäre Eingabeaufforderung ausgibt. Die
aktuelle Zeile kann mit den üblichen Emacs-Steuerzeichen bearbeitet werden. Die
wichtigsten davon sind: :kbd:`Strg-A` bewegt den Cursor zum Anfang der Zeile,
:kbd:`Strg-E` zum Ende. :kbd:`Strg-B` bewegt ihn ein Zeichen nach links,
:kbd:`Strg-F` nach rechts. :kbd:`Strg-K` löscht ("killt") den Rest der Zeile
rechts vom Cursor, :kbd:`Strg-Y` fügt die zuletzt gelöschten Zeichen wieder ein
("yankt"). :kbd:`Strg-_` macht die zuletzt getätigte Änderung rückgängig und
kann wiederholt werden, um sie mehrmals auszuführen.


.. _tut-history:

Ersetzung des Verlaufs
======================

Die Ersetzung des Verlaufs funktioniert so: Alle eingetippten, nicht-leeren
Zeilen werden in einem Verlaufspuffer gespeichert. Wird eine neue
Eingabeaufforderung ausgegeben, ist man am Ende dieses Puffers platziert.
:kbd:`Strg-P` bewegt einen eine Zeile im Puffer zurück, :kbd:`Strg-N` eine Zeile
vorwärts. Jede Zeile im Verlaufspuffer kann bearbeitet werden; ein Sternchen vor
der Eingabeaufforderung markiert eine Zeile als geändert. Drückt man die
:kbd:`Enter`-Taste, wird die aktuelle Zeile an den Interpreter übergeben.
:kbd:`Strg-R` startet eine inkrementelle Rückwärtssuche, :kbd:`Strg-S` eine
Vorwärtssuche.

Tastenkombinationen
===================

Die Tastenkombinationen und ein paar andere Parameter der Readline-Bibliothek
können angepasst werden, indem man Befehle in eine Initialisierungsdatei namens
:file:`~/.inputrc` schreibt. Tastenkombinationen haben die Form ::
    
    Tastenname: Funktionsname

oder ::
    
    "Zeichenkette": Funktionsname

und Optionen können so verändert werden::

    set Optionsname Wert

Zum Beispiel::

    #Ich bevorzuge den Bearbeitungsstil von vi:
    set editing-mode vi

    #Auf einer einzelnen Zeile bearbeiten:
    set horizontal-scroll-mode On

    #Ein paar Tastenkombinationen verändern:
    Meta-h: backward-kill-word
    "\C-u": universal-argument
    "\C-x\C-r": re-read-init-file

Beachte, dass in Python die Standardkombination für :kbd:`Tab` das Einfügen
eines :kbd:`Tab`-Zeichens ist, anstatt dem Readline-Standard, die Funktion zum
vervollständigen von Dateinamen. Bestehst du aber darauf, kannst du das mit ::

    Tab: complete

in deiner :file:`~/.inputrc` überschreiben. (Aber natürlich erschwert das das
Schreiben von eingerückten Fortsetzungszeilen, wenn man es gewöhnt ist,
:kbd:`Tab` dafür zu benutzen.)

.. index::
   module: rlcompleter
   module: readline

Automatische Vervollständigung von Variablen- und Modulnamen ist optional
verfügbar. Um sie im Interaktiven Modus des Interpreters zu aktivieren, füge
folgendes in deine Startup-Datei[#]_ ein::

    import rlcompleter, readline
    readline.parse_and_bind('tab: complete')

Dies bindet die :kbd:`Tab`-Taste an die Vervollständigungsfunktion, tippt man
sie also zweimal bekommt man Vorschläge zur Vervollständigung; die Funktion
durchsucht die lokalen Variablen und die Namen in verfügbaren Module. Für
Ausdrücke mit Punkten, wie ``string.a``, wird sie den Ausdruck bis zum letzen
``'.'`` auswerten und dann Vervollständigungen aus den Attributen des sich
ergebenden Objektes vorschlagen. Beachte, dass dies von der Anwendung
definierten Code ausführen könnte, wenn ein Objekt mit einer
:meth:`__getattr__``-Methode Teil des Ausdrucks ist.

Eine leistungsfähigere Startup-Datei könnte wie das Beispiel aussehen. Beachte,
dass sie die Namen löscht, sobald sie nicht mehr benötigt werden; dies wird
getan, da die Startup-Datei im selben Namensraum wie die interaktiven Befehle
ausgeführt wird und das Entfernen der Namen Nebeneffekte in der interaktiven
Umgebung vermeidet. Du könntest es nützlich finden manche der importierten
Module, wie :mod:`os`, das in den meisten Interpreter-Sitzungen gebraucht wird,
zu behalten. ::

    # Add auto-completion and a stored history file of commands to your Python
    # interactive interpreter. Requires Python 2.0+, readline. Autocomplete is
    # bound to the Esc key by default (you can change it - see readline docs).
    #
    # Store the file in ~/.pystartup, and set an environment variable to point
    # to it:  "export PYTHONSTARTUP=~/.pystartup" in bash.
    #

    import atexit
    import os
    import readline
    import rlcompleter

    historyPath = os.path.expanduser("~/.pyhistory")

    def save_history(historyPath=historyPath):
       import readline
       readline.write_history_file(historyPath)

    if os.path.exists(historyPath):
       readline.read_history_file(historyPath)

    atexit.register(save_history)
    del os, atexit, readline, rlcompleter, save_history, historyPath


.. _tut-commentary:

Alternativen zum Interaktiven Interpreter
=========================================

Diese Möglichkeiten sind ein enormer Schritt vorwärts verglichen mit früheren
Versionen des Interpreters, aber ein paar Wünsche sind noch offen: Es wäre nett,
wenn die richtige Einrückung bei Fortsetzungszeilen vorgeschlagen würde (der
Parser weiss, ob eine Einrückung benötigt wird). Der
Vervollständigungsmechanismus könnte die Symbolstabelle des Interpreters nutzen.
Und ein Befehl zum Überprüfen von passenden Klammern, Anführungszeichen, usw.
(oder sie sogar vorschlägt) wäre auch nützlich.

Ein alternativer erweiterter interaktiver Interpreter, der schon seit einer
Weile verfügbar ist, ist IPython_. Er bietet Tab Completion, Erkundung von
Objekten und eine fortschrittliche Verwaltung der Befehls-Chronik. Er kann
komplett angepasst werden und auch in andere Anwendungen eingebettet werden.
Eine weitere ähnlich fortschrittliche interaktive Umgebung ist bpython_.

.. rubric:: Fußnoten

.. [#] Python wird beim Starten des Interaktiven Interpreters den Inhalt der
   Datei ausführen, die von der Umgebungsvariable :envvar:`PYTHONSTARTUP`
   angegeben wird. Um Python sogar für den nicht-interaktiven Modus anzupassen,
   siehe :ref:`tut-customize`.

.. _GNU Readline: http://tiswww.case.edu/php/chet/readline/rltop.html
.. _IPython: http://ipython.scipy.org/
.. _bpython: http://www.bpython-interpreter.org/

