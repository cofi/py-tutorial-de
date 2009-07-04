.. _tut-modules:

******
Module
******

Wenn man den Python-Interpreter beendet und erneut startet, gehen alle
vorgenommenen Definitionen (Funktionen und Variablen) verloren. Deshalb benutzt
man vorzugsweise einen Text-Editor, um längere und komplexere Programme zu
schreiben und verwendet eine Datei als Eingabe für den Interpreter. Diese Datei
wird auch als Skript bezeichnet. Wird ein Programm länger, teilt man es besser
in mehrere Dateien auf, um es leichter warten zu können. Außerdem ist es von
Vorteil, nützliche Funktionen in mehreren Programmen verwenden zu können, ohne
sie in jedem Programm erneut definieren zu müssen.

Hierfür bietet Python die Möglichkeit, etwas in einer Datei zu definieren und
diese in einer anderen Datei oder in der interaktiven Konsole wieder zu
verwenden. So eine Datei wird als *Modul* bezeichnet. Definitionen eines Moduls
können in anderen Modulen oder in das *Hauptmodul* *importiert* werden, welches
die Gesamtheit aller Funktionen und Variablen enthält, auf die man in einem
Skript zugreifen kann.
 
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
automatisch in die globale Symboltabelle (symbol table) ein, sondern nur den
Modulnamen ``fibo``. Um die Funktionen anzusprechen, benutzt man den
Modulnamen::

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
notwendig, dass man alle :keyword:`import`-Anweisungen an den Anfang eines
Moduls setzt (oder in diesem Fall Skripts). Die Namen der importierten Module
werden in die Symboltabelle des importierenden Moduls eingefügt.

Es gibt eine Variante der :keyword:`import`-Anweisung, welche bestimmte Namen aus
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
nutzen, da der Code, der die Kommandozeile auswertet, nur ausgeführt wird,
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

Der Modul-Suchpfad
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
Suchpfade zu verändern, zu ersetzen oder die Reihenfolge zu ändern. Zu beachten
ist, dass das Skript nicht den selben Namen haben darf wie eines der
Standardmodule, da das aktuelle Verzeichnis ja auch im Suchpfad enthalten ist.
In diesem Fall versucht Python das Skript als Modul zu importieren, was
normalerweise zu einem Fehler führt. Siehe :ref:`tut-standardmodules` für mehr
Informationen.

"Kompilierte" Python-Dateien
----------------------------

Um den Start von kurzen Programmen, die viele Standard Module verwenden,
schneller zu machen, werden Dateien erstellt, welche bereits "byte-kompiliert"
sind. Existiert eine Datei mit dem Namen :file:`spam.pyc`, so ist das eine
"byte-kompilierte" Version der Datei :file:`spam.py` und des Moduls :mod:`spam`.
Der Zeitpunkt an dem die Datei :file:`spam.py` zuletzt geändert wurde, wird in
:file:`spam.pyc` festgehalten. Falls die Zeiten nicht übereinstimmen, wird die
:file:`.pyc` ignoriert.

Normalerweise muss man nichts tun, damit die :file:`spam.pyc` Datei erstellt
wird. Immer, wenn :file:`spam.py` erfolgreich kompiliert wird, wird auch
versucht die kompilierte Version in :file:`spam.pyc` zu schreiben. Es wird kein
Fehler geworfen, wenn der Vorgang scheitert; wenn aus irgendeinem Grund die
Datei nicht vollständig geschrieben sein sollte, wird die daraus resultierende
:file:`spam.pyc` automatisch als fehlerhaft erkannt und damit später ignoriert.
Der Inhalt der :file:`spam.pyc` ist plattformunabhängig, wodurch man ein Modul
Verzeichnis mit anderen Maschinen ohne Rücksicht auf ihre Architektur teilen
kann.

Einige Tipps für Experten:

* Wird der Python Interpreter mit dem :option:`-O` Flag gestartet, so
  wird der optimierte Code in :file:`.pyo` Dateien gespeichert. Optimierter
  Code hilft momentan nicht viel, da er lediglich :keyword:`assert`-Anweisungen
  entfernt. Wird :option:`-O` verwendet, wird der *komplette*
  :term:`Bytecode` optimiert; :file:`.pyc` werden ignoriert und :file:`.py`
  Dateien werden zu optimiertem Bytecode kompiliert.

