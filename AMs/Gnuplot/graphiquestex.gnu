set terminal latex
set output "g2.tex"
set title "g2"
plot "../mie/miniepps.merged" using 3:22 with points
set terminal wxt

set terminal latex
set output "phi2.tex"
set title "phi2"
plot "../mie/miniepps.merged" using 4:22 with points
set terminal wxt

set terminal latex
set output "im.tex"
set title "im"
plot "../mie/miniepps.merged" using 5:22 with points
set terminal wxt

set terminal latex
set output "jacc.tex"
set title "jacc"
plot "../mie/miniepps.merged" using 6:22 with points
set terminal wxt

set terminal latex
set output "nexp.tex"
set title "nexp"
plot "../mie/miniepps.merged" using 7:22 with points
set terminal wxt

set terminal latex
set output "yuleq.tex"
set title "yuleq"
plot "../mie/miniepps.merged" using 8:22 with points
set terminal wxt

set terminal latex
set output "yuleo.tex"
set title "yuleo"
plot "../mie/miniepps.merged" using 9:22 with points
set terminal wxt

set terminal latex
set output "salience.tex"
set title "salience"
plot "../mie/miniepps.merged" using 10:22 with points
set terminal wxt

set terminal latex
set output "ttest.tex"
set title "ttest"
plot "../mie/miniepps.merged" using 11:22 with points
set terminal wxt

set terminal latex
set output "zscore.tex"
set title "zscore"
plot "../mie/miniepps.merged" using 12:22 with points
set terminal wxt

set terminal latex
set output "brawnb.tex"
set title "brawnb"
plot "../mie/miniepps.merged" using 13:22 with points
set terminal wxt

set terminal latex
set output "simpson.tex"
set title "simpson"
plot "../mie/miniepps.merged" using 14:22 with points
set terminal wxt

set terminal latex
set output "laplace.tex"
set title "laplace"
plot "../mie/miniepps.merged" using 15:22 with points
set terminal wxt
