.. _tut-modules:

******
Module
******

Wenn man den Python-Interpreter beendet und erneut startet, gehen alle
vorgenommenen Definitionen (Funktionen und Variablen) verloren. Deshalb
benutzt man vorzugsweise einen Text-Editor, um längere und komplexere Programme
zu schreiben und verwendet eine Datei als Eingabe für den Interpreter. Diese Datei
wird auch als Skript bezeichnet. Wird ein Programm länger, teilt man es
besser in mehrere Dateien auf, um es leichter warten zu können. Außerdem ist es
von Vorteil, nützliche Funktionen in mehreren Programmen verwenden zu können, ohne sie in jedem Programm erneut definieren zu müssen.

Hierfür bietet Python die Möglichkeit, etwas in einer Datei zu definieren und
diese in einer anderen Datei oder in der interaktiven Konsole wieder zu
verwenden. So eine Datei wird als *Modul* bezeichnet. Definitionen eines Moduls
können in anderen Modulen oder in das *Hauptmodul* *importiert* werden, welches
die Gesamtheit aller Funktionen und Variablen enthält, auf die man in einem Skript
zugreifen kann).
 
Ein Modul ist eine Datei, die Python-Definitionen und -Anweisungen beinhaltet.
Der Dateiname mit dem :file:`.py` Suffix entspricht dem Namen des Moduls.
Innerhalb eines Moduls ist der Modulname als ``__name__`` verfügbar (globale
Variable des Typs String). Zum Beispiel: Öffne einen Editor deiner Wahl und
erstelle eine Datei im aktuellen Verzeichnis mit dem Namen :file:`fibo.py` und
folgendem Inhalt::

	# Fibonacci Zahlen Modul

	def fib(n):    # schreibe Fibonacci Folge bis n
	    a, b = 0, 1
	    while b < n:
	        print(b, end=' ')
	        a, b = b, a+b
	    print()

	def fib2(n): # gib die Fibonacci Folge zurück bis n
	    result = []
	    a, b = 0, 1
	    while b < n:
	        result.append(b)
	        a, b = b, a+b
	    return result
	
Öffne danach deinen Python-Interpreter und importiere das Modul mit folgendem
Befehl::

	>>> import fibo
	
