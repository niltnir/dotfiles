#  BOOST SOFTWARE LICENSE - VERSION 1.0 - 17 AUGUST 2003

#  Modifications Copyright (c) 2023 Lynn Noda <lynn@lynnnoda.com>
#  Copyright (c) 2022 Evan Chen [evan at evanchen.cc]
#  https://web.evanchen.cc/ || github.com/vEnhance

#  Available for download at:
#  https://github.com/vEnhance/dotfiles/blob/main/latexmkrc

#  Permission is hereby granted, free of charge, to any person or organization
#  obtaining a copy of the software and accompanying documentation covered by
#  this license (the "Software") to use, reproduce, display, distribute,
#  execute, and transmit the Software, and to prepare derivative works of the
#  Software, and to permit third-parties to whom the Software is furnished to
#  do so, all subject to the following:

#  The copyright notices in the Software and this entire statement, including
#  the above license grant, this restriction and the following disclaimer,
#  must be included in all copies of the Software, in whole or in part, and
#  all derivative works of the Software, unless such copies or derivative
#  works are solely in the form of machine-executable object code generated by
#  a source language processor.

#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
#  SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
#  FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
#  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#  DEALINGS IN THE SOFTWARE.

push @extra_pdflatex_options, '-synctex=1' ;

# This version is better than the one given by official asy doc
# because it will work with latexmk -cd as well.
# Unfortunately, I doubt it works on windows,
# because dirname is a linux command.
sub run_asy {
    return system("asy -o \$(dirname '$_[0]') '$_[0]'");
}
add_cus_dep("asy", "eps", 0, "run_asy");
add_cus_dep("asy", "pdf", 0, "run_asy");
add_cus_dep("asy", "tex", 0, "run_asy");

sub pythontex {
    system("pythontex --runall true \"$_[0]\"");
    system("touch \$(basename \"$_[0]\").pytxmcr");
    return;
}
add_cus_dep("pytxcode", "pytxmcr", 0, "pythontex");

$pdflatex = 'xelatex --shell-escape %O %S';

$dvi_mode = 0;
$postscript_mode = 0;
$pdf_mode = 4;

$do_cd = 1;
$max_repeat = 7;
$pdf_previewer = "zathura %O %S &> /dev/null &";
$pvc_timeout = 1;

$cleanup_includes_generated = 0;
$cleanup_includes_cusdep_generated = 1;

@generated_exts = ( 'aux', 'bbl', 'bcf', 'fls', 'idx', 'ind', 'lof',
                    'lot', 'out', 'pre', 'toc', 'nav', 'snm',
                    'synctex.gz', 'pytxpyg', 'pytxmcr', 'pytxcode',);

# don't hash calc for deep system dependencies
$hash_calc_ignore_pattern{'map'} = '^';
$hash_calc_ignore_pattern{'fmt'} = '^';

$silent = 1;

# vim: ft=perl
