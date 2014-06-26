open(FRENCH,  $ARGV[0]) or "die cannot open $ARGV[0]";
open(ENGLISH, $ARGV[1]) or "die cannot open $ARGV[1]";
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

printf("G2	phi2	IM	Jacc	Nexp	YuleQ	YuleO  n(e,f)	f (n(f))	e (n(e))\n");
foreach $p (keys %pcount) {
  ($fw, $ew) = split(/\|\|/, $p);
  if ($pcount{$p} > $fcount{$fw} or $pcount{$p} > $ecount{$ew} or ($pcount{$p} + ($fcount{$fw} - $pcount{$p}) + ($ecount{$ew} - $pcount{$p}) > $N)) {
    warn "Invalid count for $p: joint=$pcount{$p} margf=$fcount{$fw} marge=$ecount{$ew} total = $N ";
  }
  
  # drop hapaxes
  next if ($fcount{$fw} == 1 or $ecount{$ew} == 1);

  $G2        = G2($pcount{$p}, $fcount{$fw} - $pcount{$p}, $ecount{$ew} - $pcount{$p}, $N - $pcount{$p} - ($fcount{$fw} - $pcount{$p}) - ($ecount{$ew} - $pcount{$p}),
		  $fcount{$fw}, $N - $fcount{$fw}, $ecount{$ew}, $N - $ecount{$ew}, $N);
  $phi2      = phi2($pcount{$p}, $fcount{$fw} - $pcount{$p}, $ecount{$ew} - $pcount{$p}, $N - $pcount{$p} - ($fcount{$fw} - $pcount{$p}) - ($ecount{$ew} - $pcount{$p}));
  $im        = im($pcount{$p}, $fcount{$fw}, $ecount{$ew}, $N);
  $jaccard   = jaccard($pcount{$p}, $fcount{$fw} - $pcount{$p}, $ecount{$ew} - $pcount{$p});
  $normexp   = normexp($pcount{$p}, $fcount{$fw} - $pcount{$p}, $ecount{$ew} - $pcount{$p});
  $yuleq     = yuleq($pcount{$p}, $fcount{$fw} - $pcount{$p}, $ecount{$ew} - $pcount{$p}, $N - $pcount{$p} - ($fcount{$fw} - $pcount{$p}) - ($ecount{$ew} - $pcount{$p}));
  $yuleom    = yuleom($pcount{$p}, $fcount{$fw} - $pcount{$p}, $ecount{$ew} - $pcount{$p}, $N - $pcount{$p} - ($fcount{$fw} - $pcount{$p}) - ($ecount{$ew} - $pcount{$p}));
#  $oddsratio = oddsratio($pcount{$p}, $fcount{$fw} - $pcount{$p}, $ecount{$ew} - $pcount{$p}, $N - $pcount{$p} - ($fcount{$fw} - $pcount{$p}) - $ecount{$ew} - $pcount{$p});
  printf("%3.f	%.3f	%.3f	%.3f	%.3f	%.3f	%.3f	j=%i	N=%i	%s (%i)	%s (%i)\n", 
	 $G2,
	 $phi2,
	 $im,
	 $jaccard,
	 $normexp,
	 $yuleq,
	 $yuleom,
#	 $oddsratio,
	 $pcount{$p},
	 $N,
	 $fw, 
	 $fcount{$fw},
	 $ew,
	 $ecount{$ew});
}

# The G2 (aka likelihood ratio)
sub G2($$$$$$$$$){
  $a = shift; $b = shift; $c = shift; $d = shift;
  $aplusb = shift; $cplusd = shift; $aplusc = shift; $bplusd = shift; $N = shift;
  if ($aplusb == 0 or $aplusc == 0 or $cplusd == 0 or $bplusd == 0) {
    warn "G2() Zero marge aplusb=$aplusb aplusc=$aplusc cplusd=$cplusd bplusd=$bplusd\n"; return 0;
  }
  return 2* (
	      ($a > 0 ? $a*log(($N*$a)/($aplusb*$aplusc)) : 0) + 
	      ($b > 0 ? $b*log(($N*$b)/($aplusb*$bplusd)) : 0) +
	      ($c > 0 ? $c*log(($N*$c)/($aplusc*$cplusd)) : 0) +
	      ($d > 0 ? $d*log(($N*$d)/($bplusd*$cplusd)) : 0)
	     );
}

# compute the pointwise mutual information
sub im($$$$) {
  $joint = shift;
  $margf = shift;
  $marge = shift;
  $N = shift;
  if ($marge == 0 or $margf == 0 or $N == 0 or $joint == 0) {
    warn "im() Zero count joint=$joint margf=$margf marge=$marge N=$N\n"; return 0;
  }
  return log(($N*$joint)/($marge*$margf)) / log(2);
}

# compute the phi^2 as Church and Gale
sub phi2($$$$) {
  $a = shift; $b = shift; $c = shift; $d = shift;
  if (($a + $c)== 0 or ($b + $d) == 0 or ($a + $b) == 0 or ($c + $d) == 0) {
    warn "phi2() Zero count a=$a b=$b c=$c d=$d\n"; return 0;
  }
  my $ad = $a*$d; my $bc = $b*$c;
  return ($ad - $bc)*($ad - $bc)/(($a+$c)*($a+$b)*($b+$d)*($c+$d));
}

# The Q coefficient of Yule
sub yuleq($$$$) {
  $a = shift; $b = shift; $c = shift; $d = shift;
  my $ad = $a*$d; my $bc = $b*$c;
  if ($ad == 0 and $bc == 0) {
    warn "yuleq() Zero count a=$a b=$b c=$c d=$d\n"; return 0;
  }
  return ($ad - $bc)/($ad + $bc);
}

# odds ratio
sub oddsratio($$$$) {
  $a = shift; $b = shift; $c = shift; $d = shift;
  my $ad = $a*$d; my $bc = $b*$c;
  if ($bc == 0) {
    warn "oddsratio() Zero count a=$a b=$b c=$c d=$d\n"; return 0;
  }
  return ($ad)/($bc);
}


# The omeega coefficient of Yule
sub yuleom($$$$) {
  $a = shift; $b = shift; $c = shift; $d = shift;
  my $ad = sqrt($a*$d); my $bc = sqrt($b*$c);
  if ($ad == 0 and $bc == 0) {
    warn "yuleq() Zero count a=$a b=$b c=$c d=$d\n"; return 0;
  }
  return ($ad - $bc)/($ad + $bc);
}

# compute the Jaccard
sub jaccard($$$) {
  $a = shift; $b = shift; $c = shift; 
  if ($a == 0 and $b == 0 and $c == 0) {
    warn "jaccard() Zero count a=$a b=$b c=$c"; return 0;
  }
  return $a/($a+$b+$c);
}

# compute the Normalized expectation
sub normexp($$$) {
  $a = shift; $b = shift; $c = shift; 
  if ($a == 0 and $b == 0 and $c == 0) {
    warn "normexp() Zero count a=$a b=$b c=$c"; return 0;
  }
  return 2*$a/(2*$a+$b+$c);
}
