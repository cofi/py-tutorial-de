.. _tut-informal:

************************************
Eine informelle Einführung in Python
************************************

In den folgenden Beispielen werden Ein- und Ausgabe durch Vorhandensein
beziehungsweise Abwesenheit von Eingabeaufforderungen (``>>>`` und ``...``)
gekennzeichnet. Um die Beispiele zu wiederholen musst du alles auf die
Eingabeaufforderung folgende abtippen, wenn die Eingabeaufforderung erscheint.
Zeilen die nicht mit einer Eingabeaufforderung anfangen, sind Ausgabe des
Interpreters. Bemerke, dass die sekundäre Eingabeaufforderung auf einer eigenen
Zeile bedeutet, dass du eine Leerzeile tippen musst. Dies wird benutzt um einen
mehrzeiligen Befehl abzuschliessen.

Viele der Beispiele in diesem Handbuch, sogar die, die im interaktiven Modus
eingegeben werden, enthalten Kommentare. Kommentare beginnen in Python mit einem
Rautenzeichen ``#`` und erstrecken sich bis an das Ende der physischen Zeile.
Ein Kommentar kann am Beginn einer Zeile oder auf ein Leerzeichen oder Code
folgen stehen, nicht jedoch innerhalb eines Stringliterals. Ein Rautenzeichen
innerhalb eines Stringliterals ist nur ein Rautenzeichen. Da Kommentare dazu
dienen Code zu erklären und von Python nicht interpretiert werden, können sie
beim Abtippen weggelassen werden.

Ein paar Beispiele::

    #Das ist der erste Kommentar
    SPAM = 1                    # und dies ist der zweite Kommentar
                                # ... und jetzt ein dritter!
    STRING = "# Dies ist kein Kommentar."


.. _tut-calculator:

Benutzung von Python als Taschenrechner
=======================================

Lasst uns ein paar einfache Pythonbefehle ausprobieren. Starte den Interpreter
und warte auf die primäre Eingabeaufforderung, ``>>>``. (Es sollte nicht lange
dauern.)


.. _tut-numbers:

Nummern
-------

Der Interpreter arbeitet als ein einfacher Taschenrechner: Du kannst einen
Ausdruck eingeben und er wird das Ergebnis ausgeben. Die Ausdruckssyntax ist
einfach: Die Operatoren ``+``,  ``-``, ``*`` und ``/`` wirken genauso wie in den
meisten anderen Sprachen (beispielsweise Pascal oder C); Klammern können zur
Gruppierung benutzt werden. Zum Beispiel::

    >>> 2+2
    4
    >>> # Dies ist ein Kommentar
    ... 2+2
    4
    >>> 2+2  # und dies ist ein Kommentar auf der selben Zeile wie Code
    4
    >>> (50-5*6)/4
    5.0
    >>> 8/5 # Brüche gehen nicht verloren, wenn man Ganzzahlen teilen
    1.6000000000000001

Anmerkung: Du siehst vielleicht nicht genau das selbe Ergebnis;
Fliesskommazahlen Ergebnisse können sich von  Maschine zu Maschine
unterscheiden. Später gehen wir näher auf die Kontrolle des Aussehens bei der
Ausgabe von Fliesskommazahlen ein; was wir hier sehen ist die informativste
Ausgabe, die aber nicht so einfach zu lesen ist wie die, die wir mit folgendem
bekämen::

    >>> print(8/5)
    1.6

Der Übersichtlichkeit wegen, werden wir in diesem Tutorial die einfachere
Ausgabe von Fliesskommazahlen zeigen, sofern wir nicht ausdrücklich die
Ausgabeformatierung besprechen. Später werden wir erklären, wie es zu diesen
zwei Arten der Ausgabe von Fliesskommadaten kommt und warum sie unterschiedlich
sind. Siehe :ref:`tut-fp-issues` für die volle Besprechung.

