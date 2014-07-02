# converts the values of a .merge file to logs


open(MERGE, "$ARGV[0]") or die "cannot open merged file $ARGV[0]\n";
print "# e	f	g2	phi2	im	jacc	nexp	yuleq	yuleo	salience	ttest	zscore	brawnb	simpson	laplace	pcount	rawim	pik	pdk	logki	joint	fnext	pef	pfe	pmoy	x	next\n";
$_ = <MERGE>;

while(<MERGE>) {
  chop; $_ =~ s/^[ 	]*//g;
  ($e, $f, $g2, $phi2, $im, $jacc, $nexp, $yuleq, $yuleo, $salience, $ttest, $zscore, $brawnb, $simpson, $laplace, $pcount, $rawim, $pik, $pdk, $logki, $joint, $fnext, $pef, $pfe, $pmoy, $x, $next) = split(/[	 ]+/);
#  $e=logbeton($e);
#  $f=logbeton($f);
#  $g2=logbeton($g2);
#  $phi2=logbeton($phi2);
#  $im=logbeton($im);
#  $jacc=logbeton($jacc);
#  $nexp=logbeton($nexp);
#  $yuleq=logbeton($yuleq);
#  $yuleo=logbeton($yuleo);
#  $salience=logbeton($salience);
#  $ttest=logbeton($ttest);
#  $zscore=logbeton($zscore);
#  $brawnb=logbeton($brawnb);
#  $simpson=logbeton($simpson);
#  $laplace=logbeton($laplace);
#  $pcount=logbeton($pcount);
#  $rawim=logbeton($rawim);
#  $pik=logbeton($pik);
#  $pdk=logbeton($pdk);
#  $logki=logbeton($logki);
#  $joint=logbeton($joint);
#  $fnext=logbeton($fnext);
#  $x=logbeton($x);
  $next=log($next);
  print "$e	$f	$g2	$phi2	$im	$jacc	$nexp	$yuleq	$yuleo	$salience	$ttest	$zscore	$brawnb	$simpson	$laplace	$pcount	$rawim	$pik	$pdk	$logki	$joint	$fnext	$pef	$pfe	$pmoy	$x	$next\n";
}

sub logbeton($) {
  $x = shift;
  if ($x <= 0) {
    return -1;
  }
  else {
    return log($x);
  }
}