Dieser Befehl fügt die von :file:`fibo.py` definierten Funktionen nicht
automatisch in die globale Symboltabelle ein, sondern nur den Modulnamen
``fibo``. Um die Funktionen anzusprechen, benutzt man den Modulnamen::

	>>> fibo.fib(1000)
	1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987
	>>> fibo.fib2(100)
	[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
	>>> fibo.__name__
	'fibo'
	
Wenn man plant, eine Funktion öfters zu verwenden, kann man diese an einen
lokalen Namen binden.

	>>> fib = fibo.fib
	>>> fib(500)
	1 1 2 3 5 8 13 21 34 55 89 144 233 377

.. _tut-moremodules:

Mehr zum Thema Module
=====================

Ein Modul kann sowohl ausführbare Anweisungen, als auch Definitionen einer
Funktion enthalten. Diese Anweisungen sind dazu gedacht, das Modul zu
initialisieren, und werden nur ausgeführt, wenn das Modul zum ersten Mal
importiert wird.

Jedes Modul hat seine eigene, private Symboltabelle, welche wiederum als globale
Symboltabelle von allen Funktion in diesem Modul verwendet wird. Daher kann der
Verfasser eines Moduls ohne Bedenken globale Variablen in seinem Modul
verwenden, da sie sich nicht mit den globalen Variablen des Benutzers
überschneiden können. Andererseits kann man (wenn man weiß, was man tut) auch
die globalen Variablen eines Moduls verändern, indem man die gleiche
Schreibweise verwendet, um auch dessen Funktionen anzusprechen,
``modname.itemname``.

Module können andere Module importieren. Es ist üblich, aber nicht zwingend
notwendig, dass man alle :keyword:`import`-Anweisungen an den Anfangs eines
Moduls setzt (oder in diesem Fall Skripts). Die Namen der importierten Module
werden in die Symboltabelle des importierenden Moduls eingefügt.

Es gibt eine Variante der :keyword:`import`-Anweisung, welche bestimme Namen aus
einem Modul direkt in die Symboltabelle des importierenden Moduls einfügt.
Beispielsweise::

	>>> from fibo import fib, fib2
	>>> fib(500)
	1 1 2 3 5 8 13 21 34 55 89 144 233 377
	
Diese Variante fügt allerdings nicht den Modulnamen, aus dem die Namen
importiert werden, in die lokale Symboltabelle ein, sondern nur die
aufgeführten. In diesem Beispiel wird ``fibo`` also nicht eingefügt.

Zusätzlich gibt es eine Variante um alle Namen eines Moduls zu importieren:

	>>> from fibo import *
	>>> fib(500)
	1 1 2 3 5 8 13 21 34 55 89 144 233 37
	
Hiermit werden alle Namen, außer denen, die mit einem Unterstrich beginnen
(`_`), importiert. In den meisten Fällen wird diese Variante nicht verwendet,
denn dadurch werden unbekannte Namen in den Interpreter importiert und so kann es
vorkommen, dass einige Namen überschrieben werden, die bereits definiert worden
sind.

.. note::

    Aus Effizienzgründen wird jedes Modul nur einmal durch eine
    Interpreter-Sizung importiert. Deshalb muss man den Interpreter bei
    Veränderung der Module neustarten - oder man benutzt :func:`reload`,
    beispielsweise ``reload(modulename)``, falls es nur ein Modul ist, welches
    man interaktiv testen will.
	
.. _tut-modulesasscripts:
	
Module als Skript aufrufen
--------------------------

Wenn man ein Python-Modul folgendermaßen aufruft::

	python fibo.py <Argumente>
	
wird der Code im Modul genauso ausgeführt, als hätte man das Modul importiert.
Der einzige Unterschied ist, dass ``__name__`` jetzt ``"__main__"`` ist und
nicht mehr der Name des Moduls. Wenn man nun folgende Zeilen an das Ende des
Moduls anfügt::

	if __name__ == "__main__":
	    import sys
	    fib(int(sys.argv[1]))
	
kann man die Datei sowohl als Skript als auch als importierbares Modul
nutzbar, da der Code, der die Kommandozeile auswertet, nur ausgeführt wird,
wenn das Modul direkt als *Hauptdatei* ausgeführt wird::

	$ python fibo.py 50
	1 1 2 3 5 8 13 21 34
	
Beim Import des Moduls wird dieser Code nicht ausgeführt::

	>>> import fibo
	>>>
	
Dies wird oft dazu verwendet, um entweder eine bequeme Benutzerschnittstelle zum
Modul bereitzustellen oder zu Testzwecken (wenn das Modul als Skript ausgeführt
wird, wird eine Testsuite gestartet).

.. _tut-searchpath:

Der Modul Suchpfad
------------------

.. index:: triple: module; search; path

Wenn ein Modul mit dem Namen :mod:`spam` importiert wird, sucht der Interpreter
im aktuellen Verzeichnis nach einer Datei mit dem Namen :file:`spam.py` und dann
in der Verzeichnisliste, die in der Umgebungsvariable :envvar:`PYTHONPATH`
gesetzt ist. Diese hat die gleiche Syntax wie die Shell Variable :envvar:`PATH`,
welche auch eine Verzeichnisliste ist. Falls :envvar:`PYTHONPATH` nicht gesetzt
ist oder wenn die Datei nicht gefunden wurde, so wird die Suche in einem
installationsabhängigen Pfad fortgesetzt; unter Unix ist das normalerweise:
:file:`.:/usr/local/lib/python`.

Tatsächlich werden Module in der Reihenfolge gesucht, in der sie in der Variable
`sys.path` aufgeführt sind, welche mit dem aktuellen Verzeichnis, in dem sich
auch das Skript befindet beginnt, gefolgt von :envvar:`PYTHONPATH` und dem
installationsabhängigen default-Pfad. Dies erlaubt Python-Programmen, die
Suchpfade zu verändern, zu ersetzen oder die Reihenfolge zu ändern. Zu Beachten
ist, dass das Skript nicht den selben Namen haben wie eines der Standardmodule,
da das aktuelle Verzeichnis ja auch im Suchpfad enthalten ist. In diesem Fall
versucht Python das Skript als Modul zu importieren, was normalerweise zu einem
Fehler führt. Siehe :ref:`tut-standardmodules` für mehr Informationen.

Kompilierte Python-Dateien
--------------------------

Um den Start von kurzen Programmen, die viele Standard Module verwenden,
schneller zu machen, werden Dateien erstellt, welche bereits "byte-kompiliert"
sind. Existiert eine Datei mit dem Namen :file:`spam.pyc`, so ist das eine
"byte-kompilierte" Version der Datei :file:`spam.py` und des Moduls :mod:`spam`.
Der Zeitpunkt an dem die Datei :file:`spam.py` zuletzt geändert wurde, wird in
:file:`spam.pyc` festgehalten. Falls die Zeiten nicht übereinstimmen, wird die
:file:`.pyc` ignoriert.

Normalerweise muss man nichts tun, damit die :file:`spam.pyc` Datei erstellt
wird. Immer wenn :file:`spam.py` erfolgreich kompiliert wird, wird auch
versucht die kompilierte Version in :file:`spam.pyc` zu schreiben. Es wird kein
Fehler geworfen, wenn der Vorgang scheitert; wenn aus irgendeinem Grund die
Datei nicht vollständig geschrieben sein sollte, wird die daraus resultierende
:file:`spam.pyc` automatisch als fehlerhaft erkannt und damit später ignoriert.
Der Inhalt der :file:`spam.pyc` ist plattformunabhängig, wodurch man ein Modul
Verzeichnis mit anderen Maschinen ohne Rücksicht auf ihre Architektur teilen
kann.

Einige Tipps für Experten:

* Wird der Python Interpreter mit dem :option:`-O` Flag gestartet, so
  so wird der optimierte Code in :file:`.pyo` Dateien gespeichert. Optimierter
  Code hilft momentan nicht viel, da er lediglich :keyword:`assert`-Anweisungen
  entfernt. Wird :option:`-O` verwendet, wird der *komplette*
  :term:`Bytecode` optimiert; :file:`.pyc` werden ignoriert und :file:`.py`
  Dateien werden zu optimiertem Bytecode kompiliert.

* Werden dem Python Interpreter zwei :option:`-O` Flags übergiben, vollzieht
  der Bytecode-Compiler Optimierungen, die zu einer
  Fehlfunktion des Programms führen können. Momentan werden nur ``__doc__``
  Strings aus dem Bytecode entfernt, was zu kleineren :file:`.pyo` Dateien
  führt. Da einige Programm sich darauf verlassen, dass sie verfügbar
  sind, sollte man diese Option nur aktivieren, wenn man weiß, was man tut.

* Ein Programm wird in keinster Weise schneller ausgeführt, wenn es aus einer
  :file:`.pyc` oder :file:`.pyo` anstatt aus einer :file:`.py` Datei gelesen
  wird; der einzige Geschwindigkeitsvorteil ist beim Starten der Dateien.

* Wenn ein Skript durch das Aufrufen über die Kommandozeile ausgeführt wird,
  wird der Bytecode nie in eine :file:`.pyc` oder :file:`.pyo` Datei
  geschrieben. Deshalb kann die Startzeit eines Skripts durch das Auslagern des
  Codes in ein Modul reduziert werden. Es ist auch möglich eine :file:`.pyc`-
  oder :file:`.pyo`-Datei direkt in der Kommandozeile auszuführen.

* Es ist möglich, eine :file:`.pyc` oder :file:`.pyo` Datei zu haben, ohne
  dass eine Datei mit dem Namen :file:`spam.py` für selbiges Modul existiert.
  Dies kann dazu genutzt werden, Python-Code auszuliefern, der relativ schwer
  rekonstruiert werden kann.

* Das Modul :mod:`compileall` kann :file:`.pyc` Dateien (oder auch :file:`.pyo`,
  wenn :option:`-O` genutzt wird) aus allen Module eines Verzeichnis erzeugen.

Standard Module
===============

Python wird mit einer Bibliothek von Standard Modulen ausgeliefert, welche in
der Python Library Reference beschrieben werden. Einige Module sind in den
Interpreter eingebaut; diese bieten Zugang zu Operationen, die nicht Teil des
Sprachkerns sind, aber trotzdem eingebaut sind. Entweder, um Zugang
zu Systemoperationen (wie z.B. Systemaufrufe) bereitzustellen oder aus
Effizienzgründen. Die Zusammenstellung dieser Module ist eine Option in der
Konfiguration, welche auch von der verwendeten Plattform abhängig ist.
Beispielsweise ist das :mod:`winreg` Modul nur unter Windows Systemen verfügbar.
Ein bestimmtes Modul verdient besondere Aufmerksamkeit: :mod:`sys`, welches in
jeden Python Interpreter eingebaut ist. Die Variablen ``sys.ps1`` und
``sys.ps2`` definieren die primären und sekundären Eingabeaufforderungen, die in der
Kommandozeile verwendet werden::

	>>> import sys
	>>> sys.ps1
	'>>> '
	>>> sys.ps2
	'... '
	>>> sys.ps1 = 'C> '
	C> print('Yuck!')
	Yuck!
	C>
	
Diese beiden Variablen werden nur definiert, wenn der Interpreter im
interaktiven Modus ist.

Die Variable ``sys.path`` ist eine Liste von Zeichenketten, die den Suchpfad des
Interpreters vorgibt. Sie ist mit einem Standardpfad voreingestellt, der aus der
Umgebungsvariable :envvar:`PYTHONPATH` entnommen wird oder aus einem eingebauten
Standardwert, falls :envvar:`PYTHONPATH` nicht gesetzt ist. Man diese Variable
mit normalen Listenoperationen verändern::

	>>> import sys
	>>> sys.path.append('/ufs/guido/lib/python')
	
