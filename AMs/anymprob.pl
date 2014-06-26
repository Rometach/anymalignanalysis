# Tabulates binomial coefficients
@binom = ();
binom(30); 

open(FRENCH,  $ARGV[0]) or "die cannot open $ARGV[0]\n";
open(ENGLISH, $ARGV[1]) or "die cannot open $ARGV[1]\n";
$k = $ARGV[2];

$N = 0;
while(<FRENCH>) {
  $f = $_; chop $f;
  $e = <ENGLISH>; chop $e;
  # printf "$f == $e\n";
  $l++; 
  # make each word unique in English and French
  foreach $fw (split(/ +/, $f)) {
    $inf{$fw} = 1;
  }
  foreach $ew (split(/ +/, $e)) {
    $ine{$ew} = 1;
  }
  # ----------------------
  # Increment the marginal
  # ----------------------
  foreach $fw (keys %inf) {
    $fcount{$fw}++;
  }
  foreach $ew (keys %ine) {
    $ecount{$ew}++;
  }
  # --------------------
  # Increment the joint
  # --------------------
  foreach $fw (keys %inf) {
    foreach $ew (keys %ine) {
      $pcount{$fw . "||" . $ew}++;
      warn "problem line $l with $fw||$ew  $fcount{$fw} -- $ecount{$ew} -- " , $pcount{$fw . "||" . $ew} if ($pcount{$fw . "||" . $ew} > $fcount{$fw}) ;
    }
  }
  $N++;
  %inf = (); %ine = ();
}

foreach $p (keys %pcount) {
  ($fw, $ew) = split(/\|\|/, $p);
  if ($pcount{$p} > $fcount{$fw} or $pcount{$p} > $ecount{$ew} or ($pcount{$p} + ($fcount{$fw} - $pcount{$p}) + ($ecount{$ew} - $pcount{$p}) > $N)) {
    warn "Invalid count for $p: joint=$pcount{$p} margf=$fcount{$fw} marge=$ecount{$ew} total = $N ";
  }
  
  # drop hapaxes
  next if ($fcount{$fw} == 1 or $ecount{$ew} == 1);

#  $pi2  = pi(2,  $fcount{$fw}/$N, $ecount{$ew}/$N);
#  $pi5  = pi(5,  $fcount{$fw}/$N, $ecount{$ew}/$N);
#  $pi10 = pi(10, $fcount{$fw}/$N, $ecount{$ew}/$N);
#  $pi15 = pi(15, $fcount{$fw}/$N, $ecount{$ew}/$N);
#  $pi20 = pi(20, $fcount{$fw}/$N, $ecount{$ew}/$N);
#  $pd2  = pd(2,  $pcount{$p}/$N, ($N -  ($pcount{$p} + ($fcount{$fw} - $pcount{$p}) + ($ecount{$ew} - $pcount{$p})))/$N);
#  $pd5  = pd(5,  $pcount{$p}/$N, ($N -  ($pcount{$p} + ($fcount{$fw} - $pcount{$p}) + ($ecount{$ew} - $pcount{$p})))/$N);
#  $pd10 = pd(10, $pcount{$p}/$N, ($N -  ($pcount{$p} + ($fcount{$fw} - $pcount{$p}) + ($ecount{$ew} - $pcount{$p})))/$N);
#  $pd15 = pd(15, $pcount{$p}/$N, ($N -  ($pcount{$p} + ($fcount{$fw} - $pcount{$p}) + ($ecount{$ew} - $pcount{$p})))/$N);
#  $pd20 = pd(20, $pcount{$p}/$N, ($N -  ($pcount{$p} + ($fcount{$fw} - $pcount{$p}) + ($ecount{$ew} - $pcount{$p})))/$N);
  $pik = pi($k, $fcount{$fw}/$N, $ecount{$ew}/$N);
  $pdk = pd($k, $pcount{$p}/$N, ($N -  ($pcount{$p} + ($fcount{$fw} - $pcount{$p}) + ($ecount{$ew} - $pcount{$p})))/$N);

#  printf("$fw	$ew	%.6f	%.6f	%.6f	%.6f	%.6f	%.6f	%.6f	%.6f	%.6f	%.6f	%.6f\n", 
#	 $pcount{$p}/$N, $fcount{$fw}/$N, $ecount{$ew}/$N, log($pd5/$pi5),
#	 rawim($pcount{$p}/$N, $fcount{$fw}/$N, $ecount{$ew}/$N,$N),
#	 $pi2, $pi5, $pi10, 
#	 $pd2, $pd5, $pd10);
  printf("$fw	$ew	%.6f	%.6f	%.6f	%.6f	%.6f	%.6f	%.6f\n", 
	 $pcount{$p}/$N, $fcount{$fw}/$N, $ecount{$ew}/$N, rawim($pcount{$p}/$N, $fcount{$fw}/$N, $ecount{$ew}/$N,$N), $pik, $pdk, logbeton($pdk,$pik));
}

# calcul de P_I en fonction de $k$
sub pi ($$$) {
  my $nexp  = shift; # size of the subcorpus
  my $margf    = shift; # marginal for f
  my $marge    = shift; # marginal for e
  my $k;

  my $pi = 0;
  # counting starts at 1 -- we need to see this word
  # warn "marge=$marge margef=$margf";
  for $k (1 .. $nexp) {
    $pi += $binom[$nexp][$k] * ($margf * $marge)**$k * ((1-$margf) * (1-$marge))**($nexp - $k);
    # warn "$binom[$nexp][$k] -- k=$k --> pi=$pi\n";
  }
  return ($pi);
}

# calcul de P_D en fonction de $k$
sub pd ($$$) {
  my $nexp  = shift; # size of the subcorpus
  $joinef = shift; # joint for (e,f)
  $nnoref = shift; # joint for (!e,!f)

  my $pd = 0;
  # warn "joint=$joinef comp=$nnoref";
  for $k (1 .. $nexp) {
    $pd += $binom[$nexp][$k] * (($joinef)**$k) * ($nnoref)**($nexp - $k);
    # warn "$binom[$nexp][$k] -- k=$k --> pi=$pd\n";
  }
  return ($pd);
}

# tabulation des coefficients du binome
sub binom($) {
  my $n = shift;
  $binom[1][0] = (1);
  $binom[2][0] = 1;   $binom[2][1] = 2;   $binom[2][2] = 1; 

  foreach $i (3 .. $n) {
    $binom[$i][0] = $binom[$i][$i] = 1;
    foreach $j (1 .. $i-1) {
      $binom[$i][$j] = $binom[$i-1][$j-1] + $binom[$i-1][$j];
      # warn "$i $j $binom[$i][$j]\n";
    }
  }
}

sub rawim($$$) {
  $joint = shift;
  $margf = shift;
  $marge = shift;
  if ($marge == 0 or $margf == 0 or $N == 0 or $joint == 0) {
    warn "im() Zero count joint=$joint margf=$margf marge=$marge N=$N\n"; return 0;
  }
  return log(($joint)/($marge*$margf));
}

sub logbeton($$) {
  $x = shift; $y = shift;
  if ($y == 0) {
    return 0;
  }
  elsif (($x/$y) <= 0) {
    return 0;
  }
  else {
    return log($x/$y);
  }
}