* Werden dem Python Interpreter zwei :option:`-O` Flags übergiben, vollzieht
  der Bytecode-Compiler Optimierungen, die zu einer
  Fehlfunktion des Programms führen können. Momentan werden nur ``__doc__``
  Strings aus dem Bytecode entfernt, was zu kleineren :file:`.pyo` Dateien
  führt. Da einige Programme sich darauf verlassen, dass sie verfügbar
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
  wenn :option:`-O` genutzt wird) aus allen Modulen eines Verzeichnisses
  erzeugen.

.. _tut-standardmodules:

Standard Module
===============

.. index:: module: sys

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
``sys.ps2`` definieren die primären und sekundären Eingabeaufforderungen, die in
der Kommandozeile verwendet werden::

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
Standardwert, falls :envvar:`PYTHONPATH` nicht gesetzt ist. Man kann diese
Variable mit normalen Listenoperationen verändern::

	>>> import sys
	>>> sys.path.append('/ufs/guido/lib/python')
	
.. _tut-dir:

Die :func:`dir` Funktion
========================

Die eingebaute Funktion :func:`dir` wird benutzt, um herauszufinden, welche
Namen in einem Modul definiert sind. Es wird eine sortierte Liste von Strings
zurückgegeben::

	>>> import fibo, sys
	>>> dir(fibo)
	['__name__', 'fib', 'fib2']
	>>> dir(sys)
    ['__displayhook__', '__doc__', '__excepthook__', '__name__', '__stderr__',
    '__stdin__', '__stdout__', '_getframe', 'api_version', 'argv',
    'builtin_module_names', 'byteorder', 'callstats', 'copyright',
    'displayhook', 'exc_info', 'excepthook', 'exec_prefix', 'executable',
    'exit', 'getdefaultencoding', 'getdlopenflags', 'getrecursionlimit',
    'getrefcount', 'hexversion', 'maxint', 'maxunicode', 'meta_path', 'modules',
    'path', 'path_hooks', 'path_importer_cache', 'platform', 'prefix', 'ps1',
    'ps2', 'setcheckinterval', 'setdlopenflags', 'setprofile',
    'setrecursionlimit', 'settrace', 'stderr', 'stdin', 'stdout', 'version',
    'version_info', 'warnoptions']
	
Wenn man keine Parameter übergibt, liefert :func:`dir` eine Liste der aktuell
definierten Namen::

	>>> a = [1, 2, 3, 4, 5]
	>>> import fibo
	>>> fib = fibo.fib
	>>> dir()
    ['__builtins__', '__doc__', '__file__', '__name__', 'a', 'fib', 'fibo',
    'sys']
	
Zu Beachten ist, dass alle Typen von Namen ausgegeben werden: Variablen, Module,
Funktionen, etc.

.. index:: module: builtins

:func:`dir` listet allerdings nicht die Namen der eingebauten Funktionen und
Variablen auf. Falls man diese auflisten will, muss man das Standardmodul
:mod:`builtins` verwenden::

	>>> import builtins
	>>> dir(builtins)

    ['ArithmeticError', 'AssertionError', 'AttributeError', 'BaseException',
    'Buffer Error', 'BytesWarning', 'DeprecationWarning', 'EOFError',
    'Ellipsis', 'Environme ntError', 'Exception', 'False', 'FloatingPointError',
    'FutureWarning', 'Generato rExit', 'IOError', 'ImportError',
    'ImportWarning', 'IndentationError', 'IndexErr or', 'KeyError',
    'KeyboardInterrupt', 'LookupError', 'MemoryError', 'NameError', 'None',
    'NotImplemented', 'NotImplementedError', 'OSError', 'OverflowError',
    'PendingDeprecationWarning', 'ReferenceError', 'RuntimeError',
    'RuntimeWarning', ' StopIteration', 'SyntaxError', 'SyntaxWarning',
    'SystemError', 'SystemExit', 'TabError', 'True', 'TypeError',
    'UnboundLocalError', 'UnicodeDecodeError', 'Unicod eEncodeError',
    'UnicodeError', 'UnicodeTranslateError', 'UnicodeWarning', 'UserWarning',
    'ValueError', 'Warning', 'ZeroDivisionError', '__build_class__',
    '__debug__', '__doc__', '__import__', '__name__', '__package__', 'abs',
    'all', 'any', 'ascii', 'bin', 'bool', 'bytearray', 'bytes', 'chr',
    'classmethod', 'compile', ' complex', 'copyright', 'credits', 'delattr',
    'dict', 'dir', 'divmod', 'enumerate ', 'eval', 'exec', 'exit', 'filter',
    'float', 'format', 'frozenset', 'getattr', 'globals', 'hasattr', 'hash',
    'help', 'hex', 'id', 'input', 'int', 'isinstance', 'issubclass', 'iter',
    'len', 'license', 'list', 'locals', 'map', 'max', 'memory view', 'min',
    'next', 'object', 'oct', 'open', 'ord', 'pow', 'print', 'property' , 'quit',
    'range', 'repr', 'reversed', 'round', 'set', 'setattr', 'slice', 'sort ed',
    'staticmethod', 'str', 'sum', 'super', 'tuple', 'type', 'vars', 'zip']
	
