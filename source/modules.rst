.. _tut-modules:

******
Module
******

Wenn man den Python-Interpreter beendet und erneut startest, gehen alle
vorgenommenen Definitionen (Funktionen und Variablen) verloren. Deshalb
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
	
Dieser Befehl fügt die, von :file:`fibo.py` definierten, Funktionen
nicht automatisch in die globale Symboltabelle ein, sondern nur den Modulnamen ``fibo``
ein. Um die Funktionen anzusprechen, benutzt man den Modulnamen::

	>>> fibo.fib(1000)
	1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987
	>>> fibo.fib2(100)
	[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
	>>> fibo.__name__
	'fibo'
	
Wenn man plant eine Funktion öfter zu verwenden, kann man diese an einen
lokalen Namen binden.
