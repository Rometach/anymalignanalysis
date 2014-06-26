# Use is
# perl main.pl fname1 fname2 destinationdirectory

system("python anymalign.py $ARGV[0] $ARGV[1] -t 30 > $ARGV[2]//main.anymalign");
system("perl anymprob.pl $ARGV[0] $ARGV[1] > $ARGV[2]//main.anymprob");
system("perl pairspp.pl $ARGV[0] $ARGV[1] > $ARGV[2]//main.pairs");
open(ALIGN,"$ARGV[2]//main.anymalign");
my $N = 0;
while(<ALIGN>) {
  $N++;
}
system("perl mergepairsNprobs.pl $ARGV[2]//main.pairs $ARGV[2]//main.anymalign $N $ARGV[2]//main.anymprob > $ARGV[2]//main.merged");
# Usage is perl mergepairsNprobs X.pairs X.anymalign Nsample X.anymprobs
system("cd Gnuplot//");
system("gnuplot graphiquespng.gnu");
system("cd ..");
