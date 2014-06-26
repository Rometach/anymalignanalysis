set terminal latex
set output "g2.tex"
set title "g2"
plot "../minimini.merged" using 3:18 with points
set terminal wxt

set terminal latex
set output "phi2.tex"
set title "phi2"
plot "../minimini.merged" using 4:18 with points
set terminal wxt

set terminal latex
set output "im.tex"
set title "im"
plot "../minimini.merged" using 5:18 with points
set terminal wxt

set terminal latex
set output "jacc.tex"
set title "jacc"
plot "../minimini.merged" using 6:18 with points
set terminal wxt

set terminal latex
set output "nexp.tex"
set title "nexp"
plot "../minimini.merged" using 7:18 with points
set terminal wxt

set terminal latex
set output "yuleq.tex"
set title "yuleq"
plot "../minimini.merged" using 8:18 with points
set terminal wxt

set terminal latex
set output "yuleo.tex"
set title "yuleo"
plot "../minimini.merged" using 9:18 with points
set terminal wxt

set terminal latex
set output "salience.tex"
set title "salience"
plot "../minimini.merged" using 10:18 with points
set terminal wxt

set terminal latex
set output "ttest.tex"
set title "ttest"
plot "../minimini.merged" using 11:18 with points
set terminal wxt

set terminal latex
set output "zscore.tex"
set title "zscore"
plot "../minimini.merged" using 12:18 with points
set terminal wxt

set terminal latex
set output "brawnb.tex"
set title "brawnb"
plot "../minimini.merged" using 13:18 with points
set terminal wxt

set terminal latex
set output "simpson.tex"
set title "simpson"
plot "../minimini.merged" using 14:18 with points
set terminal wxt

set terminal latex
set output "laplace.tex"
set title "laplace"
plot "../minimini.merged" using 15:18 with points
set terminal wxt