.. _tut-packages:

Pakete
======

Pakete werden dazu verwendet, den Modul-Namensraum von Python zu strukturieren,
indem man Modulnamen durch Punkte trennt. Zum Beispiel verweist :mod:`A.B` auf
ein Untermodul ``B`` im Paket ``A``. Genauso wie die Verwendung von Modulen den
Autor von Modulen davor bewahrt, sich Sorgen um andere globale Variablennamen zu
machen, so bewahrt die Verwendung von Modulen, die durch mehrere Punkte getrennt
sind, den Autor davor, sich Sorgen um andere Modulnamen machen zu müssen.

Angenommen man will eine Sammlung von Modulen (ein "Paket") erstellen, um
Audiodateien und -daten einheitlich zu bearbeiten. Es gibt unzählige
verschiedene Audioformate (gewöhnlicherweise erkennt man diese an Ihrer
Dateiendung, z.B. :file:`.wav`, :file:`.aiff`, :file:`.au`), sodass man eine
ständig wachsende Sammlung von Modulen erstellen und warten muss. Außerdem will
man auch verschiedene Arbeiten an den Audiodaten verrichten (wie zum Beispiel
Mixen, Echo hinzufügen, etc.), also wird man immer wieder Module schreiben, die
diese Arbeiten ausführen. Hier eine mögliche Struktur für so ein Paket
(ausgedrückt in der Form eines hierarchischen Dateisystems)::

	sound/                          Top-level package
	         __init__.py               Initialize the sound package
	         formats/                  Subpackage for file format conversions
	                 __init__.py
	                 wavread.py
	                 wavwrite.py
	                 aiffread.py
	                 aiffwrite.py
	                 auread.py
	                 auwrite.py
	                 ...
	         effects/                  Subpackage for sound effects
	                 __init__.py
	                 echo.py
	                 surround.py
	                 reverse.py
	                 ...
	         filters/                  Subpackage for filters
	                 __init__.py
	                 equalizer.py
	                 vocoder.py
	                 karaoke.py
	                 ...
	
Wenn man das Paket importiert, sucht Python durch die Verzeichnisse im
``sys.path``, um nach dem Paket in einem Unterverzeichnis zu suchen.

Die :file:`__init__.py` Datei wird benötigt, damit Python das Verzeichnis als
Pakete behandelt; dies wurde gemacht, damit Verzeichnisse mit einem normalen
Namen, wie z.B. ``string``, nicht unbeabsichtigt Module verstecken, die weiter
hinten im Suchpfad erscheinen. Im einfachsten Fall ist :file:`__init__.py` eine
leere Datei, sie kann allerdings auch Initialisierungscode für das Paket
enthalten oder die ``__all__`` Variable setzen, welche später genauer
beschrieben wird.

Benutzer eines Pakets können individuelle Module aus dem Paket importieren::

	import sound.effects.echo

Dieser Vorgang lädt das Untermodul :mod:`sound.effects.echo`. Es muss mit seinem
kompletten Namen referenziert werden::

	sound.effects.echo.echofilter(input, output, delay=0.7, atten=4)
	
Eine alternative Methode, um dieses Untermodul zu importieren::

	from sound.effects import echo
	
Diese Variante lädt auch das Untermodul :mod:`echo`, macht es aber ohne seinen
Paket-Präfix verfügbar. Man verwendet es folgendermaßen::

	echo.echofilter(input, output, delay=0.7, atten=4)
	
Eine weitere Möglichkeit ist, die beschriebene Funktion oder Variable direkt zu
importieren::

	from sound.effects.echo import echofilter
	
Genau wie in den anderen Beispielen, lädt dies das Untermodul :mod:`echo`. In
diesem Fall wird aber die :func:`echofilter` Funktion direkt verfügbar gemacht::

	echofilter(input, output, delay=0.7, atten=4)
	
