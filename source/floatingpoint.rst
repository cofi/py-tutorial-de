.. _tut-fp-issues:

*****************************************************
Fließkomma-Arithmetik:  Probleme und Einschränkungen
*****************************************************

.. sectionauthor:: Tim Peters <tim_one@users.sourceforge.net>


Fließkommazahlen werden in der Hardware des Computers als Brüche mit der 
Basis 2 (binär) dargestellt.  Beispielsweise hat folgende Dezimalzahl ::

   0.125

den Wert 1/10 + 2/100 + 5/1000; die entsprechende Binärzahl ::

   0.001

hat den Wert 0/2 + 0/4 + 1/8.  Diese beiden Brüche haben einen identischen 
Wert, der einzige wirkliche Unterschied ist, dass der erste als Bruch zur
Basis 10 und der zweite als Bruch zur Basis 2 geschrieben wurde.

Leider können die meisten Dezimalbrüche nicht exakt als Binärbruch
dargestellt werden.  Eine Konsequenz daraus ist, dass im Allgemeinen die
als dezimale Fließkommazahlen eingegebenen Werte nur durch die binären 
Fließkommazahlen angenähert werden können, die eigentlich von dem Computer
gespeichert werden.

Das Problem ist zunächst einfacher im Dezimalsystem zu verstehen.  Nehmen wir
beispielsweise den Bruch 1/3.  Man kann ihn in Dezimaldarstellung 
folgendermaßen annähern ::

   0.3

oder, besser, ::

   0.33

oder, besser, ::

   0.333

und so weiter.  Egal wie viele Stellen man schreibt, dass Resultat wird niemals
exakt 1/3, aber es wird sich stetig 1/3 annähern.

Äquivalent kann, egal wie viele Stellen mit der Basis 2 man verwendet, die
Dezimalzahl 0.1 niemals exakt als Binärbruch dargestellt werden.  Im Binärsystem
ist 1/10 die periodische Binärzahl::

   0.0001100110011001100110011001100110011001100110011...

Hält man nach einer endlichen Zahl Bits an, erhält man eine Annäherung.  In den
meisten Rechnern werden heute Fließkommazahlen als Binärbrüche, mit dem Zähler in
den ersten 53 Bits, gefolgt von dem Nenner als Potenz von Zwei, dargestellt.
Im Fall von 1/10 lautet der Binärbruch ``3602879701896397 / 2 ** 55``, was in
etwa, aber nicht exakt, dem echten Wert von 1/10 entspricht.

Viele Benutzer sind sich durch die angezeigten Werte der Problematik nicht
bewusst.  Python zeigt nur eine dezimale Annäherung an den echten Dezimalwert
an, der im Rechner gespeichert wird.  Wenn Python den echten Dezimalwert zur
gespeicherten binären Annäherung an 0,1 anzeigen würde, müsste es folgendes
anzeigen ::

   >>> 0.1
   0.1000000000000000055511151231257827021181583404541015625

Das sind mehr Stellen als den meisten Leuten lieb ist, deshalb hält Python die
Anzahl der Stellen überschaubar indem es stattdessen einen gerundeten Wert 
anzeigt ::

   >>> 1 / 10
   0.1

Zur Erinnerung - auch wenn der angezeigte Wert wie der exakte Wert von 1/10
aussieht, ist der eigentlich gespeicherte Wert der naheste Binärbruch.

Interessanterweise gibt es viele verschiedene Dezimalzahlen welche die selbe
beste Approximation durch einen Binärbruch haben.  Beispielsweise werden 
``0.1`` und
``0.10000000000000001`` und
``0.1000000000000000055511151231257827021181583404541015625`` alle mit
``3602879701896397 / 2 ** 55`` angenähert.  Da all diese Dezimalwerte die
selbe Approximation haben, könnte jeder von ihnen angezeigt werden und
immer noch die Bedingung ``eval(repr(x)) == x`` erfüllen.

In der Vergangenheit wählten der Python-Prompt und die eingebaute Funktion
:func:`repr` diejenige mit 17 signifikanten Stellen: ``0.10000000000000001``,
seit Python 3.1 ist Python (auf den meisten Systemen) fähig, die kürzeste
Darstellung zu wählen und einfach ``0.1`` anzuzeigen.

Das Verhalten liegt in der Natur der Fließkommadarstellung im Binärsystem:
es ist kein Fehler in Python und auch kein Fehler in deiner Software. Man sieht
dieses Problem in allen Sprachen, die die Fließkomma-Darstellung der Hardware
unterstützen (obwohl manche Sprachen den Unterschied nicht standardmäßig oder
in allen Anzeigemodi *anzeigen*).

Pythons eingebaute Funktion :func:`str` erzeugt nur 12 signifikante Stellen
Es ist selten, dass ``eval(str(x))`` den Wert *x* erzeugt, aber die Ausgabe 
sieht unter Umständen besser aus::

   >>> str(math.pi)
   '3.14159265359'

   >>> repr(math.pi)
   '3.141592653589793'

   >>> format(math.pi, '.2f')
   '3.14'

