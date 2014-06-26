anymalignanalysis
=================


*** Program/profil.c
(quite useless, works only if LEN<=4)
Calculates the number of partitions into profiles of a corpus of LEN sentences of i words (for i from 0 to ITER).
This number is simply the number of partition of the multiset (1^i,...,LEN^i) into sets.

*** Program/evalnbq.c
Use is "./evalnbq corpus.anymalign" where "corpus.anymalign" is the output file of anymalign
Prints the number of (i,j) alignements made by anymalign (for i,j from 1 to MAXN).

*** Program/filpro.c
Generates a random LIGNES*COLONNES corpus on a dictionary of DICO words. One can choose the DISTRIBUTION between "zipf" and "uniform".
Calculates and prints the number of profiles present appearing one, twice, ... for 1-grams, 2-grams and 3-grams.

*** Program/generateur.c
Use is "./generateur dico distribution nbphrases lgphrases bruit".
Builds a dictionary of dico words and prints it into "dictionnaire.txt" with the frequencies according to distribution, which can be "zipf", "zipfplateau" (very similar to "zipf") or "uniform". Source words begin with letter 'a', destination words with letter 'n'. Translations are equivalent if not the first letter (for example, "aabc" is the translation of "nabc").
Generates then two parallel toy-corpuses "source.txt" and "destination.txt" of nbphrases sentences of length lgphrases.
The bruit argument is a floating number between 0 and 1 ; it is the probability that any destination word is not chosen as the corresponding source word translation. Set to 0. for completely parallel texts, and set to 1 for two random independant texts.


*** AMs
Scripts in this directory allow to compare anymalign's results with classic Association Measures.
Corpuses of small and medium length, and corresponding output files, can be found in "min" and "mie".
Use is for instance:
    "python anymalign -N 1 mie/miniepps.fr mie/miniepps.en > mie/epps.anymalign"
    "perl anymnprob.pl mie/miniepps.fr mie/miniepps.en k > mie/miniepps.anymalign" with k the (integer) average subcorpuses size of anymalign
    "perl pairspp.pl mie/miniepps.fr mie/miniepps.en > mie/miniepps.pairs"
    "perl mergepairsNprobs.pl mie/miniepps.pairs mie/miniepps.anymalign N mie/miniepps.anymprobs" with N the total number of subcorpuses seen by anymalign
    "perl logmerge.pl mie/miniepps.merged > mie/miniepps.logmerged"
Then the file "mie/miniepps.merged" will contain for each processed pair of words many association measures, and anymalign's results (and "mie/miniepps.logmerged" the same with logs).
Finally it is possible to plot these results with the files "Gnuplot/graphiqueslatex.gnu" and "Gnuplot/graphiquespng.gnu".