Um eine Ganzzahldivision auszuführen bei der man ein ganzzahliges Ergebnis
bekommt und den Bruchteil des Ergebnisses verwirft, gibt es einen anderen
Operator, ``//``::

    >>> # Ganzzahldivision gibt ein abgerundetes Ergebnis zurück:
    ... 7//3
    2
    >>> 7//-3
    -3

Das Gleichheitszeichen (``'='``) wird benutzt um einer Variable einen Wert
zuzuweisen. Danach wird kein Ergebnis vor der nächsten interaktiven
Eingabeaufforderung angezeigt::

    >>> width = 20
    >>> height = 5*9
    >>> width * height
    900

Ein Wert kann mehreren Variablen gleichzeitig zugewiesen werden::

    >>> x = y = z = 0  # Null für x, y und z
    >>> x
    0
    >>> y
    0
    >>> z
    0

Variablen müssen "definiert" (einen Wert zugewiesen haben) sein, bevor sie
benutzt werden können, sonst tritt ein Fehler auf::

    >>> # Versuche eine undefinierte Variable abzurufen
    ... n
    Traceback (most recent call last):
     File "<stdin>", line 1, in <module>
    NameError: name 'n' is not defined

Es gibt volle Unterstützung für Fliesskommazahlen; Operatoren mit
verschiedenartigen Operanden, konvertieren den Ganzzahloperanden in
Fliesskommazahlen::

    >>> 3 * 3.75 / 1.5
    7.5
    >>> 7.0 / 2
    3.5

Komplexe Zahlen werden ebenso unterstützt; der imaginäre Anteil wird mit dem Suffix ``j`` oder ``J`` angegeben. Komplexe Zahlen mit einem Realanteil, der von null verschieden ist, werden als ``(real+imagj)`` geschrieben oder können mit der ``complex(real, imag)`` Funktion erzeugt werden.
::

    >>> 1j * 1J
    (-1+0j)
    >>> 1j * complex(0, 1)
    (-1+0j)
    >>> 3+1j*3
    (3+3j)
    >>> (3+1j)*3
    (9+3j)
    >>> (1+2j)/(1+1j)
    (1.5+0.5j)

Komplexe Zahlen werden immer als zwei Fliesskommazahlen repräsentiert: Der
reale und der imaginäre Anteil. Um diese Anteile einer komplexen Zahl *z*
auszuwählen stehen ``z.real`` und ``z.imag`` zur Verfügung. ::

    >>> a=1.5+0.5j
    >>> a.real
    1.5
    >>> a.imag
    0.5

Die Konvertierungsfunktionen zu Fliesskommazahlen und Ganzzahlen
(:func:`float`, :func:`int`) stehen für komplexe Zahlen nicht zur Verfügung ---
es gibt keinen korrekten Weg eine komplexe Zahl in eine Realzahl zu
konvertieren. Benutze ``abs(z)``, um deren Größe (als eine Fliesskommazahl) oder ``z.real``, um deren realen Anteil zu bekommen::

    >>> a=3.0+4.0j
    >>> float(a)
    Traceback (most recent call last):
     File "<stdin>", line 1, in ?
    TypeError: can't convert complex to float; use abs(z)
    >>> a.real
    3.0
    >>> a.imag
    4.0
    >>> abs(a)  # sqrt(a.real**2 + a.imag**2)
    5.0
    >>>

Im interaktiven Modus wird der zuletzt ausgegebene Ausdruck der Variable ``_`` zugewiesen. Das bedeutet, dass man, wenn man Python als Tischrechner benutzt, ist es etwas einfacher Berechnungen fortzusetzen, zum Beispiel::

    >>> tax = 12.5 / 100
    >>> price = 100.50
    >>> price * tax
    12.5625
    >>> price + _
    113.0625
    >>> round(_, 2)
    113.06
    >>>

Diese Variable sollte vom Benutzer als schreibgeschützt behandelt werden. Weise
ihr nicht explizit einen Wert zu --- du würdest eine unabhängige lokale
Variable mit dem selben Namen erzeugen, die die eingebaute Variable mit seinem
magischen Verhalten verdeckt.

.. _tut-strings:

Strings
-------