Es ist wichtig sich zu verinnerlichen, dass dies in Wahrheit eine Illusion
ist - man rundet einfach die *Darstellung* des echten Maschinenwertes.

Diese Illusion erzeugt unter Umständen eine weitere. Da beispielsweise 0.1
nicht exakt 1/10 ist, ist die Summe von dreimal 0.1 nicht exakt 0.3::

   >>> .1 + .1 + .1 == .3
   False

Da 0.1 außerdem nicht näher an den exakten Wert von 1/10 und 0.3 heranreichen
kann hilft auch vorheriges Runden mit :func:`round` nichts::

   >>> round(.1, 1) + round(.1, 1) + round(.1, 1) == round(.3, 1)
   False

Obwohl die Zahlen nicht besser an ihren gedachten exakten Wert angenähert
werden können, kann die Funktion :func:`round` nützlich für das nachträgliche
Runden, so das die ungenauen Ergebnisse vergleichbar zueinander werden::

    >>> round(.1 + .1 + .1, 1) == round(.3, 1)
    True

Binäre Fließkommaarithmetik sorgt noch für einige Überraschungen wie diese.  Das
Problem mit "0.1" ist im Abschnitt "Darstellungsfehler" weiter unten detailliert
beschrieben. Dazu sei auf `The Perils of Floating Point
<http://www.lahey.com/float.htm>`_ für eine umfassendere Liste von üblichen
Problemen verwiesen.

Wie schon dort gegen Ende des Textes gesagt wird: "Es gibt keine einfachen
Antworten." Trotzdem sollte man nicht zögerlich bei dem Einsatz von
Fließkommazahlen sein!  Die Fehler in Python-Fließkommaoperationen sind
Folgefehler der Fließkomma-Hardware und liegt auf den meisten Maschinen in einem
Bereich der geringer als 1 zu 2\*\*53 pro Operation ist.  Das ist mehr als
ausreichend für die meisten Anwendungen, aber man muss sich in Erinnerung halten
das es sich nicht um Dezimal-Arithmetik handelt und dass jede Operation mit
einer Fließkommazahl einen neuen Rundungsfehler enthalten kann.

Von einigen pathologischen Fällen abgesehen, erhält man in den meisten
existierenden Fällen, für die gängigsten Anwendungen von Fließkommazahlen das
erwartete Ergebnis, wenn man einfach die Anzeige des Ergebnisses auf die Zahl
der Dezimalstellen rundet, die man erwartet. :func:`str` genügt meist, für eine
feinere Kontrolle kann man sich :meth:`str.format` mit den Formatierungsoptionen
in :lib:`Format String Syntax <string.html#formatstrings>` anschauen.

Für Anwendungsfälle, die eine exakte dezimale Darstellung benötigen, kann das
Modul :mod:`decimal` verwendet werden, welches Dezimalarithmetik implementiert,
die für Buchhaltung und Anwendungen, die eine hohe Präzision erfordern, geeignet
ist.

Eine andere Form exakter Arithmetik wird von dem Modul :mod:`fractions`
bereitgestellt, welche eine Arithmetik implementiert die auf rationalen Zahlen
basiert (so dass Zahlen wie 1/3 exakt abgebildet werden können).

Wenn man im größeren Umfang mit Fließkommazahlen zu tun hat, sollte man einen
Blick auf Numerical Python und die vielen weitere Pakete für mathematische und
statistische Operationen die vom `SciPy-Projekt <http://scipy.org>`_
bereitgestellt werden anschauen.

Python verfügt außerdem über ein Werkzeug für die seltenen Fälle, in
denen man *wirklich* den exakten Wert des floats wissen will. Die Methode
:meth:`float.as_integer_ratio` gibt den Wert der Fließkommazahl als Bruch zurück::

   >>> x = 3.14159
   >>> x.as_integer_ratio()
   (3537115888337719L, 1125899906842624L)

Da dieser Bruch exakt ist, kann er benutzt werden, um ohne Verluste den
originalen Wert wiederherzustellen::

    >>> x == 3537115888337719 / 1125899906842624
    True

Die Metode :meth:`float.hex` stellt die Fließkommazahl hexadezimal (Basis 16) dar
und gibt ebenfalls den exakten im Rechner gespeicherten Wert zuück::

   >>> x.hex()
   '0x1.921f9f01b866ep+1'

Diese präzise hexadezimale Darstellung kann benutzt werden um den originalen
Wert exakt wiederherzustellen::

    >>> x == float.fromhex('0x1.921f9f01b866ep+1')
    True

