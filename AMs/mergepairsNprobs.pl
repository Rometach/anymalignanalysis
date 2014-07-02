# Réconcilie les statistiques de anymalign avec les indicateurs classiques.
# Deux options sont possibles:
# -- soit on n'a extrait que les segments contigus
# -- soit on a extrait tous les segments y compris discontinus

# Usage is perl mergepairsNprobs X.pairs X.anymalign Nsample X.anymprobs
# avec Nsample le nombre de tirages total
$nl = 0;
$nSample = 0;
open(PAIRS, "$ARGV[0]") or die "cannot open pairs $ARGV[0]\n"; 
# G2	phi2	IM	Jacc	Nexp	YuleQ	YuleO  n(e,f)	f (n(f))	e (n(e))
# 7	0.016	6.239	0.056	0.105	0.982	0.824	j=1	N=4531	palm-trees (4)	regard (15)
while(<PAIRS>) {
  $nl++;
  next if ($nl == 1);
  chop; $_ =~ s/^[ 	]*//g;
#  warn "$_\n";
  ($g2, $phi2, $im, $jacc, $nexp, $yuleq, $yuleo, $salience, $ttest, $zscore, $brawnb, $simpson, $laplace, $joint, $total, $e, $marge, $f, $margf) = split(/[	 ]+/);
  $joint =~ s/^j=//g;
  $total =~ s/^N=//g;
#  warn "Total : $total\n";
#  print "$_\n";
#  print "$f -- $e -- $joint -- $total\n";
  $joint{$f . ":" . $e} = $joint / $total;
  $g2{$f . ":" . $e} = $g2;
  $phi2{$f . ":" . $e} = $phi2;
  $im{$f . ":" . $e} = $im;
  $jacc{$f . ":" . $e} = $jacc;
  $nexp{$f . ":" . $e} = $nexp;
  $yuleq{$f . ":" . $e} = $yuleq;
  $yuleo{$f . ":" . $e} = $yuleo;
  $salience{$f . ":" . $e} = $salience;
  $ttest{$f . ":" . $e} = $ttest;
  $zscore{$f . ":" . $e} = $zscore;
  $brawnb{$f . ":" . $e} = $brawnb;
  $simpson{$f . ":" . $e} = $simpson;
  $laplace{$f . ":" . $e} = $laplace;
}
close PAIRS;


open(PROBS, "$ARGV[3]") or die "cannot open probs\n";
while(<PROBS>) {
  chop; $_ =~ s/^[ 	]*//g;
  # $fw		$ew $pcount{$p}/$N, $fcount{$fw}/$N, $ecount{$ew}/$N, rawim($pcount{$p}/$N, $fcount{$fw}/$N, $ecount{$ew}/$N,$N), $pik, $pdk;
  # ferrées	for	0.000100	0.000200	0.234023	0.759187	0.000025	0.000053	0.000000	0.000000
  ($e, $f, $pcount, $fcount, $ecount, $rawim, $pik, $pdk, $logksuri) = split(/[	 ]+/);
  $pcount{$f . ":" . $e} = $pcount;
  $rawim{$f . ":" . $e} = $rawim;
  $pik{$f . ":" . $e} = $pik;
  $pdk{$f . ":" . $e} = $pdk;
  $logki{$f . ":" . $e} = $logksuri;
}
close PROBS;

print "# e	f	g2	phi2	im	jacc	nexp	yuleq	yuleo	salience	ttest	zscore	brawnb	simpson	laplace	pcount	rawim	pik	pdk	logki	joint	fnext	pef	pfe	pmoy	x	next\n";
open(ALIGN, "$ARGV[1]") or die "cannot open alignments\n";
while(<ALIGN>) {
  chop;
  # .	.	-	0.848720 0.861958	24702
  ($e, $f, $foo, $peffe, $next) = split(/[	]+/);
  warn "**$next** is not an integer: $_\n" unless ($next =~ /^-?\d+$/);
  ($pef, $pfe) = split(/ /, $peffe);
  warn "pef ***$pef*** not a C float" unless ($pef =~ /^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$/);
  warn "pfe ***$pfe*** not a C float" unless ($pfe =~ /^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$/);
  # print foobar;
  $key = $f . ":" . $e;
  $fnext = $next/$ARGV[2];
  if (not defined($joint{$key})) { 
    warn "no key for e=$e -- f=$f\n"; 
    # print "$e	$f	0 $next\n";
  }
  else {
    # donne la probabilité d'être alignés sachant qu'ils sont tirés.
    $x = $fnext/$joint{$key};
    $moy = ($pfe+$pef)/2;
    warn "strange prob for $key fnext=$fnext joint=$joint next=$next" if ($fnext > 1 or $joint{$key} > 1);
    print "'$e'	'$f'	$g2{$key}	$phi2{$key}	$im{$key}	$jacc{$key}	$nexp{$key}	$yuleq{$key}	$yuleo{$key}	$salience{$key}	$ttest{$key}	$zscore{$key}	$brawnb{$key}	$simpson{$key}	$laplace{$key}	$pcount{$key}	$rawim{$key}	$pik{$key}	$pdk{$key}	$logki{$key}	$joint{$key}	$fnext	$pef	$pfe	$moy	$x	$next\n" unless ($fnext > 1 or $joint{$key} > 1);
  }
}
close ALIGN;
