plot [*:150] [*:*] "../../moy/moyen.logmerged" using 3:27 with points lt 1
set terminal png
set output "g2log.png"
set title "g2"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 4:27 with points lt 1
set terminal png
set output "phi2log.png"
set title "phi2"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 5:27 with points lt 1
set terminal png
set output "imlog.png"
set title "im"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 6:27 with points lt 1
set terminal png
set output "jacclog.png"
set title "jacc"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 7:27 with points lt 1
set terminal png
set output "nexplog.png"
set title "nexp"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 8:27 with points lt 1
set terminal png
set output "yuleqlog.png"
set title "yuleq"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 9:27 with points lt 1
set terminal png
set output "yuleolog.png"
set title "yuleo"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 10:27 with points lt 1
set terminal png
set output "saliencelog.png"
set title "salience"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 11:27 with points lt 1
set terminal png
set output "ttestlog.png"
set title "ttest"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 12:27 with points lt 1
set terminal png
set output "zscorelog.png"
set title "zscore"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 13:27 with points lt 1
set terminal png
set output "brawnblog.png"
set title "brawnb"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 14:27 with points lt 1
set terminal png
set output "simpsonlog.png"
set title "simpson"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 15:27 with points lt 1
set terminal png
set output "laplacelog.png"
set title "laplace"
replot
set terminal wxt

plot [*:0.3] [*:*] "../../moy/moyen.logmerged" using 16:27 with points lt 1
set terminal png
set output "pcountlog.png"
set title "pcount"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 17:27 with points lt 1
set terminal png
set output "rawimlog.png"
set title "rawim"
replot
set terminal wxt

plot [*:0.02] [*:*] "../../moy/moyen.logmerged" using 18:27 with points lt 1
set terminal png
set output "p_ilog.png"
set title "p_i"
replot
set terminal wxt

plot [*:0.2] [*:*] "../../moy/moyen.logmerged" using 19:27 with points lt 1
set terminal png
set output "p_dlog.png"
set title "p_d"
replot
set terminal wxt

plot "../../moy/moyen.logmerged" using 20:27 with points lt 1
set terminal png
set output "logp_dp_ilog.png"
set title "logp_dp_i"
replot
set terminal wxt

plot [0:100] [0:0.0055] "../../moy/moyen.merged" using 3:22 with points lt 3
set terminal png
set output "g2.png"
set title "g2"
replot
set terminal wxt

plot [*:0.4] [0:0.0055] "../../moy/moyen.merged" using 4:22 with points lt 3
set terminal png
set output "phi2.png"
set title "phi2"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 5:22 with points lt 3
set terminal png
set output "im.png"
set title "im"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 6:22 with points lt 3
set terminal png
set output "jacc.png"
set title "jacc"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 7:22 with points lt 3
set terminal png
set output "nexp.png"
set title "nexp"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 8:22 with points lt 3
set terminal png
set output "yuleq.png"
set title "yuleq"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 9:22 with points lt 3
set terminal png
set output "yuleo.png"
set title "yuleo"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 10:22 with points lt 3
set terminal png
set output "salience.png"
set title "salience"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 11:22 with points lt 3
set terminal png
set output "ttest.png"
set title "ttest"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 12:22 with points lt 3
set terminal png
set output "zscore.png"
set title "zscore"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 13:22 with points lt 3
set terminal png
set output "brawnb.png"
set title "brawnb"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 14:22 with points lt 3
set terminal png
set output "simpson.png"
set title "simpson"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 15:22 with points lt 3
set terminal png
set output "laplace.png"
set title "laplace"
replot
set terminal wxt

plot [*:0.3] [0:0.0055] "../../moy/moyen.merged" using 16:22 with points lt 3
set terminal png
set output "pcount.png"
set title "pcount"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 17:22 with points lt 3
set terminal png
set output "rawim.png"
set title "rawim"
replot
set terminal wxt

plot [*:0.02] [0:0.0055] "../../moy/moyen.merged" using 18:22 with points lt 3
set terminal png
set output "p_i.png"
set title "p_i"
replot
set terminal wxt

plot [*:0.2] [0:0.0055] "../../moy/moyen.merged" using 19:22 with points lt 3
set terminal png
set output "p_d.png"
set title "p_d"
replot
set terminal wxt

plot [*:*] [0:0.0055] "../../moy/moyen.merged" using 20:22 with points lt 3
set terminal png
set output "logp_dp_i.png"
set title "logp_dp_i"
replot
set terminal wxt