Da diese Darstellung exakt ist, kann sie genutzt werden um Daten zwischen
verschiedenen Versionen von Python (plattformunabhängig) und zwischen
verschiedenen anderen Sprachen, die dieses Format unterstützen
(wie z.B. Java und C99), auszutauschen.

Ein weiteres hilfreiches Werkzeug ist die Funktion :func:`math.fsum`, welche
den Genauigkeitsverlust beim Summieren verringert.  Sie registriert die
"verlorenen Ziffern" als Werte, die zu einer Summe addiert werden.  Dies kann
die Gesamtgenauigkeit dahingehend beeinflussen, dass die Fehler sich nicht
zu einer Größe summieren, die das Endergebnis beeinflusst:

   >>> sum([0.1] * 10) == 1.0
   False
   >>> math.fsum([0.1] * 10) == 1.0
   True

.. _tut-fp-error:

Darstellungsfehler
==================

Dieser Abschnitt erklärt das "0.1" Beispiel im Detail und zeigt wie man 
selbstständig eine exakte Analyse dieser Fälle durchführen kann.  Ein
grundlegendes Verständnis der binären Fließkomma-Darstellung wird
vorausgesetzt.

Der Begriff :dfn:`Darstellungsfehler` verweist auf den Umstand das manche
(die meisten sogar) Dezimalbrüche nicht exakt als Binärbrüche (Basis 2)
dargestellt werden können. Dies ist der Hauptgrund warum Python (oder Perl,
C, C++, Java, Fortran, und viele andere) oft nicht das erwartete Ergebnis
anzeigen.

Warum ist das so?  1/10 ist nicht exakt als Binärbruch darstellbar. Fast alle
heutigen Rechner (November 2000) benutzen die IEEE-754 Fließkommaarithmetik
und wie fast alle Plattformen, bildet Python floats als IEEE-754 "double precision"
ab.  IEEE-754 doubles sind auf 53 Bits genau, so dass sich der Computer bemüht, 0.1
mit einem Bruch der Form *J*/2**\ *N* bestmöglich anzunähern, wobei *J* eine
53 Bit breite Ganzzahl ist. Schreibt man::

   1 / 10 ~= J / (2**N)

als ::

   J ~= 2**N / 10

und erinnert sich daran das *J* genau 53 Bit breit ist
(d. h. ``>= 2**52`` und ``< 2**53``), ergibt sich als bester Wert für *N* 56::

   >>> 2**52
   4503599627370496
   >>> 2**53
   9007199254740992
   >>> 2**56/10
   7205759403792794.0

Das heißt, 56 ist der einzige Wert für *N*, wenn *J* auf 53 Bits beschränkt
ist. Der bestmögliche Wert für *J* ist dann der gerundete Quotient::

   >>> q, r = divmod(2**56, 10)
   >>> r
   6

Da der Rest mehr als die Hälfte von 10 beträgt, wird die beste Annäherung durch
aufrunden ermittelt::

   >>> q+1
   7205759403792794

Aus diesem Grund ist die bestmögliche Approximation von 1/10 als IEEE-754 double 
precision dieser Wert geteilt durch 2\*\*56, also::

   7205759403792794 / 72057594037927936

Kürzt man Zähler und Nenner mit 2, ergibt sich folgender Bruch::

   3602879701896397 / 36028797018963968

Man beachte, dass, da aufgerundet wurde, dieser Wert in Wahrheit etwas größer
ist als 1/10; hätte man nicht aufgerundet wäre der Bruch ein wenig kleiner als
1/10.  Aber in keinen Fall wäre er *exakt* 1/10!

Der Rechner bekommt also nie 1/10 zu *sehen*:  was er sieht, ist der exakte
oben dargestellte Bruch, die beste IEEE-754 double Approximation, die es gibt::

   >>> 0.1 * 2 ** 55
   3602879701896397.0

Wenn dieser Bruch mit 10\*\*60 multipliziert wird, kann man sich diesen Wert
bis auf 60 Dezimalstellen anzeigen lassen::

   >>> 3602879701896397 * 10 ** 60 // 2 ** 55
   1000000000000000055511151231257827021181583404541015625

was bedeutet das der exakte Wert der im Rechner gespeichert würde, in etwa
dem Dezimalwert 0.100000000000000005551115123125 entspricht.  Rundet man dies
auf 17 Stellen ergeben sich die 0.10000000000000001 die Python darstellt.
(das tut es zumindest auf einer 754-konformen Plattform, die die bestmögliche
Eingabe- und Ausgabekonversation in seiner C library durchführt --- auf
deiner vielleicht nicht!).

Das Modul :mod:`fractions` und das Modul :mod:`decimal` vereinfacht diese
Rechnung::

   >>> from decimal import Decimal
   >>> from fractions import Fraction
   >>> print(Fraction.from_float(0.1))
   3602879701896397/36028797018963968
   >>> print(Decimal.from_float(0.1))
   0.1000000000000000055511151231257827021181583404541015625

