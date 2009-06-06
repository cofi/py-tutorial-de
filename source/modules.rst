.. _tut-modules:

******
Module
******

Wenn man den Python-Interpreter beendet und erneut startest, gehen alle
vorgenommenen Definitionen (Funktionen und Variablen) verloren. Deshalb
Wenn du den Python-Interpreter beendest und erneut startest, gehen alle
Definitionen (Funktionen und Variablen), die du gemacht hast, verloren. Deshalb
benutzt man vorzugsweise einen Text-Editor, um längere und komplexere Programme
zu schreiben und verwendet eine Datei als Input für den Interpreter. Diese Datei
wird auch als Skript bezeichnet. Wird ein Programm länger, teilt man es
besser in mehrere Dateien auf, um es leichter warten zu können. Außerdem ist es
von Vorteil, nützliche Funktion in mehreren Programmen verwenden zu können, ohne
sie in jedem Programm erneut definieren zu müssen.

Hierfür bietet Python die Möglichkeit etwas in einer Datei zu definieren und
diese in einer anderen Datei oder in der interaktiven Konsole wieder zu
verwenden. So eine Datei wird als *Modul* bezeichnet. Definitionen eines Moduls
können in anderen Modulen oder in das *Hauptmodul* *importiert* werden 
.. FIXME: der folgende Satz ist komplett unverständlich
(die Gesamtheit aller Variablen, auf die man in einem Skript zugreifen kann).

Ein Modul ist eine Datei, die Python-Definitionen und -Anweisungen beinhaltet.
Der Dateiname mit dem :file:`.py` Suffix entspricht dem Namen des Moduls.
Innerhalb eines Moduls, ist der Modulname als ``__name__`` verfügbar (globale
Variable des Typs ``string``). Zum Beispiel: Öffne einen Editor deiner Wahl und
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
	
Dieser Befehl fügt die, von :file:`fibo.py` definierten, Funktionen nicht
automatisch in die globale Symboltabelle ein, sondern nur den Modulnamen
``fibo``. Um die Funktionen anzusprechen, benutzt man den Modulnamen::

	>>> fibo.fib(1000)
	1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987
	>>> fibo.fib2(100)
	[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
	>>> fibo.__name__
	'fibo'
	
Wenn man plant eine Funktion öfter zu verwenden, kann man diese an einen
lokalen Namen binden.

	>>> fib = fibo.fib
	>>> fib(500)
	1 1 2 3 5 8 13 21 34 55 89 144 233 377

Mehr zum Thema Module
=====================

Ein Modul kann sowohl ausführbare Statements als auch Definitionen einer
Funktion enthalten. Diese Statements sind dazu gedacht, das Modul zu
initialisieren, und werden nur ausgeführt, wenn das Modul zum ersten Mal
importiert wird.

Jedes Modul hat seine eigene, private Symbol-Tabelle, welche wiederum als
globale Symbol-Tabelle von allen Funktion in diesem Modul verwendet wird. Daher
kann der Verfasser eines Moduls ohne Bedenken globale Variablen in seinem Modul
verwenden, da sie sich nicht mit den globalen Variablen des Benutzers
überschneiden können. Andererseits kann man (wenn man weißt, was man tut) auch
die globalen Variablen eines Moduls verändern, indem man die gleiche
Schreibweise verwendet, um auch dessen Funktionen anzusprechen,
``modname.itemname``.

Module können andere Module importieren. Es ist gebräuchlich, aber nicht
zwingend, dass man alle :keyword:`import` Statements an den Anfangs eines Moduls
setzt (oder in diesem Fall Skript). Die Namen der importierten Module werden in die Symbol-Tabelle des importierenden Moduls eingefügt.

Es gibt eine Variante des :keyword:`import` Statements, welche bestimme Namen
aus einem Modul direkt in die Symbol-Tabelle des importierenden Moduls einfügt.
Beispielsweise::

	>>> from fibo import fib, fib2
	>>> fib(500)
	1 1 2 3 5 8 13 21 34 55 89 144 233 377
	
Diese Variante fügt allerdings nicht den Modulnamen, aus dem die Namen
importiert werden, in die lokale Symbol-Tabelle ein (in diesem Beispiel wird
``fibo`` als nicht eingefügt).

Zusätzlich gibt es eine Variante um alle Namen in einem Modul zu importieren:

	>>> from fibo import *
	>>> fib(500)
	1 1 2 3 5 8 13 21 34 55 89 144 233 37
	
Hiermit werden alle Namen außer diejenigen, die mit einem Unterstrich beginnen
(_), importiert. In den meisten Fällen wird diese Variante nicht verwendet.
Dadurch werden unbekannte Namen in den Interpreter importiert und damit kann es
vorkommen, dass einige Namen überschrieben werden, die bereits definiert worden
sind.

.. note::

	Aus Effizientsgründen wird jedes Modul nur einmal durch eine Interpreter
	Session importiert. Deshalb muss man den Interpreter bei Änderung der Module
	neustarten - oder man benutzt :func:`reload`, beispielsweise
	``reload(modulename)``, falls es nur ein Modul ist, welches man interaktiv
	testen will.
	
