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
mehrzeiligen Befehl abzuschließen.

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

Anmerkung: Du siehst vielleicht nicht genau dasselbe Ergebnis;
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

Komplexe Zahlen werden ebenso unterstützt; der imaginäre Anteil wird mit dem Suffix ``j`` oder ``J`` angegeben. Komplexe Zahlen mit einem Realanteil, der von null verschieden ist, werden als ``(real+imagj)`` geschrieben oder können mit der Funktion ``complex(real, imag)`` erzeugt werden.
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

Neben Nummern kann Python auch Strings verändern, die in mehreren Arten
ausgedrückt werden können. Sie können in einfachen oder doppelten
Anführungszeichen eingeschlossen werden::

    >>> 'spam eggs'
    'spam eggs'
    >>> 'doesn\'t'
    "doesn't"
    >>> "doesn't"
    "doesn't"
    >>> '"Yes," he said.'
    '"Yes," he said.'
    >>> "\"Yes,\" he said."
    '"Yes," he said.'
    >>> '"Isn\'t," she said.'
    '"Isn\'t," she said.

Der Interpreter gibt das Ergebnis von Stringoperationen auf die gleiche Weise
aus, wie sie eingegeben werden: Innerhalb von Anführungszeichen und mit
durch Backslashes maskierten Anführungszeichen oder anderen seltsamen Zeichen,
um den präzisen Wert wiederzugeben. Der String wird von doppelten
Anführungszeichen eingeschlossen, wenn er ein einfaches Anführungszeichen, aber
keine doppelten enthält, sonst wird er von einfachen Anführungszeichen
eingeschlossen. Wieder einmal produziert die Funktion :func:`print` eine
lesbarere Ausgabe.

Stringliterale können auf mehrere Arten mehrere Zeilen enthalten.
Fortsetzungszeilen können benutzt werden, die mit einem Backslash am Ende der
Zeile anzeigen, dass die nächste Zeile die logische Fortsetzung der aktuellen
ist::

    hello = "This is a rather long string containing\n\
    several lines of text just as you would do in C.\n\
        Note that whitespace at the beginning of the line is\
    significant."

    print(hello)

Bemerke, dass Zeilenumbrüche immernoch in den String mit Hilfe von ``\n``
eingebettet werden müssen; der auf den Backslash folgende Zeilenumbruch wird
verworfen. Das Beispiel würde folgendes ausgeben::

    This is a rather long string containing
    several lines of text just as you would do in C.
        Note that whitespace at the beginning of the line is significant.

Wenn wir den Stringliteral zu einem "raw"-String machen, werden ``\n``-Sequenzen
nicht zu Zeilenumbrüchen konvertiert, aber sowohl der Backslash am Ende der
Zeile, als auch das Zeilenumbruch-Zeichen im Quellcode sind als Daten im String
vorhanden. Deshalb würde das Beispiel::

    hello = r"This is a rather long string containing\n\
    several lines of text much as you would do in C."

    print(hello)

folgendes anzeigen::

   This is a rather long string containing\n\
   several lines of text much as you would do in C.

Strings können mit dem ``+``-Operator verknüpft (zusammengeklebt) und mit
``*`` wiederholt werden::

    >>> word = 'Help' + 'A'
    >>> word
    'HelpA'
    >>> '<' + word*5 + '>'
    '<HelpAHelpAHelpAHelpAHelpA>'

Zwei Stringliterale nebeneinander werden automatisch miteinander verknüpft; die
erste Zeile im obigen Beispiel hätte also auch ``word = 'Help' 'A'`` lauten
können; das funktioniert nur mit zwei Literalen, nicht mit beliebigen String
Ausdrücken::
    >>> 'str' 'ing'                   #  <-  Das ist ok
    'string'
    >>> 'str'.strip() + 'ing'   #  <-  Das ist ok
    'string'
    >>> 'str'.strip() 'ing'     #  <-  Das ist ungültig
     File "<stdin>", line 1, in ?
       'str'.strip() 'ing'
                         ^
    SyntaxError: invalid syntax

Strings können indiziert werden; wie in C hat das erste Zeichen des Strings den
Index 0. Es gibt keinen getrennten Zeichentyp (wie ``char`` in C); ein Zeichen
ist einfach ein String der Länge eins. Wie in der Programmiersprache Icon können
Teilketten mit der *Slice-Notation* festgelegt werden: Zwei Indices getrennt von
einem Doppelpunkt (``:``).
::

    >>> word[4]
    'A'
    >>> word[0:2]
    'He'
    >>> word[2:4]
    'lp'

