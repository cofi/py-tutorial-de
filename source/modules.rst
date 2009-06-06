.. _tut-modules:

*******
Modules
*******

Wenn du den Python-Interpreter beendest und erneut startest, gehen alle
Definitionen (Funktionen und Variablen), die du gemacht hast, verloren. Deshalb
benutzt man vorzugsweise einen Text-Editor, um längere und komplexere Programme
zu schreiben und verwendet eine Datei als Input für den Interpreter. Diese Datei
wird auch als Skript bezeichnet. Sobald ein Programm länger wird, teilt man es
besser in mehrere Dateien auf, um es leichter warten zu können. Außerdem ist es
von Vorteil, wenn man eine praktische Funktion in mehreren Programmen verwenden
kann ohne diese in jedem Programm erneut definieren zu müssen.

Hierfür bietet Python die Möglichkeit etwas in einer Datei zu definieren und
selbiges in einer anderen Datei oder in der Interaktiven Konsole wieder zu
verwenden. So eine Datei wird als *Modul* bezeichnet; Definitionen eines Moduls
können aus anderen Modulen oder aus dem *Hauptmodul* *importiert* werden (die
Gesamtheit aller Variablen, auf die man in einem Skript zugreifen kann).

Ein Modul ist eine Datei, die Python Definitionen und Statements beinhaltet. Der
Dateiname mit dem :file:`.py` Suffix entspricht dem Namen des Moduls. Innerhalb
eines Moduls, ist der Modulname als ``__name__`` verfügbar (globale Variable als
string). Als Beispiel öffnest du einen Editor deiner Wahl und erstellst eine
Datei im aktuellen Verzeichnis mit dem Namen :file:`fibo.py` und dem folgenden
Inhalt::

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
	
Jetzt öffne deinen Python-Interpreter und importiere das Modul mit folgendem
Befehl::

	>>> import fibo
	
Dieser Befehl fügt die Funktionen, welche in der Datei fibo.py definiert sind,
nicht automatisch in die Symbol-Tabelle ein; dort wird nur der Modulname fibo
eingefügt. Um diese Funktionen anzusprechen, benutzt man den Modulnamen:: 

	>>> fibo.fib(1000)
	1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987
	>>> fibo.fib2(100)
	[1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
	>>> fibo.__name__
	'fibo'
	
Wenn man vorhat eine Funktion öfter zu verwenden, kann man diese an einen
lokalen Namen binden.