Wenn man ``from package import item`` verwendet, kann das ``item`` entweder ein
Untermodul und -paket sein oder ein Name, der in diesem Paket definiert ist
(z.B. eine Funktion, eine Klasse oder Variable). Das ``import`` Statement
überprüft zuerst, ob das ``item`` in diesem Paket definiert ist; falls nicht,
wird von einem Modul ausgegangen und versucht es zu laden. Wenn nichts gefunden
wird, wird eine :exc:`ImportError`-Ausnahme geworfen.

Im Gegensatz dazu, muss bei Verwendung von ``import item.subitem.subsubitem``
jedes ``item`` ein Paket sein; das letzte ``item`` kann ein Modul oder ein
Paket sein, aber es darf keine Klasse, Funktion oder Variable im darüber
geordneten ``item`` sein.


.. _tut-pkg-import-start:

\* aus einem Paket importieren
------------------------------

.. index:: single: __all__

Was passiert nun, wenn der Benutzer ``from sound.effects import *`` schreibt?
Idealerweise würde man hoffen, dass dies irgendwie an das Dateisystem
weitergereicht wird und alle Untermodule, die es im Paket gibt, findet und sie
alle importiert. Unglücklicherweise funktioniert das nicht besonders gut auf
Windows-Plattformen, bei denen das Dateisystem nicht immer zutreffende
Informationen über die Schreibweise eines Dateinamens hat. Auf diesen
Plattformen gibt es keinen zuverlässigen Weg zu wissen, ob eine Datei
:file:`ECHO.PY` als Modul :mod:`echo`, :mod:`Echo` oder :mod:`ECHO` importiert
werden soll. (Windows 95 hat zum Beispiel die nervige Praxis alle Dateinamen mit
einem groß geschriebenen ersten Buchstaben anzuzeigen.) Die Begrenzung auf DOS
8+3 Dateinamen erzeugt ein weiteres interessantes Problem für lange Modulnamen.

Die einzige Lösung ist, dass der Autor des Paketes einen expliziten Index des
Paketes bereitstellt. Die :keyword:`import`-Anweisung folgt folgender
Konvention: Definiert die Datei :file:`__init__.py` des Paketes eine Liste
namens ``__all__``, wird diese als Liste der Modulnamen behandelt, die bei
``from package import *`` importiert werden sollen. Es ist Aufgabe des
Paketautoren diese Liste aktuell zu halten, wenn er eine neue Version des
Paketes veröffentlicht. Paketautoren können sich auch entscheiden es nicht zu
unterstützen, wenn sie einen \*-Import ihres Paketes für nutzlos halten. Zum
Beispiel könnte die Datei :file:`sound/effects/__init__.py` folgenden Code
enthalten::

    __all__ = ["echo", "surround", "reverse"]

Dies würde bedeuten, dass ``from sound.effects import *`` die drei genannten
Untermodule des :mod:`sound` Paketes importiert.

Ist ``__all__`` nicht definiert, importiert die Anweisung ``from sound.effects
import *`` *nicht* alle Untermodule des Paketes :mod:`sound.effects` in den
aktuellen Namensraum; es stellt nur sicher, dass das Paket :mod:`sound.effects`
importiert wurde (möglicherweise führt es jeglichen Initialisierungscode in
:file:`__init__.py` aus) und importiert dann alle Namen, die im Paket definiert
wurden. Inklusive der Namen, die in :file:`__init__.py` definiert werden (und
Untermodule die explizit geladen werden). Es bindet auch jegliche Untermodule
des Paketes ein, die durch vorherige :keyword:`import`-Anweisungen explizit
geladen wurden. Schau dir mal diesen Code an::

    import sound.effects.echo
    import sound.effects.surround
    from sound.effects import *

Hier werden die Module :mod:`echo` und :mod:`surround` in den aktuellen
Namensraum importiert, da sie im Paket :mod:`sound.effects` definiert sind, wenn
die Anweisung ``from ... import`` ausgeführt wird. (Das funktioniert auch wenn
``__all__`` definiert ist.)

Beachte, dass der ``*``-Import eines Moduls oder Paketes im allgemeinen verpönt
ist, da er oft schlecht lesbaren Code verursacht. Allerdings ist es in Ordnung
ihn im interaktiven Interpreter zu benutzen, um weniger tippen zu müssen und bei
bestimmten Modulen die so entworfen wurden, nur Namen, die einem bestimmten
Namensschema folgen, zu exportieren. 

Aber bedenke, dass an der Benutzung von ``from Package import
specific_submodule`` nichts falsch ist! In der Tat ist es die empfohlene
Schreibweise, es sei denn das importierende Modul benutzt gleichnamige
Untermodule von anderen Paketen.