Slice-Indices haben nützliche Standardwerte; ein ausgelassener erster Index
fällt zurück auf null, ein ausgelassener zweiter Index fällt zurück auf die die
Länge des Strings der geschnitten wird. ::

    >>> word[:2]    # Die ersten beiden Zeichen
    'He'
    >>> word[2:]    # Alles außer den ersten beiden Zeichen
    'lpA'

Anders als ein C-String, kann ein Python-String nicht verändert werden.
Zuweisungen an eine indizierte Position eines Strings führen zu einem Fehler::

    >>> word[0] = 'x'
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   TypeError: 'str' object does not support item assignment
   >>> word[:1] = 'Splat'
   Traceback (most recent call last):
     File "<stdin>", line 1, in ?
   TypeError: 'str' object does not support slice assignment

Jedoch ist es einfach und effizient einen String mit dem kombinierten Inhalt zu
erzeugen::

    >>> 'x' + word[1:]
    'xelpA'
    >>> 'Splat' + word[4]
    'SplatA'

Hier ist eine nützliche Invariante von Slice-Operationen: ``s[:i] + s[i:]``
entspricht ``s``.
::

    >>> word[:2] + word[2:]
    'HelpA'
    >>> word[:3] + word[3:]
    'HelpA'

Ausgeartete Slice-Indices werden elegant behandelt: Ein zu großer Index wird
durch die Länge des Strings ersetzt, eine Obergrenze, die kleiner ist als die
Untergrenze gibt einen leeren String zurück. ::

    >>> word[1:100]
    'elpA'
    >>> word[10:]
    ''
    >>> word[2:1]
    ''

Indices können auch negative Zahlen sein, um von rechts an zu zählen. Zum
Beispiel::

    >>> word[-1]     # Das letzte Zeichen
    'A'
    >>> word[-2]     # Das vorletzte Zeichen
    'p'
    >>> word[-2:]    # Die letzten zwei Zeichen
    'pA'
    >>> word[:-2]    # Alles außer die letzten beiden Zeichen
    'Hel'

Aber bemerke, dass -0 wirklich dasselbe ist wie 0, es also nicht von rechts zu
zählen beginnt!
::
    >>> word[-0]     # (da -0 gleich 0)
    'H'

Negative Slice-Indices werden gekürzt, aber versuche das nicht bei
einfachen (nicht-Slice) Indices::

    >>> word[-100:]
    'HelpA'
    >>> word[-10]    # Fehler
    Traceback (most recent call last):
     File "<stdin>", line 1, in ?
    IndexError: string index out of range

Ein Weg sich zu merken wie Slices funktionieren ist, sich die Indices so
vorzustellen, als würden sie *zwischen* die Zeichen zeigen, wobei die linke Ecke
des ersten Zeichens die Nummer 0 hat und die rechte Ecke des letzten Zeichens
eines Strings aus *n* Zeichen den Index *n* hat, zum Beispiel::

    +---+---+---+---+---+
    | H | e | l | p | A |
    +---+---+---+---+---+
    0   1   2   3   4   5
   -5  -4  -3  -2  -1

Die erste Reihe von Nummern gibt die Position der Indices 0...5 im String an und
die zweite Reihe die entsprechenden negativen Indices. Der Slice von *i* bis *j*
besteht aus all den Zeichen zwischen den Ecken die von *i* beziehungsweise *j*
gekennzeichnet werden.

Für nicht-negative Indices ist die Länge des Slices die Differenz der Indices,
sofern beide innerhalb der Schranken sind. Zum Beispiel ist die Länge von
``word[1:3]`` 2.

Die eingebaute Funktion :func:`len` gibt die Länge eines Strings zurück::

    >>> s = 'supercalifragilisticexpialidocious'
    >>> len(s)
    34


.. seealso::

    :ref:`typesseq`
        Strings sind Exemplare von *Sequenztypen* und unterstützen die
        normalen Operationen die von solchen Typen unterstützt werden.

    :ref:`string-methods`
        Strings halten eine große Zahl von Methoden für fundamentale
        Transformationen und Suche bereit.

    :ref:`string-formatting`
        Informationen über Stringformatierung mit :meth:`str.format` sind hier
        zu finden.

    :ref:`old-string-formatting`
        Die alten Formatierungsoperationen, die aufgerufen werden, wenn Strings
        und Unicodestrings die linken Operanden des ``%``-Operators sind, werden
        hier in detailliert beschrieben.


.. _tut-unicodestrings:

Über Unicode
------------

