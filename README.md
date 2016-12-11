Multivariable Calculus Problem Collection
=========================================

What is it?
-----------

These are the LaTeX source files for a collection of problems in multivariable calculus. The problems are provided together with detailed solutions as well as 2D and 3D figures. This collection was compiled in the process of teaching multivariable calculus at Brunel University London during the years 2014&ndash;2016. The module covered chapters 15, 16 and 17 of

* J. Marsden, A. Weinstein, *Calculus III*. Springer, 1985.

The sections of the collection are in correspondence with the sections of the textbook. Other textbooks that served as a source and inspiration for problems are

* M. Corral, *Vector Calculus*. 2008.
* G. Hartman, *APEX Calculus III*. Version 3.0, 2015.
* D. Guichard, *Single and Multivariable Calculus*. 2016.
* J. Stewart, *Calculus*. 8th edition. Cengage Learning, 2015.
* G. Thomas, *Thomas' Calculus*. Twelfth edition. Addison-Wesley, 2010.

The solutions and figures were created from skratch.

[Compiled PDF files](http://www.brunel.ac.uk/~mastmmb) are available on my website.

Dependencies
------------

To create the figures the following programs are needed

* Asymptote (2.37)
* gnuplot (5.0)

The versions refer to the versions used when compiling the source. Other versions might work as well, but were not tested. Asymptote is used for 3D figures and gnuplot is called by TikZ for some 2D figures.

Compilation
-----------

A makefile is provided to automate compilation. The following targets are available
```
make problems
make solutions
make all
make clean
```
It is also possible to compile a specific file via
```
make solutions_sect_01.pdf
```
The 3D figures can be compiled either in low (for testing purposes) or high (for printing) resolution. The default setting is low resolution. To compile high resolution figures use
```
make all asy_highres=1
```
Running `make all` with high resolution figures will take about one hour.

In order to manually compile the files with LaTeX, follow the following steps
```
mkdir tmp_asy              # Directory for asymptote files
latex solutions_all.tex
cd tmp_asy
asy solutions_all-*.asy    # Create 3D figures
cd ..
latex solutions_all.tex
latex solutions_all.tex
```
To compile the figures in high resolution add `\asyhighrestrue` to the file `asy_flags.tex`. Alternatively one can replace `\asyhighresfalse` by `\asyhighrestrue` in `header.tex`.

Licence
-------

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

You should have received a copy of the license along with this
work. If not, see <http://creativecommons.org/licenses/by-nc-sa/4.0/>.

Contacts
--------

Martins Bruveris  
Email: martins.bruveris@brunel.ac.uk  
Web: [www.brunel.ac.uk/~mastmmb](http://www.brunel.ac.uk/~mastmmb)

