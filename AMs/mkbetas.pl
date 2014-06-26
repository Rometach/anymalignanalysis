open(FRENCH,  $ARGV[0]) or "die cannot open $ARGV[0]";
$N = 0;
while(<FRENCH>) {
  $f = $_; chop $f;
  # ----------------------
  # Increment the marginal
  # ----------------------
  foreach $fw (split(/ +/, $f)) {
    $fcount{$fw} += 1;
  }
}
#
foreach $w (keys %fcount) {
  print $w, "	", $fcount{$w}, "\n" unless ($fcount{$w} < 2);
}