Beginnend mit Python 3.0 unterstützen alle Strings Unicode (siehe
http://www.unicode.org/)

Unicode hat den Vorteil, dass es eine Ordnungszahl für jedes Zeichen in jedem
Schriftstück, das in modernen und antiken Texten benutzt wird, bereitstellt.
Davor waren nur 256 Ordnungszahlen für Schriftzeichen möglich. Texte waren
typischerweise an eine Codepage gebunden, die die Ordnungszahlen den
Schriftzeichen zugeordnet hat. Das führte zu großer Verwirrung, vor allem im
Hinblick auf Internationalisierung (üblicherweise ``i18n`` --- ``'i'`` + 18
Zeichen + ``'n'``) von Software. Unicode löst diese Probleme, indem es eine
Codepage für alle Schriftstücke definiert.

Wenn man spezielle Zeichen in einen String einbinden will, kann man das über die
Benutzung von Pythons *Unicode-Escape* Kodierung bewerkstelligen. Das folgende
Beispiel zeigt wie::

    >>> 'Hello\u0020World !'
    'Hello World !'

Die Escapesequenz ``\u0020`` gibt an, dass das Unicodezeichen mit der
Ordnungszahl 0x0020 (das Leerzeichen) an der gegebenen Position eingefügt werden
soll.


Andere Zeichen werden interpretiert, indem ihre jeweiligen Ordnungszahlen direkt
als Unicode-Ordnungszahlen benutzt werden. Hat man Stringliterale in der
normalen Latin-1 Kodierung, die in vielen westlichen Ländern benutzt wird,
empfindet man es als angenehmen, dass die ersten 256 Zeichen von Unicode, die
selben Zeichen wie die 256 Latin-1 Zeichen sind.

Neben diesen Standardkodierungen stellt Python eine ganze Reihe anderer
Möglichkeiten bereit, Unicodestrings zu erstellen, sofern man die benutzte
Kodierung kennt.

Um einen String zu einer Bytesequenz zu konvertieren, stellen Stringobjekte die
Methode :func:`encode` bereit, die ein Argument entgegennimmt: Den Namen der
Kodierung. Kleingeschriebene Namen werden für Kodierungen bevorzugt. ::

    >>> "Ã„pfel".encode('utf-8')
    b'\xc3\x84pfel'

.. _tut-lists:

Listen
------

Python kennt viele zusammengesetzte Datentypen (*compound data types*), die dazu
benutzt werden können verschiedene Werte zu gruppieren. Die flexibelste davon
ist die Liste (*list*), die als eine Liste von Werten (Elemente), die durch
Kommas getrennt und von eckigen Klammern eingeschlossen werden. Listenelemente
müssen nicht alle denselben Typ haben. ::

    >>> a = ['spam', 'eggs', 100, 1234]
    >>> a
    ['spam', 'eggs', 100, 1234]

Genauso wie Stringindices starten Listenindices bei 0, genauso können Listen
gescliced, verbunden usw. werden::

    >>> a[0]
    'spam'
    >>> a[3]
    1234
    >>> a[-2]
    100
    >>> a[1:-1]
    ['eggs', 100]
    >>> a[:2] + ['bacon', 2*2]
    ['spam', 'eggs', 'bacon', 4]
    >>> 3*a[:3] + ['Boo!']
    ['spam', 'eggs', 100, 'spam', 'eggs', 100, 'spam', 'eggs', 100, 'Boo!']

Anders als Strings, die *unveränderbar* (*immutable*) sind, ist es möglich
einzelne Listenelemente zu verändern::

    >>> a
    ['spam', 'eggs', 100, 1234]
    >>> a[2] = a[2] + 23
    >>> a
    ['spam', 'eggs', 123, 1234]

Zuweisungen zu Slices sind ebenso möglich, was sogar die Länge der Liste
verändern oder sogar ganz leeren kann::

    >>> # Ein paar Elemente ersetzen:
    ... a[0:2] = [1, 12]
    >>> a
    [1, 12, 123, 1234]
    >>> # Ein paar entfernen:
    ... a[0:2] = []
    >>> a
    [123, 1234]
    >>> # Ein paar einfügen:
    ... a[1:1] = ['bletch', 'xyzzy']
    >>> a
    [123, 'bletch', 'xyzzy', 1234]
    >>> # (Eine Kopie von) sich selbst am Anfang einfügen:
    >>> a[:0] = a
    >>> a
    [123, 'bletch', 'xyzzy', 1234, 123, 'bletch', 'xyzzy', 1234]
    >>> # Die Liste leeren: Alle Elemente mit einer leeren Liste  ersetzen
    >>> a[:] = []
    >>> a
    []

Die eingebaute Funktion :func:`len` lässt sich auch auf Listen anwenden::

    >>> a = ['a', 'b', 'c', 'd']
    >>> len(a)
    4

Es ist möglich Listen zu verschalten (*nest*) (Listen zu erzeugen, die andere Listen
enthalten), zum Beispiel::

    >>> q = [2, 3]
    >>> p = [1, q, 4]
    >>> len(p)
    3
    >>> p[1]
    [2, 3]
    >>> p[1][0]
    2

Man kann etwas ans Ende der Liste hängen::

    >>> p[1].append('xtra')
    >>> p
    [1, [2, 3, 'xtra'], 4]
    >>> q
    [2, 3, 'xtra']

Bemerke, dass im letzten Beispiel ``p[1]`` ``q`` wirklich auf dasselbe Objekt
zeigen! Wir kommen später zur *Objektsemantik* zurück.

.. _tut-firststeps:

Erste Schritte zur Programmierung
=================================

Natürlich können wir Python für kompliziere Aufgaben verwenden, als nur zwei und
zwei zusammen zu addieren. Beispielsweise können wir die anfängliche Teilfolge
der *Fibonacci-Folge* folgendermaßen schreiben::

    >>> # Fibonacci-Folge:
    ... # Die Summe zweier Elemente ergibt das nächste
    ... a, b = 0, 1
    >>> while b < 10:
    ...     print(b)
    ...     a, b = b, a+b
    ...
    1
    1
    2
    3
    5
    8

Dieses Beispiel stellt ein paar neue Eigenschaften vor.

* Die erste Zeile enthält eine *Mehrfachzuweisung* (*multiple assignment*): Die
Variablen ``a`` und ``b`` bekommen gleichzeitig die neuen Werte 0 und 1. In der
letzten Zeile wird sie erneut genutzt, um zu zeigen, dass die zuerst alle
Ausdrücke auf der rechten Seite ausgewertet werden, bevor
irgendeine Zuweisung passiert. Die Ausdrücke auf der rechten Seite werden von
links nach rechts ausgewertet.

* Die :keyword:`while` Schleife wird solange ausgeführt, wie die Bedingung
(hier: ``b < 10``) wahr bleibt. In Python, wie in C, ist jede von null
verschiedene Zahl wahr (*true*); null ist unwahr (*false*). Die Bedingung kann
auch ein String- oder Listenwert sein, eigentlich sogar jede Sequenz; alles mit
einer von null verschiedenen Länge ist wahr, leere Sequenzen sind unwahr. Der
Test im Beispiel ist ein einfacher Vergleich. Die normalen Vergleichsoperatoren
werden wie in C geschrieben: ``<`` (kleiner als), ``>`` (größer als), ``==``
(gleich), ``<=`` (kleiner oder gleich), ``>=`` (größer oder gleich) und ``!=``
(ungleich).

* Der *Körper* der Schleife ist *eingerückt* (*indented*): Einrückung ist
Pythons Art Anweisungen zu gruppieren. Python unterstützt (noch!) keine
intelligente Zeilenbearbeitungshilfe, deshalb muss man selbst für jede
eingerückte Zeile ein Tab oder Leerzeichen eingeben. In der Praxis bereitet man
kompliziertere Eingaben in einem Texteditor vor; die meisten Texteditoren haben
eine Hilfe, die automatisch einrückt. Wird eine zusammengesetzte Anweisung
(*compound statement*) interaktiv eingegegeben, muss eine Leerzeile darauf
folgen, um anzuzeigen, dass sie abgeschlossen ist (da der Interpreter nicht
erahnen kann, wann man die letzte Zeile eingegeben hat). Bemerke, dass jede
Zeile innerhalb eines Hauptblockes um den selben Betrag eingerückt sein muss.

* Die Funktion :func:`print` gibt den Wert des Ausdrucks aus, der ihr übergeben
wurde. Die Ausgabe unterscheidet sich von der Ausgabe, die auftritt, wenn man
die Ausdrücke einfach so eingibt (wie wir es vorher in den Rechner Beispielen
gemacht haben), in der Art, wie sie Mehrfachausdrücke, Fliesskommazahlen und
Strings behandelt. Strings werden ohne Anführungszeichen ausgegeben und ein
Leerzeichen wird zwischen den einzelnen Elementen eingefügt, sodass man sie
einfach formatieren kann, so wie folgt::

    >>> i = 256*256
    >>> print('The value of i is', i)
    The value of i is 65536

Das Schlüsselwortargument *end* kann dazu benutzt werden den Zeilenumbruch nach
der Ausgabe zu verhindern oder die Ausgabe mit einem anderen String zu beenden::

    >>> a, b = 0, 1
    >>> while b < 1000:
    ...     print(b, end=' ')
    ...     a, b = b, a+b
    ...
    1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987

