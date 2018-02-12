% cmptalk: Screen presentation LaTeX class optimized for research group
% Center for Machine Perception (http://cmp.felk.cvut.cz)
% and covers styles for CMP (3x), CAK (2x), CVL (2x).
% Cook-book: talk_ex.pdf / .tex
%
% (c) Vit Zyka, vit.zyka@seznam.cz
% Build on the top of foils.cls class
%
% 1999-11-30 : first version created in Ljubjana
% 2000-04-05 : correction of \shref in \cmpiistyle
% 2000-05-09 : rename of \linethickness to \talklinethickness
% 2000-05-18 : \long for \shyperlink and \shref
%              \maskfoil for not presented slide in main course
% 2000-12-02 : \itemize with plus?ex glue
% 2000-12-06 : remove final \vfill in \@foilhead (conflict with texpower)
%              frame rule by cmprulecolor (default by black)
%              slidetitle set to \appendixname
% 2001-05-11 : when using TeXPower package make text color black
% 2001-05-23 : arpgcell included (two column for page numbers)
% 2001-10-06 : \enumerate with plus?ex glue
% 2001-10-16 : CAKi style, cmpiistyle cleaning
% 2001-10-17 : \sideImgAB
% 2001-12-03 : v1.9; correction of package loading, CAKorange color
%              noloadhyperref, noloadgraphicx
%              corrections in hyperlinks: \@pdfborder, no highlight
% 2001-12-05 : psfrag correction, \talkstyle
%              options changed: emptystyle->emptytalkstyle, ... 
%              \newmargin, \oldmargin
%              \talkhead
% 2001-12-13 : v1.95; absolut placement (\placeatmm); \mbox in \talkhead
%              \parindent=0pt, \raggedright by default
%              \raise in \labelitemimark
%              \pdfoutlines
% 2001-12-14 : v2.0; paper size adjyst to screen ration
%              basepagestyle and other styles corrections 
%              dark and light color definitions
%              CMPii talk style
% 2002-01-16 : \ifPDF in non hyperref annotations
%              \hyperref setup cleaning
% 2002-01-17 : \video{}{}[]{}, option dvips for hyperref
% 2002-01-18 : v2.1 \markpage, \signpage, \bigfigfalse in \video
% 2002-01-29 : v2.2 correction of outline in talkhead for macro inside talkhead
%              \tokens in title, author, etc. instead of \def
% 2002-02-04 : \labelitemicolor{cmporange} in cmpiistyle
% 2002-02-12 : multicolor backround marker (thanks to Martin Matousek)
% 2002-03-01 : v2.31 \let\slidehead=\talkhead
% 2002-04-10 : v2.4 cggi, cggii styles (Jiri Bittner) and cakii;
%              \pagemarkerfonti, ii; cggorange color
% 2002-05-10 : v2.5 correction of page numbers using steps in texpower style
% 2002-05-16 : v2.51 font size in markpage changed 20pt->20.74pt, 17pt->17.28pt
%              \rotate -> \rotatebox due to collision with rotating.sty
% 2002-06-20 : v2.52 fix error with page marker (mark prev page)
% 2002-06-27 : v2.53 \maketalktitlepage, talktitlepage env. and \talkafterpage
% 2002-08-23 : v2.54 set height of the slide head box in \cmptalk@headboxii
% 2002-10-08 : v2.60 solved problem with texpower pause, step, page, and bigfig
% 2002-11-04 : v2.61 correction in vertical spacing in itemize,
%              enumerate, and description environments
% 2003-01-07 : v2.62 \videoPar, bigfig correction in \video, \mbox{} in \video
% 2003-05-12 : v2.7 option printout passed to texpower and bigfig
%              generating \jobname-print.tex file for printout
%              Invisible mouse navigation overlaps page borders
%              texpower works without bigfig (\cbigfig is defined)
%              absolute placement + texpower enabled
% 2003-06-12 : v2.71 \appendixfoil (improvement of \maskfoil) (for B. Micusik)
%              \acknowledgement (T. Werner)
% 2003-07-28 : v2.72 fix of talkhead error in cakii style
%              fix of \appendixfoil in ii style (R. Sara)
%              fix of two additional spaces in \outputpageii
% 2003-09-02 : v2.73 fix of numbering of the last page
%              fix \appendixfoil (complex construct in text,
%              e.g. \placeat, \includegraphics)
%              fix of bookmark number (+1)
% 2004-11-18 : v2.74 \itemlistparam also in enumerate and description (proposed V. Hlavac)
%              \mylistparam
% 2004-11-25 : v2.75 \boldmath in \foilhead and \subhead
% 2005-02-22 : v2.76 \ifPDF correction
% 2005-04-02 : v2.77 new texpower
%              if not defined \cbigfig then \newcount not \gdef
%              ifPDF for LoadClass{foil}
%              compatibility with texpower 2004/07/27 v0.1b (\pause,output)
% 2005-04-26 : v2.78 compatibility with texpower 2004/07/27 v0.1b
%              (texpowersetting: color management,pagecolor -> cmptalkpagecolor)
% 2005-04-27 : v2.80 cmptalknote (for Vladimir Smutny)
% 2005-05-03 : v2.81 cmptalkslide (for Radim Sara)
% 2005-05-11 : v2.82 advancing slideno correction; gathering code to \cmptalk@managecounters
%              intro \cmptalkslideno, \cmptalksubslideno, ... number cleaning
% 2005-05-27 : v2.83 nologoitalkstyle, nologoiitalkstyle
% 2006-08-13 : v2.84 \cmptalknoteempty; package option: allnotes
% 2006-09-01 : v2.90 cross references to notes
%                    \cmptalkpretitlepageskip introduced
% 2006-09-05 : v2.91 \cmptalkeveryslideandnote
% 2006-10-02 : v2.92 cmpvideo.sty inclusion
% 2007-10-10 : v2.93 \cmptalk@note@checkallnotes in titlepage
% 2008-02-19 : v2.94 fox of cmpiistyle, cmpzstyle
% 2008-03-05 : v2.95 ltfonts-vz (LatinModern default, T1=LM IL2=CS OT1=CM)
%                    \let\next=\relax in \cmptalk@note@checkallnotes
% 2008-07-26 : v2.96 17pt, 20pt (default), 25pt, 30pt class sizes
%                    \cmptalkslidetitlecolor{#1}, \cmptalkslidesubtitlecolor{#1}
%                    \cmptalkeveryslide, \cmptalkfooter, \cmptalk@inshipout
% 2008-10-24 : v2.97 \talktitlepagetitle, spacing title page
% 2008-11-12 : v2.98 cvutiitalkstyle; '*talkstyle' also '*style'
%
% ========================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmptalk}[2008/11/12 v2.98 (Vit Zyka)]
% styles
\DeclareOption{emptytalkstyle}{\AtBeginDocument{\emptytalkstyle}}
\DeclareOption{basetalkstyle}{\AtBeginDocument{\basetalkstyle}}
\DeclareOption{cmpitalkstyle}{\AtBeginDocument{\cmpitalkstyle}}
\DeclareOption{cmpiitalkstyle}{\AtBeginDocument{\cmpiitalkstyle}}
\DeclareOption{cmpztalkstyle}{\AtBeginDocument{\cmpztalkstyle}}
\DeclareOption{cakitalkstyle}{\AtBeginDocument{\cakitalkstyle}}
\DeclareOption{cakiitalkstyle}{\AtBeginDocument{\cakiitalkstyle}}
\DeclareOption{cggitalkstyle}{\AtBeginDocument{\cggitalkstyle}}
\DeclareOption{cggiitalkstyle}{\AtBeginDocument{\cggiitalkstyle}}
\DeclareOption{nologoitalkstyle}{\AtBeginDocument{\nologoitalkstyle}}
\DeclareOption{nologoiitalkstyle}{\AtBeginDocument{\nologoiitalkstyle}}
\DeclareOption{cvutiitalkstyle}{\AtBeginDocument{\cvutiitalkstyle}}
% synonym styles
\DeclareOption{emptystyle}{\AtBeginDocument{\emptytalkstyle}}
\DeclareOption{basestyle}{\AtBeginDocument{\basetalkstyle}}
\DeclareOption{cmpistyle}{\AtBeginDocument{\cmpitalkstyle}}
\DeclareOption{cmpiistyle}{\AtBeginDocument{\cmpiitalkstyle}}
\DeclareOption{cmpzstyle}{\AtBeginDocument{\cmpztalkstyle}}
\DeclareOption{cakistyle}{\AtBeginDocument{\cakitalkstyle}}
\DeclareOption{cakiistyle}{\AtBeginDocument{\cakiitalkstyle}}
\DeclareOption{cggistyle}{\AtBeginDocument{\cggitalkstyle}}
\DeclareOption{cggiistyle}{\AtBeginDocument{\cggiitalkstyle}}
\DeclareOption{nologoistyle}{\AtBeginDocument{\nologoitalkstyle}}
\DeclareOption{nologoiistyle}{\AtBeginDocument{\nologoiitalkstyle}}
\DeclareOption{cvutiistyle}{\AtBeginDocument{\cvutiitalkstyle}}
\newif\ifnoloadhyperref
\newif\ifnoloadgraphicx
\DeclareOption{noloadhyperref}{\noloadhyperreftrue}
\DeclareOption{noloadgraphicx}{\noloadgraphicxtrue}
\newif\ifcmptalkallnotes
\DeclareOption{allnotes}{\cmptalkallnotestrue}
% for compatibility
\DeclareOption{emptystyle}{\AtBeginDocument{\emptytalkstyle}}
\DeclareOption{basestyle}{\AtBeginDocument{\basetalkstyle}}
\DeclareOption{cmpistyle}{\AtBeginDocument{\cmpitalkstyle}}
\DeclareOption{cmpiistyle}{\AtBeginDocument{\cmpiitalkstyle}}
\DeclareOption{cmpzstyle}{\AtBeginDocument{\cmpztalkstyle}}
\DeclareOption{cakistyle}{\AtBeginDocument{\cakitalkstyle}}
\DeclareOption{nothyperref}{\noloadhyperreftrue}
\DeclareOption{printout}{%
  \PassOptionsToPackage{printout}{texpower}%
  \PassOptionsToPackage{printout}{bigfig}}
\newcommand\@ptSize{20}
\DeclareOption{17pt}{\renewcommand\@ptSize{17}}
\DeclareOption{20pt}{\renewcommand\@ptSize{20}}
\DeclareOption{25pt}{\renewcommand\@ptSize{25}}
\DeclareOption{30pt}{\renewcommand\@ptSize{30}}

\newif\ifPDF \ifx\pdfoutput\undefined\else\ifnum\pdfoutput>0 \expandafter\PDFtrue\fi\fi
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{foils}}
\ProcessOptions
\ifPDF
%  \LoadClass[20pt,pdftex,a4paper,landscape]{foils}
  \LoadClass[\@ptSize pt,pdftex,a4paper,landscape]{foils}
\else
%  \LoadClass[20pt,dvips,a4paper,landscape]{foils}
  \LoadClass[\@ptSize pt,dvips,a4paper,landscape]{foils}
\fi

\input{fltfonts-vz.def}
\RequirePackage[T1]{fontenc}

\def\hyperlink#1#2{#2} \let\href=\hyperlink \def\hypertarget#1#2{#2}
\ifPDF
  \ifnoloadhyperref\else%
    \RequirePackage[pdftex,bookmarks=false,pagebackref=false]{hyperref}\fi
  \ifnoloadgraphicx\else\RequirePackage[pdftex]{graphicx}\fi
  \RequirePackage[pdftex]{color}
\else
  \ifnoloadhyperref\else%
    \RequirePackage[dvips,bookmarks=false,pagebackref=false]{hyperref}\fi
  \ifnoloadgraphicx\else\RequirePackage{graphicx}\fi
  \RequirePackage{color}
\fi
\ifnoloadhyperref\else%
  \hypersetup{colorlinks,pdfhighlight=/N,
    citecolor=darkgreen,filecolor=darkyellow,urlcolor=darkblue,
    linkcolor=darkyellow,menucolor=darkyellow,pagecolor=darkyellow,
    pdfcreator=pdfTeX with CMPtalk v2.0; Vit Zyka; CMP; Prague,
    pdfstartpage=1}
\fi
\RequirePackage{amssymb}
\RequirePackage{arpgcell}

\newdimen\hborder    %\hborder=8mm
\newdimen\vborder    %\vborder=\hborder
\newdimen\hmargin    %\hmargin=1em
\newdimen\vmargin    %\vmargin=\hmargin
\def\oldmargin{\hborder=8mm \vborder=\hborder \hmargin=1em \vmargin=\hmargin}
\def\newmargin{\hborder=0pt \vborder=\hborder \hmargin=1em \vmargin=2ex }
\newmargin
\newdimen\headheight \headheight=2cm
\newdimen\hlmargin   \hlmargin=1em
\newdimen\hrmargin   \hrmargin=\hlmargin
\newdimen\vtmargin   \vtmargin=\hlmargin
\newdimen\vbmargin   \vbmargin=\hlmargin
\newdimen\talklinethickness \talklinethickness=1pt
\newdimen\logoopticdelusion \logoopticdelusion=1pt
\paperwidth=297truemm
\paperheight=0.75\paperwidth
\newdimen\slidewidth \slidewidth=\paperwidth \advance\slidewidth by-2\hborder
\newdimen\slideheight\slideheight=\paperheight\advance\slideheight by-2\vborder
\newbox\logobox \setbox\logobox=\hbox{} 
  \ht\logobox=\headheight \wd\logobox=\headheight
  %\setbox\logobox=\hbox{%
  %\includegraphics[height=2cm,hiresbb=true]{cmp}}
\newbox\titleheadbox
\newdimen\colwidth %\colwidth=\wd\CMPbox\advance\colwidth by-2\talklinethickness
\newdimen\windwidth %\windwidth=\slidewidth \advance\windwidth by-\wd\CMPbox
  %\advance\windwidth by-\talklinethickness
\newdimen\windheight %\windheight=\slideheight \advance\windheight by-\ht\CMPbox
  %\advance\windheight by-\talklinethickness
%\textwidth=\windwidth \advance\textwidth by-2\hmargin
%\textheight=\windheight \advance\textheight by-2\vmargin
\newdimen\colheight %\colheight=\windheight \advance\colheight by-2\vmargin
\newdimen\pagecolwidth \pagecolwidth=1em
\newdimen\pagerule \pagerule=1pt
\newcount\pagecolnumber
\parindent=0pt
\raggedright

% Colors
\definecolor{fryellow}{cmyk}{0,0,0.15,0}
\definecolor{frgray}{gray}{0.85}
\definecolor{cmporange}{rgb}{1,0.4,0}         % CMP original logo orange color
\definecolor{cakorange}{rgb}{0.737,0.31,.027} % CAK original orange color
\definecolor{cggorange}{rgb}{0.957,0.4,.2}    % CGG original orange color
\definecolor{cvutblue}{cmyk}{1.0,.43,.0,.0}   % CVUT original blue color
\definecolor{darkgray}{gray}{.2}
\definecolor{darkred}{cmyk}{0,1,1,.5}
\definecolor{darkyellow}{cmyk}{0,0,1,.6}
\definecolor{darkgreen}{cmyk}{1,0,1,.5}
\definecolor{darkblue}{cmyk}{1,1,0,.1}
\definecolor{lightgray}{gray}{.85}
\definecolor{lightred}{cmyk}{0,.15,.15,0}
\definecolor{lightyellow}{cmyk}{0,0,.15,0}
\definecolor{lightgreen}{cmyk}{.15,0,.15,0}
\definecolor{lightblue}{cmyk}{.15,.05,0,0}
%\def\headcolor{black}
%%\def\cmptalkpagecolor{black} %% for new version of texpower
\def\cmptalkthepagecolor{black}
\def\pagemarkerbgrcolor{lightyellow}
\def\thepagemarkerbgrcolor{darkyellow}
\def\thepagebgrcolor{black}
\def\headbgrcolor{white}
\def\pagebgrcolor{white}
\def\cmprulecolor{black}
\def\cmptalkslidetitlecolor{black}
\def\cmptalkslidesubtitlecolor{black}

% --- tmp registers
\newcount\tmpc
\newcount\Tmpc
\newdimen\tmpd
\newdimen\Tmpd

% --- Page counters
\newcount\cmptalkpageno \cmptalkpageno=1

%\def\cmptalkrawslideno{\slideno}
\def\cmptalkrawslideno{\count0 }
\def\cmptalksubslideno{\count1 }

\def\cmptalkgetrawslideno{\the\cmptalkrawslideno}
\def\cmptalkgetslideno{{\cmptalk@increment\cmptalkrawslideno \cmptalkgetrawslideno}}
\def\cmptalkgetsubslideno{\the\cmptalksubslideno }
\def\cmptalkgetpageno{\the\cmptalkpageno}

\let\cmptalkoldslideno=\cmptalkrawslideno

\def\cmptalk@increment#1{\advance#1by1 }
\def\cmptalk@gincrement{\global\cmptalk@increment}

% --- Page slider
\def\pagemarkerbgr{{%\count0=\cmptalkoldslideno
  \advance\count0 by1%
  \immediate\write\@mainaux{%
  \string\defpagemarkerbgr\string{\the\count0\string}%
%  \string\defpagemarkerbgr\string{\cmptalkgetslideno\string}%
  \string{\pagemarkerbgrcolor\string}%
  \string{\thepagemarkerbgrcolor\string}}}}
\def\defpagemarkerbgr#1#2#3{%
  \expandafter\gdef\csname mark#1page\endcsname{#2}%
  \expandafter\gdef\csname themark#1page\endcsname{#3}}
\def\pagemarker#1{{%\count0=\cmptalkoldslideno
  \advance\count0 by1%
  \immediate\write\@mainaux{%
  \string\defpagemarker\string{\the\count0\string}\string{#1\string}}}}
%  \string\defpagemarker\string{\cmptalkgetslideno\string}\string{#1\string}}}}
\def\defpagemarker#1#2{\expandafter\gdef\csname sign#1page\endcsname{#2}}
%\def\ptsizeXVII{17}
%\def\ptsizeXX{20}
%\def\ptsizeXXV{25}
%\def\ptsizeXXX{30}
\def\pagemarkerfonti{\sffamily\bfseries\fontsize{20.74pt}{24pt}\selectfont}
\def\pagemarkerfontii{\sffamily\bfseries\fontsize{17.28pt}{22pt}\selectfont}
\def\pageslideristyle{%
  \def\apcell##1{{\pagemarkerfonti%
    \expandafter\ifx\csname sign\the\appage page\endcsname\relax%
      \nextii{##1}\else\nextii{\csname sign\the\appage page\endcsname}\fi}}
  \def\apcelltype##1{\ifnum\count0=\appage%
      \expandafter\ifx\csname mark\the\appage page\endcsname\relax%
        \def\next{\colorbox{\thepagebgrcolor}}\else%
        \def\next{\colorbox{\csname themark\the\appage page\endcsname}}\fi%
      \def\nextii{\bfseries\textcolor{\cmptalkthepagecolor}}%
    \else\expandafter\ifx\csname mark\the\appage page\endcsname\relax%
        \def\next{\colorbox{\pagebgrcolor}}\else%
        \def\next{\colorbox{\csname mark\the\appage page\endcsname}}\fi%
      \def\nextii{\textcolor{\cmptalkpagecolor}}\fi%
    \shyperlink{talkslide\the\appage.1}{\next{\textcolor{black}{##1}}}}
  \def\apcellframe##1{\colorbox{\thepagebgrcolor}{##1}}}

\def\appendixname{Appendix}

%======================================================================= Styles
\newtoks\talkafterpage
\def\outputpageEmpty{%--------------------------------------------------- Empty
  \hsize=\slidewidth
  \vsize=\slideheight
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in
  \textwidth=\slidewidth
  \textheight=\slideheight
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \global\advance\count0 by 1
  %\offinterlineskip
  \shipout\vbox{\offinterlineskip
    \@begindvi\invsbtLeft\invsbtRight\box\@outputbox\cmptalk@inshipout}%
  \cmptalk@aftershipout
}
\def\setoutputpageBase{%-------------------------------------------------- Base
  \hlmargin=\hmargin \hrmargin=\hmargin \vtmargin=\vmargin \vbmargin=\vmargin
  \slidewidth=\paperwidth   \advance\slidewidth by-2\hborder
  \slideheight=\paperheight \advance\slideheight by-2\vborder
  \windwidth=\slidewidth
  \windheight=\slideheight
  \textwidth=\windwidth
    \advance\textwidth by-\hlmargin \advance\textwidth by-\hrmargin
  \textheight=\windheight
    \advance\textheight by-\vtmargin \advance\textheight by-\vbmargin
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in}
\def\outputpageBase{%
  \cmptalk@managecounters
  \shipout\vbox{\offinterlineskip
    \@begindvi%
    \invsbtLeft\invsbtRight%
    \hbox to\slidewidth{%
      \hskip\hlmargin\hfil%
      \vbox to\slideheight{\hsize=\textwidth\vskip\vtmargin \vfil
        \hypertarget{talkslide\the\cmptalkoldslideno.\the\count1}{}%
%        \hypertarget{page:\the\count0}{}%
        \hypertarget{page:\cmptalkgetpageno}{}%
        \vbox to\textheight{\boxmaxdepth=\maxdepth
          \placeatdef\placeatmmdef\box\@outputbox}%
        \vfil\vskip\vbmargin}%
      \hfil\hskip\hrmargin}%
    \cmptalk@inshipout}%
  \cmptalk@aftershipout
}
%\showboxbreadth=50 \showboxdepth=3
\def\setoutputpageCMPi{%-------------------------------------------------- CMPi
  \setbox\logobox=\hbox{\ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
    \includegraphics[height=\headheight,hiresbb=true]{cmp}}
  %\def\pagemarkerfonti{\sffamily\bfseries}
  \pageslideristyle
  \hlmargin=\hmargin \hrmargin=\hmargin \vtmargin=\vmargin \vbmargin=.5\vmargin
  \talklinethickness=1.4pt
  \pagerule=.5\talklinethickness
  \apvrulewidth=\pagerule
  \aphrulewidth=\pagerule
  \slidewidth=\paperwidth \advance\slidewidth by-2\hborder
  \slideheight=\paperheight\advance\slideheight by-2\vborder
  \windwidth=\slidewidth \advance\windwidth by-.51\wd\logobox
  \windheight=\slideheight \advance\windheight by-\ht\logobox
  \textwidth=\windwidth \advance\textwidth by-\hlmargin
    \advance\textwidth by-\hrmargin
  \textheight=\windheight \advance\textheight by-\vtmargin
    \advance\textheight by-\vbmargin
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in
  \colheight=\windheight
    \advance\colheight by\logoopticdelusion
  \colwidth=.51\wd\logobox %\advance\colwidth by-\talklinethickness
  \pagecolwidth=\colwidth \advance\pagecolwidth by-2\pagerule
  \def\cmptalkpagecolor{black}
  \def\cmptalkthepagecolor{white}
  \def\headbgrcolor{white}
  \def\pagebgrcolor{white}
  \def\pagemarkerbgrcolor{lightyellow}
  \def\thepagebgrcolor{black}
  \def\thepagemarkerbgrcolor{darkyellow}
  \def\labelitemicolor{cmporange}
  \let\headbox=\headboxcmpi}
\def\headboxcmpi{%
  \hbox to\slidewidth{% heading
    \dimen0=\slidewidth \advance\dimen0 by-\wd\logobox
    \advance\dimen0 by-\talklinethickness
    \dimen1=\dimen0 \advance\dimen1 by-\hlmargin \advance\dimen1 by-\hrmargin
    \textcolor{\cmprulecolor}{%
      \vrule width\talklinethickness height\ht\logobox}%
    \fboxsep=0pt\colorbox{\headbgrcolor}{%
      \vbox to\ht\logobox{\hsize=\dimen0
        \textcolor{\cmprulecolor}{%
          \hrule height\talklinethickness width\dimen0}%
        \vskip0pt plus1fil
        \hbox to\dimen0{\hskip\hlmargin%
          \parbox{\dimen1}{\hypertarget{talkslide\the\cmptalkoldslideno.\the\count1}{}%
%            \hypertarget{page:\the\count0}{}%
            \hypertarget{page:\cmptalkgetpageno}{}%
            \color{\cmptalkslidetitlecolor}%
            \centering\reset@font\normalsize\bfseries\the\@slidetitle}%
          \hskip\hrmargin}%
        \vskip-\prevdepth\vskip0pt plus1.2fil
        \hbox{\ignorespaces\textcolor{\cmprulecolor}{%
            \vrule height\talklinethickness width\dimen0}}}}%
    \shref{http://cmp.felk.cvut.cz}{\copy\logobox}}}
\def\outputpagei{% current design
  \cmptalk@managecounters
  \shipout\vbox{\offinterlineskip
    \@begindvi
    \invsbtLeft\invsbtRight%
    \headbox%
    \hbox to\slidewidth{% body
      \hbox to\windwidth{\hskip\hlmargin\hfil%
        \vbox to\windheight{\hsize=\textwidth\vskip\vtmargin \vfil
          \vbox to\textheight{\boxmaxdepth=\maxdepth
            \placeatdef\placeatmmdef\box\@outputbox}%
          \vfil \vskip\vbmargin}%
        \hfil\hskip\hrmargin}%
      \fboxsep=0pt\colorbox{\headbgrcolor}{%
        \hbox to\colwidth{% page column
           \textcolor{\cmprulecolor}{%
             \vrule width\pagerule height\windheight}%
           \vbox to\windheight{\hsize=\pagecolwidth% \unvcopy1
             %\message{ <H=\the\windheight\space W=\the\pagecolwidth>}%
             \ifnum\totalslides>21\pagecolnumber=2\else\pagecolnumber=1\fi%
             \arrangepages{\windheight}{\pagecolwidth}%
                          {\pagecolnumber}{\totalslides}%
           }%  \vskip\vbmargin}%
           \textcolor{\cmprulecolor}{%
             \vrule width\pagerule height\windheight}%
    }}%
    \cmptalk@inshipout
  }%
  %\hrule height\talklinethickness width\slidewidth
  %\@ifpackageloaded{texpower}%
  %  {\message{ <\the\c@step> }}%
  %  {\global\advance\cmptalkoldslideno by 1}%
  \cmptalk@aftershipout
}}
\def\setoutputpageCMPii{%------------------------------------------------- CMPii
  \talklinethickness=1.4pt
  \setbox\logobox=\hbox{\ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
    \includegraphics[height=\headheight,hiresbb=true]{cmp}}
  \def\logourl{http://cmp.felk.cvut.cz}
  \hlmargin=\hmargin \hrmargin=\hmargin \vtmargin=\vmargin \vbmargin=\vmargin
  \slidewidth=\paperwidth   \advance\slidewidth by-2\hborder
  \slideheight=\paperheight \advance\slideheight by-2\vborder
  \windwidth=\slidewidth
  \windheight=\slideheight
  \textwidth=\windwidth
    \advance\textwidth by-\hlmargin \advance\textwidth by-\hrmargin
  \textheight=\windheight
    \advance\textheight by-\vtmargin \advance\textheight by-\vbmargin
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in
  \def\labelitemicolor{cmporange}
  \let\headbox=\headboxcmpii}
\def\outputpageii{%
  \cmptalk@managecounters
  \shipout\vbox{\offinterlineskip
    \@begindvi%
    \invsbtLeft\invsbtRight%
    \hbox to\slidewidth{%
      \hskip\hlmargin\hfil%
      \vbox to\slideheight{\hsize=\textwidth\vskip\vtmargin \vfil
        \hypertarget{talkslide\the\cmptalkoldslideno.\the\count1}{}%
%        \hypertarget{page:\the\count0}{}%
        \hypertarget{page:\cmptalkgetpageno}{}%
        \headbox}%
      \hfil\hskip\hrmargin}%
    \cmptalk@inshipout
  }%
  \cmptalk@aftershipout
}
\def\headboxcmpii{
  \vbox to\textheight{\boxmaxdepth=\maxdepth
    \placeatdef\placeatmmdef%
    {\long\def\putt(##1,##2)##3{\@killglue\raise##2\hunitlength
        \hb@xt@\z@{\kern##1\wunitlength ##3\hss}\ignorespaces}%
      \wunitlength=\textwidth \advance\wunitlength by\hrmargin
      \hunitlength=\textheight\advance\hunitlength by\vtmargin
      \unitlength=.5\wd\logobox
      \begin{picture}(0,0)(0,0)
        \Put(1,1)[rt]{\shref{\logourl}{\copy\logobox}}
        \advance\hunitlength by-\headheight
        \linethickness{\talklinethickness}%
        %\Put(1,1)[rt]{\noBorderLinkAttr\Acrobatmenu{GoToPage}{%
        \Put(1,1)[rt]{\noBorderLinkAttr\Acrobatmenu{ShowThumbs}{%
            \framebox(1,.5){\pagemarkerfontii
              \vrule width0pt height2.5ex\the\cmptalkoldslideno/\the\totalslides}}}
      \end{picture}}%
    \box\@outputbox}%
  \vfil\vskip\vbmargin}

\def\setoutputpageCVUTii{%------------------------------------------------- CVUTii
  \talklinethickness=1.4pt
  \setbox\logobox=\hbox{\ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
    \includegraphics[height=\headheight,hiresbb=true]{logo_cvut}}
  \def\logourl{http://www.cvut.cz}
  \hlmargin=\hmargin \hrmargin=\hmargin \vtmargin=\vmargin \vbmargin=\vmargin
  \slidewidth=\paperwidth   \advance\slidewidth by-2\hborder
  \slideheight=\paperheight \advance\slideheight by-2\vborder
  \windwidth=\slidewidth
  \windheight=\slideheight
  \textwidth=\windwidth
    \advance\textwidth by-\hlmargin \advance\textwidth by-\hrmargin
  \textheight=\windheight
    \advance\textheight by-\vtmargin \advance\textheight by-\vbmargin
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in
  \def\labelitemicolor{cvutblue}
  \let\headbox=\headboxcvutii}
\def\headboxcvutii{
  \vbox to\textheight{\boxmaxdepth=\maxdepth
    \placeatdef\placeatmmdef%
    {\long\def\putt(##1,##2)##3{\@killglue\raise##2\hunitlength
        \hb@xt@\z@{\kern##1\wunitlength ##3\hss}\ignorespaces}%
      \wunitlength=\textwidth \advance\wunitlength by\hrmargin
      \hunitlength=\textheight\advance\hunitlength by\vtmargin
      %\unitlength=.5\wd\logobox
      \unitlength=\wd\logobox
      \begin{picture}(0,0)(0,0)
        \Put(.994,.99)[rt]{\shref{\logourl}{\copy\logobox}}
        \advance\hunitlength by-\headheight
        \linethickness{\talklinethickness}%
        %\Put(1,1)[rt]{\noBorderLinkAttr\Acrobatmenu{GoToPage}{%
        \Put(.994,.99)[rt]{\noBorderLinkAttr\Acrobatmenu{ShowThumbs}{%
            %\framebox(1,.5){\pagemarkerfontii
            \makebox(1,.3){\pagemarkerfontii
              \vrule width0pt height2.5ex\the\cmptalkoldslideno/\the\totalslides}}}
      \end{picture}}%
    \box\@outputbox}%
  \vfil\vskip\vbmargin}

\def\setoutputpageCMPz{%-------------------------------------------------- CMPz
  \setbox\logobox=\hbox{\ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
    \includegraphics[height=\headheight,hiresbb=true]{cmp}}
  \colwidth=\wd\logobox \advance\colwidth by-2\talklinethickness
  \windwidth=\slidewidth \advance\windwidth by-\wd\logobox
  \advance\windwidth by-\talklinethickness
  \windheight=\slideheight \advance\windheight by-\ht\logobox
  \advance\windheight by-\talklinethickness
  \textwidth=\windwidth \advance\textwidth by-2\hmargin
  \textheight=\windheight \advance\textheight by-2\vmargin
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \colheight=\windheight \advance\colheight by-2\vmargin
  \def\labelitemicolor{cmporange}}
\def\outputpageCMPz{% old fashioned design (page bar at left)
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in
  \cmptalk@managecounters
  %
  \shipout\vbox{\offinterlineskip
    \@begindvi%
    \invsbtLeft\invsbtRight%
    \hbox to\slidewidth{%
      {\shref{http://cmp.felk.cvut.cz}{\copy\logobox}}%
      %\ifPDF\pdfannotlink user{/Subtype /Link /A << /Type /Action /S /URI /URI
      %   (http://cmp.felk.cvut.cz) >> }\copy\logobox\pdfendlink%
      %\else\copy\logobox\fi%
      \fboxsep=0pt\colorbox{fryellow}{%
        \vbox to\ht\logobox{\hsize=\windwidth
          \textcolor{\cmprulecolor}{%
            \hrule height\talklinethickness width\windwidth}
          \vfil
          \hbox to\windwidth{\hskip\hmargin%
            %\parbox{\textwidth}{\hypertarget{talkslide\the\cmptalkoldslideno}{}%
            \parbox{\textwidth}{%
              \hypertarget{talkslide\the\cmptalkoldslideno.\the\count1}{}%
%              \hypertarget{page:\the\count0}{}%
              \hypertarget{page:\cmptalkgetpageno}{}%
              \color{\cmptalkslidetitlecolor}%
              \centering\reset@font\large\bfseries\the\@slidetitle}%
            \hskip\hmargin}%
          \vfil
          \textcolor{\cmprulecolor}{%
            \hrule height\talklinethickness width\windwidth}}}%
        \textcolor{\cmprulecolor}{\vrule width\talklinethickness}}%
      \hbox to\slidewidth{%
        \fboxsep=0pt\colorbox{frgray}{%
          \hbox to\wd\logobox{%
           \textcolor{\cmprulecolor}{%
             \vrule width\talklinethickness height\windheight}%
           \setbox0=\hbox{\tiny Machine Perception}%
           \setbox1=\vbox{\hsize=\colwidth \vskip2mm
             \hbox to\colwidth{\hfil\tiny Center for\hfil} \vskip2mm
             \hbox to\colwidth{\hfil\unhcopy0\hfil} \vskip2mm
             \hbox to\colwidth{\hfil\textcolor{\cmprulecolor}{%
                 \vrule height.4\talklinethickness width\wd0}\hfil}}%
           \advance\colheight by-\ht1
           \vbox to\windheight{\hsize=\colwidth \unvcopy1
             \vskip\vmargin \vfil
             \hbox to\colwidth{\hskip.1\hmargin\hfil%
               \rotatebox{90}{\parbox{\colheight}{\raggedright\lineskip=8pt%
                  \reset@font\normalsize\bfseries\the\@talktitle}}%
               \hfil%
               \rotatebox{90}{%
                 \reset@font\small\bfseries\itshape\the\@authorname}%
               \hfil%
               %\hskip.2\hmargin
               \dimen0=\colheight \advance\dimen0 by-\pagerule
                  \divide\dimen0 by\totalslides
               \tmpc=1 \advance\totalslides by1 % cycle for page numbers
               \dimen1=\pagecolwidth \advance\dimen1 by-\pagerule
               \vbox to\colheight{\hsize=\pagecolwidth % slide #
                 \loop\hbox to\pagecolwidth{\textcolor{\cmprulecolor}{%
                       \vrule height\dimen0 width\pagerule}%
                     \ifnum\tmpc=\cmptalkoldslideno\def\next{\colorbox{fryellow}}%
                     \else\def\next{\colorbox{frgray}}\fi%
                     \next{\shyperlink{talkslide\the\cmptalkoldslideno.\the\count1}{%
                     %\next{%
                       \vbox to\dimen0{\hsize=\dimen1
                         \textcolor{\cmprulecolor}{%
                           \hrule height\pagerule\footnotesize}
                         \vfil\hbox to\dimen1{\hfil\the\tmpc\hfil}\vfil}%
                       %\ifnum\tmpc=\cmptalkoldslideno%
                       % \textcolor{white}{\hbox to0pt{\textcolor{\cmprulecolor}%
                       % {\vrule height\dimen0 width\linethicknes}\hss}}\fi%
                     }}}%
                   \vfil\advance\tmpc by1
                 \ifnum\tmpc<\totalslides\repeat%
%                   \hbox to\pagecolwidth{\leaders\textcolor{\cmprulecolor}{%
%}}%                       \hrule height\pagerule}\hfil}}}
                   \hbox to\pagecolwidth{\textcolor{\cmprulecolor}{%
                       \leaders\hrule height\pagerule\hfil}}}}
             \vskip\vmargin}%
           \textcolor{\cmprulecolor}{%
             \vrule width\talklinethickness height\windheight}%
          }%
        }% \fbox
      \hbox to\windwidth{\hfil%
        \vbox to\windheight{\vfill
          \vbox to\textheight{\boxmaxdepth=\maxdepth
            \placeatdef\placeatmmdef\box\@outputbox}\vfill}%
        \hfil}%
      \textcolor{\cmprulecolor}{%
        \vrule width\talklinethickness height\windheight}%
    }%
  %\textcolor{\cmprulecolor}{
    \hrule height\talklinethickness width\slidewidth%}
  %\global\advance\cmptalkoldslideno by 1
    \cmptalk@inshipout
  }%
  \cmptalk@aftershipout
}
\def\setoutputpageCAKi{%-------------------------------------------------- CAKi
  \setbox\logobox=\hbox{\fboxsep=0pt\fboxrule=\talklinethickness\fbox{%
      \textcolor{cakorange}{%
        \ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
        \includegraphics[height=\headheight]{cak}}}}%
  \dp\logobox=0pt
  \def\logourl{http://c-a-k.cz}
 %\def\pagemarkerfonti{\sffamily\bfseries}
  \pageslideristyle
%   \def\apcell##1{{\sffamily\bfseries%
%     \expandafter\ifx\csname sign\the\appage page\endcsname\relax%
%       \nextii{##1}\else\nextii{\csname sign\the\appage page\endcsname}\fi}}
%   \def\apcelltype##1{\ifnum\count0=\appage%
%       \expandafter\ifx\csname mark\the\appage page\endcsname\relax%
%         \def\next{\colorbox{\thepagebgrcolor}}\else%
%         \def\next{\colorbox{\csname themark\the\appage page\endcsname}}\fi%
%       \def\nextii{\bfseries\textcolor{\cmptalkthepagecolor}}%
%     \else\expandafter\ifx\csname mark\the\appage page\endcsname\relax%
%         \def\next{\colorbox{\pagebgrcolor}}\else%
%         \def\next{\colorbox{\csname mark\the\appage page\endcsname}}\fi%
%       \def\nextii{\textcolor{\cmptalkpagecolor}}\fi%
%     \shyperlink{talkslide\the\appage}{\next{\textcolor{black}{##1}}}}
% %   \def\apcelltype##1{\ifnum\count0=\appage%
% %       \def\next{\colorbox{\thepagebgrcolor}}%
% %       \def\nextii{\bfseries\textcolor{\cmptalkthepagecolor}}%
% %     \else\expandafter\ifx\csname mark\the\appage page\endcsname\relax%
% %         \def\next{\colorbox{\pagebgrcolor}}\else%
% %         \def\next{\colorbox{\pagemarkerbgrcolor}}\fi%
% %       \def\nextii{\textcolor{\cmptalkpagecolor}}\fi%
% %     \shyperlink{talkslide\the\appage}{\next{\textcolor{black}{##1}}}}
%   \def\apcellframe##1{\colorbox{\thepagebgrcolor}{##1}}
  \hlmargin=\hmargin \hrmargin=\hmargin \vtmargin=\vmargin \vbmargin=.5\vmargin
  %\hlmargin=0em \hrmargin=\hborder \vtmargin=2\hrmargin \vbmargin=0em
  \talklinethickness=1.4pt
  \pagerule=.5\talklinethickness
  \apvrulewidth=\pagerule
  \aphrulewidth=\pagerule
  %\hlmargin=0pt \vtmargin=1ex \vbmargin=0pt
  \slidewidth=\paperwidth \advance\slidewidth by-2\hborder
  \slideheight=\paperheight\advance\slideheight by-2\vborder
  \windwidth=\slidewidth \advance\windwidth by-\wd\logobox
  \windheight=\slideheight \advance\windheight by-\ht\logobox
  \textwidth=\windwidth \advance\textwidth by-\hlmargin
    \advance\textwidth by-\hrmargin
  \textheight=\windheight \advance\textheight by-\vtmargin
    \advance\textheight by-\vbmargin
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in
  \colheight=\windheight
    \advance\colheight by\logoopticdelusion
  \colwidth=\wd\logobox %\advance\colwidth by-\talklinethickness
  \pagecolwidth=\colwidth \advance\pagecolwidth by-2\pagerule
  \def\cmptalkpagecolor{black}
  \def\cmptalkthepagecolor{white}
  \def\headbgrcolor{white}
  \def\pagebgrcolor{white}
  \def\pagemarkerbgrcolor{lightyellow}
  \def\thepagebgrcolor{black}
  \def\thepagemarkerbgrcolor{darkyellow}
  \def\labelitemicolor{cakorange}
  \let\headbox=\headboxcmpi}
% \def\outputpageCAKi{% current design
%   \hsize=\slidewidth
%   \vsize=\slideheight
%   \hoffset=\hborder \advance\hoffset by-1in
%   \voffset=\vborder \advance\voffset by-1in
%   \global\advance\count0 by 1
%   %
%    \shipout\vbox{\offinterlineskip
%      \hbox to\slidewidth{% heading
%        \dimen0=\slidewidth \advance\dimen0 by-\wd\logobox
%        \advance\dimen0 by-\talklinethickness
%        \dimen1=\dimen0 \advance\dimen1 by-\hlmargin \advance\dimen1 by-\hrmargin
%        %\textcolor{\cmprulecolor}{%
%          \vrule width\talklinethickness height\ht\logobox depth0pt%}%
%        %\fboxsep=0pt\colorbox{\headbgrcolor}{%
%          \vbox to\ht\logobox{\hsize=\dimen0
%            %\textcolor{\cmprulecolor}{%
%              \hrule height\talklinethickness width\dimen0 depth0pt%}%
%            \vfill
%            \hbox to\dimen0{\hskip\hlmargin%
%              \parbox{\dimen1}{\hypertarget{talkslide\the\cmptalkoldslideno}{}%
%                 \centering\reset@font\large\bfseries\the\@slidetitle}%
%              \hskip\hrmargin}
%            \vfill
%            %\hbox{\ignorespaces%\textcolor{\cmprulecolor}{%
%              \hrule height\talklinethickness width\dimen0 depth0pt}%}}%}%
%       \shref{http://www.c-a-k.cz/}{\copy\logobox}}%
%     \hbox to\slidewidth{% body 
%       \hbox to\windwidth{\hskip\hlmargin\hfil%
%         \vbox to\windheight{\hsize=\textwidth\vskip\vtmargin \vfil
%           \vbox to\textheight{\boxmaxdepth=\maxdepth\box\@outputbox}%
%           \vfil \vskip\vbmargin}%
%         \hfil\hskip\hrmargin}%
%       \fboxsep=0pt\colorbox{\headbgrcolor}{%
%         \hbox to\colwidth{% page column
%            \textcolor{\cmprulecolor}{%
%              \vrule width\pagerule height\windheight depth0pt}%
%            \vbox to\windheight{\hsize=\pagecolwidth% \unvcopy1
%              %\message{ <H=\the\windheight\space W=\the\pagecolwidth>}%
%              \ifnum\totalslides>20\pagecolnumber=2\else\pagecolnumber=1\fi%
%              \arrangepages{\windheight}{\pagecolwidth}%
%                           {\pagecolnumber}{\totalslides}%
%              \vskip\vbmargin}%
%            \textcolor{\cmprulecolor}{%
%              \vrule width\pagerule height\windheight depth0pt}%
%           }}%
%       }%
%   }}
\def\setoutputpageCAKii{%------------------------------------------------- CAKii
  \talklinethickness=1.4pt
  \setbox\logobox=\hbox{\fboxsep=0pt\fboxrule=\talklinethickness{%
        \ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
        \includegraphics[height=\headheight]{cak}}}%
  \def\logourl{http://c-a-k.cz}
  \hlmargin=\hmargin \hrmargin=\hmargin \vtmargin=\vmargin \vbmargin=\vmargin
  \slidewidth=\paperwidth   \advance\slidewidth by-2\hborder
  \slideheight=\paperheight \advance\slideheight by-2\vborder
  \windwidth=\slidewidth
  \windheight=\slideheight
  \textwidth=\windwidth
    \advance\textwidth by-\hlmargin \advance\textwidth by-\hrmargin
  \textheight=\windheight
    \advance\textheight by-\vtmargin \advance\textheight by-\vbmargin
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in
  \def\labelitemicolor{cakorange}
  \let\headbox=\headboxcakii}
\def\headboxcakii{
  \vbox to\textheight{\boxmaxdepth=\maxdepth
    \placeatdef\placeatmmdef%
    {\long\def\putt(##1,##2)##3{\@killglue\raise##2\hunitlength
        \hb@xt@\z@{\kern##1\wunitlength ##3\hss}\ignorespaces}%
      \wunitlength=\textwidth \advance\wunitlength by\hrmargin
      \hunitlength=\textheight\advance\hunitlength by\vtmargin
      \unitlength=.5\wd\logobox
      \begin{picture}(0,0)(0,0)
        \Put(1,1)[rt]{\shref{\logourl}{\copy\logobox}}
        \advance\hunitlength by-\headheight
        \Put(1,1)[rt]{\noBorderLinkAttr\Acrobatmenu{ShowThumbs}{%
            \makebox(2,.5){\pagemarkerfontii
              \vrule width0pt height2.5ex\the\cmptalkoldslideno/\the\totalslides}}}
      \end{picture}}%
    \box\@outputbox}
  \vfil\vskip\vbmargin}

\def\setoutputpageCGGi{%------------------------------------------------- CGGi
  \setbox\logobox=\hbox{\fboxsep=0pt\fboxrule=\talklinethickness{%
        \ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
        \includegraphics[height=\headheight]{logo_cgg}}}%
  \dp\logobox=0pt
  %\def\pagemarkerfonti{\sffamily\bfseries\footnotesize}
  \pageslideristyle
%   \def\apcell##1{{\sffamily\bfseries%
%     \expandafter\ifx\csname sign\the\appage page\endcsname\relax%
%       \nextii{##1}\else\nextii{\csname sign\the\appage page\endcsname}\fi}}
%   \def\apcelltype##1{\ifnum\count0=\appage%
%       \expandafter\ifx\csname mark\the\appage page\endcsname\relax%
%         \def\next{\colorbox{\thepagebgrcolor}}\else%
%         \def\next{\colorbox{\csname themark\the\appage page\endcsname}}\fi%
%       \def\nextii{\bfseries\textcolor{\cmptalkthepagecolor}}%
%     \else\expandafter\ifx\csname mark\the\appage page\endcsname\relax%
%         \def\next{\colorbox{\pagebgrcolor}}\else%
%         \def\next{\colorbox{\csname mark\the\appage page\endcsname}}\fi%
%       \def\nextii{\textcolor{\cmptalkpagecolor}}\fi%
%     \shyperlink{talkslide\the\appage}{\next{\textcolor{black}{##1}}}}
%   \def\apcellframe##1{\colorbox{\thepagebgrcolor}{##1}}
  \hlmargin=\hmargin \hrmargin=\hmargin \vtmargin=\vmargin \vbmargin=.5\vmargin
  \talklinethickness=1.4pt
  \pagerule=.5\talklinethickness
  \apvrulewidth=\pagerule
  \aphrulewidth=\pagerule
  \slidewidth=\paperwidth \advance\slidewidth by-2\hborder
  \slideheight=\paperheight\advance\slideheight by-2\vborder
  \windwidth=\slidewidth \advance\windwidth by-.5\wd\logobox
  \windheight=\slideheight \advance\windheight by-\ht\logobox
  \textwidth=\windwidth \advance\textwidth by-\hlmargin
    \advance\textwidth by-\hrmargin
  \textheight=\windheight \advance\textheight by-\vtmargin
    \advance\textheight by-\vbmargin
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in
  \colheight=\windheight
    \advance\colheight by\logoopticdelusion
  \colwidth=.5\wd\logobox %\advance\colwidth by-\talklinethickness
  \pagecolwidth=\colwidth \advance\pagecolwidth by-2\pagerule
  \def\cmptalkpagecolor{black}
  \def\cmptalkthepagecolor{black}
  \def\headbgrcolor{lightgray}
  \def\pagebgrcolor{white}
  \def\pagemarkerbgrcolor{lightyellow}
  \def\thepagebgrcolor{lightgray}
  \def\thepagemarkerbgrcolor{darkyellow}
  \def\labelitemicolor{cggorange}
  \let\headbox=\headboxcggi}
\def\headboxcggi{%
  \hbox to\slidewidth{% heading
    \dimen0=\slidewidth \advance\dimen0 by-\wd\logobox
    %\advance\dimen0 by-\talklinethickness
    \dimen1=\dimen0 \advance\dimen1 by-\hlmargin \advance\dimen1 by-\hrmargin
    %\textcolor{\cmprulecolor}{%
    %  \vrule width\talklinethickness height\ht\logobox}%
    \vrule width0pt height\ht\logobox%
    \fboxsep=0pt\colorbox{\headbgrcolor}{%
      \vbox to\ht\logobox{\hsize=\dimen0
        %\textcolor{\cmprulecolor}{%
        %  \hrule height\talklinethickness width\dimen0}%
        \vskip0pt plus1fil
        \hbox to\dimen0{\hskip\hlmargin%
          \parbox{\dimen1}{\hypertarget{talkslide\the\cmptalkoldslideno.\the\count1}{}%
%            \hypertarget{page:\the\count0}{}%
            \hypertarget{page:\cmptalkgetpageno}{}%
            \color{\cmptalkslidetitlecolor}%
            \centering\reset@font\normalsize\bfseries\the\@slidetitle}%
          \hskip\hrmargin}%
        \vskip-\prevdepth\vskip0pt plus1.2fil
        \hbox{\ignorespaces\textcolor{\cmprulecolor}{%
            \vrule height\talklinethickness width\dimen0}}}}%
    \shref{http://www.cgg.cvut.cz}{\copy\logobox}}}
\def\setoutputpageCGGii{%------------------------------------------------- CGGii
  \talklinethickness=1.4pt
  %\setbox\logobox=\hbox{\ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
  %  \includegraphics[height=\headheight,hiresbb=true]{cmp}}
  \setbox\logobox=\hbox{\fboxsep=0pt\fboxrule=\talklinethickness{%
        \ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
        \includegraphics[height=\headheight]{logo_cgg}}}%
  \def\logourl{http://www.cgg.cvut.cz}
  \hlmargin=\hmargin \hrmargin=\hmargin \vtmargin=\vmargin \vbmargin=\vmargin
  \slidewidth=\paperwidth   \advance\slidewidth by-2\hborder
  \slideheight=\paperheight \advance\slideheight by-2\vborder
  \windwidth=\slidewidth
  \windheight=\slideheight
  \textwidth=\windwidth
    \advance\textwidth by-\hlmargin \advance\textwidth by-\hrmargin
  \textheight=\windheight
    \advance\textheight by-\vtmargin \advance\textheight by-\vbmargin
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in
  \def\labelitemicolor{cggorange}
  \let\headbox=\headboxcggii}
\def\headboxcggii{
  \vbox to\textheight{\boxmaxdepth=\maxdepth
    \placeatdef\placeatmmdef%
    {\long\def\putt(##1,##2)##3{\@killglue\raise##2\hunitlength
        \hb@xt@\z@{\kern##1\wunitlength ##3\hss}\ignorespaces}%
      \wunitlength=\textwidth \advance\wunitlength by\hrmargin
      \hunitlength=\textheight\advance\hunitlength by\vtmargin
      \unitlength=.5\wd\logobox
      \begin{picture}(0,0)(0,0)
        \Put(1,1)[rt]{\shref{\logourl}{\copy\logobox}}
        \advance\hunitlength by-\headheight
        %\linethickness{\talklinethickness}%
        \Put(1,1)[rt]{\noBorderLinkAttr\Acrobatmenu{ShowThumbs}{%
        %\Put(1,1)[rt]{\noBorderLinkAttr\Acrobatmenu{GoToPage}{%
            %\framebox(1,.5){\pagemarkerfontii
            \makebox(2,.5){\pagemarkerfontii
              \vrule width0pt height2.5ex\the\cmptalkoldslideno/\the\totalslides}}}
      \end{picture}}%
    \box\@outputbox}
  \vfil\vskip\vbmargin}

\def\setoutputpagenologoi{%------------------------------------------------- nologoi
  \setbox\logobox=\hbox{%
%    \fboxsep=0pt\fboxrule=\talklinethickness{%
%        \ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
%        \includegraphics[height=\headheight]{logo_cgg}}
}%
  \dp\logobox=0pt
  \ht\logobox=\headheight
  \wd\logobox=2cm
  \pageslideristyle
  \hlmargin=\hmargin \hrmargin=\hmargin \vtmargin=\vmargin \vbmargin=.5\vmargin
  \talklinethickness=1.4pt
  \pagerule=.5\talklinethickness
  \apvrulewidth=\pagerule
  \aphrulewidth=\pagerule
  \slidewidth=\paperwidth \advance\slidewidth by-2\hborder
  \slideheight=\paperheight\advance\slideheight by-2\vborder
  \windwidth=\slidewidth \advance\windwidth by-\wd\logobox
  \windheight=\slideheight \advance\windheight by-\ht\logobox
  \textwidth=\windwidth \advance\textwidth by-\hlmargin
    \advance\textwidth by-\hrmargin
  \textheight=\windheight \advance\textheight by-\vtmargin
    \advance\textheight by-\vbmargin
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in
  \colheight=\paperheight%\windheight
%    \advance\colheight by\headheight
  \colwidth=\wd\logobox %\advance\colwidth by-\talklinethickness
  \pagecolwidth=\colwidth \advance\pagecolwidth by-2\pagerule
  \def\cmptalkpagecolor{black}
  \def\cmptalkthepagecolor{black}
  \def\headbgrcolor{white}
  \def\pagebgrcolor{white}
  \def\pagemarkerbgrcolor{lightyellow}
  \def\thepagebgrcolor{lightgray}
  \def\thepagemarkerbgrcolor{darkyellow}
  \def\labelitemicolor{cmporange}
  \let\headbox=\headboxnologoi}
\def\headboxnologoi{%
  \hbox to\slidewidth{% heading
    \dimen0=\slidewidth \advance\dimen0 by-\wd\logobox
    \dimen1=\dimen0 \advance\dimen1 by-\hlmargin \advance\dimen1 by-\hrmargin
    \vrule width0pt height\ht\logobox%
    \fboxsep=0pt\colorbox{\headbgrcolor}{%
      \vbox to\ht\logobox{\hsize=\dimen0
%      \vbox to\headheight{\hsize=\dimen0
        \vskip0pt plus1fil
        \hbox to\dimen0{\hskip\hlmargin%
          \parbox{\dimen1}{\hypertarget{talkslide\the\cmptalkoldslideno.\the\count1}{}%
            \hypertarget{page:\cmptalkgetpageno}{}%
            \color{\cmptalkslidetitlecolor}%
            \centering\reset@font\normalsize\bfseries\the\@slidetitle}%
          \hskip\hrmargin}%
        \vskip-\prevdepth\vskip0pt plus1.2fil
        \hbox{\ignorespaces\textcolor{\cmprulecolor}{%
            \vrule height\talklinethickness width\dimen0}}}}%
%    \shref{http://www.cgg.cvut.cz}{\copy\logobox}%
}}
\def\outputpagenologoi{% current design
  \cmptalk@managecounters
  \shipout\vbox{\offinterlineskip
    \@begindvi
    \invsbtLeft\invsbtRight
    \headbox
    \hbox to\slidewidth{% body
      \hbox to\windwidth{\hskip\hlmargin\hfil%
        \vbox to\windheight{\hsize=\textwidth\vskip\vtmargin \vfil
          \vbox to\textheight{\boxmaxdepth=\maxdepth
            \placeatdef\placeatmmdef\box\@outputbox}%
          \vfil \vskip\vbmargin}%
        \hfil\hskip\hrmargin}%
%      \vbox to\windheight{\hsize=\colwidth%
      \vbox{%\hsize=\colwidth%
      \vskip-2.7cm%\headheight % !!!! magic (do not know why headheight is not enought)
%      \vskip-\ht\logobox\vskip-\topskip
      \fboxsep=0pt\colorbox{\headbgrcolor}{%
        \hbox to\colwidth{% page column
           \textcolor{\cmprulecolor}{%
             \vrule width\pagerule height\paperheight}%
           \vbox to\paperheight{\hsize=\pagecolwidth% \unvcopy1
             %\message{ <H=\the\windheight\space W=\the\pagecolwidth>}%
             \ifnum\totalslides>21\pagecolnumber=2\else\pagecolnumber=1\fi%
             \arrangepages{\paperheight}{\pagecolwidth}%
                          {\pagecolnumber}{\totalslides}%
           }%  \vskip\vbmargin}%
           \textcolor{\cmprulecolor}{%
             \vrule width\pagerule height\paperheight}%
          }}%
      \vss}%
    }%
    %\hrule height\talklinethickness width\slidewidth
    %\@ifpackageloaded{texpower}%
    %  {\message{ <\the\c@step> }}%
    %  {\global\advance\cmptalkoldslideno by 1}%
    \cmptalk@inshipout
  }%
  \cmptalk@aftershipout
}
\def\setoutputpagenologoii{%------------------------------------------------- nologoii
  \talklinethickness=1.4pt
  %\setbox\logobox=\hbox{\ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
  %  \includegraphics[height=\headheight,hiresbb=true]{cmp}}
  \setbox\logobox=\hbox{%\fboxsep=0pt\fboxrule=\talklinethickness{%
%        \ifx\Ginclude@graphicsnew\undefined\else\bigfigfalse\fi%
%        \includegraphics[height=\headheight]{logo_cgg}}
}%
  \dp\logobox=0pt
  \ht\logobox=\headheight
  \wd\logobox=0cm
  \def\logourl{}
  \hlmargin=\hmargin \hrmargin=\hmargin \vtmargin=\vmargin \vbmargin=\vmargin
  \slidewidth=\paperwidth   \advance\slidewidth by-2\hborder
  \slideheight=\paperheight \advance\slideheight by-2\vborder
  \windwidth=\slidewidth
  \windheight=\slideheight
  \textwidth=\windwidth
    \advance\textwidth by-\hlmargin \advance\textwidth by-\hrmargin
  \textheight=\windheight
    \advance\textheight by-\vtmargin \advance\textheight by-\vbmargin
  \hsize=\textwidth  \linewidth=\textwidth
  \vsize=\textheight \@colroom=\textheight \@colht=\textheight
  \hoffset=\hborder \advance\hoffset by-1in
  \voffset=\vborder \advance\voffset by-1in
  \def\labelitemicolor{cmporange}
  \let\headbox=\headboxnologoii}
\def\headboxnologoii{
  \vbox to\textheight{\boxmaxdepth=\maxdepth
    \placeatdef\placeatmmdef%
    {\long\def\putt(##1,##2)##3{\@killglue\raise##2\hunitlength
        \hb@xt@\z@{\kern##1\wunitlength ##3\hss}\ignorespaces}%
      \wunitlength=\textwidth \advance\wunitlength by\hrmargin
      \hunitlength=\textheight\advance\hunitlength by\vtmargin
      \unitlength=1cm%.5\wd\logobox
      \begin{picture}(0,0)(0,0)
        %\Put(1,1)[rt]{\shref{\logourl}{\copy\logobox}}
        %\advance\hunitlength by-\headheight
        %\linethickness{\talklinethickness}%
        \Put(1,1)[rt]{\noBorderLinkAttr\Acrobatmenu{ShowThumbs}{%
        %\Put(1,1)[rt]{\noBorderLinkAttr\Acrobatmenu{GoToPage}{%
            \fbox{\pagemarkerfontii
            %\framebox(1,.5){\pagemarkerfontii
            %\makebox(2,.5){\pagemarkerfontii
              \vrule width0pt height2.5ex\the\cmptalkoldslideno/\the\totalslides}}}
      \end{picture}}%
    \box\@outputbox}
  \vfil\vskip\vbmargin}

% --- general macro for output
% \def\cmptalk@managecounters{%
%   \global\advance\count0 by 1
%   \ifx\c@stepsperformed\undefined
%     \global\advance\cmptalkoldslideno by 1
%   \else%
%     \ifnum\c@step>\memlaststep
%       \global\advance\count1 by 1
%     \else%
%       %\global\count1=1
%       %\ifcmptalkpausestep\else\global\count1=1\relax\fi%
%       \global\advance\cmptalkoldslideno by 1
%     \fi%
%     \xdef\memlaststep{\the\c@step}%
%   \fi%
%}
\def\cmptalk@managecounters{%
  \cmptalk@gincrement\cmptalkrawslideno
  \ifx\c@stepsperformed\undefined
    \cmptalk@gincrement\slideno
  \else%
    \ifnum\c@step>\memlaststep
      {\ifthenelse{\boolean{display}}%
        {\cmptalk@gincrement\cmptalksubslideno}{}}%
    \else%
      \cmptalk@gincrement\slideno
    \fi%
    \xdef\memlaststep{\the\c@step}%
  \fi%
}

\def\cmptalk@aftershipout{%
  \the\talkafterpage\talkafterpage={}%
  \cmptalk@gincrement\cmptalkpageno
}

\def\cmptalk@inshipout{%
  \hbox{\placeatmmeveryslidedef\placeateveryslidedef}%
}

%-------------------------------------------------------------------- SetStyles
\def\emptytalkstyle{\message{ <Empty output page set.> }%
  \def\cmptalk@style{empty}\let\@outputpage=\outputpageEmpty}
\def\basetalkstyle{\message{ <Base output page set.> }%
  \def\cmptalk@style{base}\let\@outputpage=\outputpageBase\setoutputpageBase}
\def\cmpitalkstyle{\message{ <CMPi output page set.> }%
  \def\cmptalk@style{cmpi}\let\@outputpage=\outputpagei\setoutputpageCMPi}
\def\cmpiitalkstyle{\message{ <CMPii output page set.> }%
  \def\cmptalk@style{cmpii}\let\@outputpage=\outputpageii\setoutputpageCMPii}
\def\cvutiitalkstyle{\message{ <CVUTii output page set.> }%
  \def\cmptalk@style{cvutii}\let\@outputpage=\outputpageii\setoutputpageCVUTii}
\def\cakitalkstyle{\message{ <CAKi output page set.> }%
  \def\cmptalk@style{caki}\let\@outputpage=\outputpagei\setoutputpageCAKi}
\def\cakiitalkstyle{\message{ <CAKii output page set.> }%
  \def\cmptalk@style{cakii}\let\@outputpage=\outputpageii\setoutputpageCAKii}
\def\cggitalkstyle{\message{ <CGGi output page set.> }%
  \def\cmptalk@style{cggi}\let\@outputpage=\outputpagei\setoutputpageCGGi}
\def\cggiitalkstyle{\message{ <CGGii output page set.> }%
  \def\cmptalk@style{cggii}\let\@outputpage=\outputpageii\setoutputpageCGGii}
\def\nologoitalkstyle{\message{ <nologoi output page set.> }%
  \def\cmptalk@style{nologoi}\let\@outputpage=\outputpagenologoi\setoutputpagenologoi}
\def\nologoiitalkstyle{\message{ <nologoii output page set.> }%
  \def\cmptalk@style{nologoii}\let\@outputpage=\outputpageii\setoutputpagenologoii}
\def\cmpztalkstyle{\message{ <CMPz output page set.> }%
  \def\cmptalk@style{cmpz}\let\@outputpage=\outputpageCMPz\setoutputpageCMPz}

\let\emptystyle\emptytalkstyle
\let\basestyle\basetalkstyle
\let\cmpistyle\cmpitalkstyle
\let\cmpiistyle\cmpiitalkstyle
\let\cvutiistyle\cvutiitalkstyle
\let\cakistyle\cakitalkstyle
\let\cakiistyle\cakiitalkstyle
\let\cggistyle\cggitalkstyle
\let\cggiistyle\cggiitalkstyle
\let\nologoistyle\nologoitalkstyle
\let\nologoiistyle\nologoiitalkstyle
\let\cmpzstyle\cmpztalkstyle

\def\settalkstyle#1{\csname#1talkstyle\endcsname}
\let\bigfigoutputpage=\outputpageEmpty
\basetalkstyle

%############################################################### General macros
\def\talksoftinput#1{\openin0=#1 \ifeof0\else\input #1 \fi}

\newtoks\@slidetitle \@slidetitle={} \def\theslidetitle{\the\@slidetitle}
  \def\slidetitle#1{\@slidetitle={#1}} \slidetitle{\hfil}
\newtoks\@talktitle \@talktitle={} \def\thetalktitle{\the\@talktitle}
  \def\talktitle#1{\@talktitle={#1}}
  \let\title=\talktitle \let\thetitle=\thetalktitle
\newtoks\@authorname \@authorname={} \def\thetalkauthorname{\the\@authorname}
  \def\authorname#1{\@authorname={#1}} 
  \let\author=\authorname \let\theauthor=\thetalkauthorname
\newtoks\@talkaffiliation \@talkaffiliation={}
  \def\thetalkaffiliation{\the\@talkaffiliation}
  \def\talkaffiliation#1{\@talkaffiliation={#1}}
  \let\affiliation=\talkaffiliation \let\theaffiliation=\thetalkaffiliation
\newtoks\@talkacknowledgement \@talkacknowledgement={}
  \def\thetalkacknowledgement{\the\@talkacknowledgement}
  \def\talkacknowledgement#1{\@talkacknowledgement={#1}}
  \let\acknowledgement=\talkacknowledgement \let\theacknowledgement=\thetalkacknowledgement
\newtoks\@talklogo \@talklogo={} \def\thetalklogo{\the\@talklogo}
  \def\talklogo#1{\@talklogo={#1}}

\newcount\sectno
\newcount\subsectno
\def\@foilhead[#1]#2{\vfil\eject
  %\global\advance\slideno by1
  %\global\advance\subsectno by1
  \slidetitle{#2}}%\hrule height0pt}%\vskip-\baselineskip}
\def\talkhead{\@ifnextchar[{\@talkhead}{\@talkhead[]}}
%\def\talkhead{\futurelet\next\@@talkhead}
%\def\@@talkhead{\def\tmp{[}%
%  \ifx\next\tmp\def\next{\@talkhead}%
%  \else\def\next{\@talkhead[]}\fi\next}
%%% Changes with new syntax (2005-05-03)
%\def\@talkhead[#1]#2{\vfil\eject#1\slidetitle{#2}\global\subsectno=1
%  \ifPDF{\advance\slideno by1\pdfoutline goto name{talkslide\the\cmptalkoldslideno.1} 
%    count 0{\the\@slidetitle}}\fi%
%  {\def\tmp{cmpii}\ifx\cmptalk@style\tmp\cmptalk@headboxii\fi%
%   \def\tmp{cakii}\ifx\cmptalk@style\tmp\cmptalk@headboxii\fi}}
%  %\pdfbookmark{\the\@slidetitle}{talkslide\the\cmptalkoldslideno}}
\def\@talkhead[#1]#2{%
  \vfil\eject#1
  \cmptalk@slide@init{#2}%
  \cmptalk@slide@pdf
  \cmptalk@slide@type
}
\def\cmptalk@headboxii{\dimen0=\textwidth \advance\dimen0 by-\wd\logobox%
  \global\setbox\titleheadbox=\hbox{\parbox[c][\ht\logobox][c]{\dimen0}{%
%      \centering\reset@font\large\bfseries\the\@slidetitle}}%
      \color{\cmptalkslidetitlecolor}%
      \centering\reset@font\large\bfseries\boldmath\the\@slidetitle}}%
  %\global\advance\vsize by-\ht\titleheadbox
  \box\titleheadbox}

\AtBeginDocument{%
  \ifPDF\pdfoutline goto name{talkslide1.1} count 0{First page}\fi}
\AtEndDocument{\ifPDF\pdfoutline goto name{talkslide\the\totalslides.1}
  count 0{Last page}\fi}
\let\foilhead=\talkhead
\let\slidehead=\talkhead
\def\subhead#1{\global\advance\subsectno by1
  \bgroup\color{\cmptalkslidesubtitlecolor}\bfseries\boldmath#1\egroup
  \par
}

%-------------------------------------------------------------------- maketitle
\newskip\cmptalkpretitlepageskip \cmptalkpretitlepageskip=0pt

\def\@maketitle{\newpage
  %\zerolistvertdimens
  \null\medskip
  \begin{center}
     \vskip\cmptalkpretitlepageskip
     {\Large\bfseries \the\@talktitle \par}
     %\vskip\titleauthorskip
     {\smallskip%\lineskip \authorauthorskip
       \begin{tabular}[t]{c}\the\@authorname\end{tabular}
       \par}
     \medskip
     {\the\@talkaffiliation\par}
     {\itshape\the\@talkacknowledgement\par}
  \end{center}
  \cmptalk@note@checkallnotes
  \par\vfil}
\def\talktitlepagetitle{% VZ 08-10-24
  \vskip\cmptalkpretitlepageskip
  \vskip0pt plus.33fill
  {\Large\bfseries \the\@talktitle \par}
  \smallskip{\begin{tabular}[t]{c}\the\@authorname\end{tabular}\par}
  \bigskip{\the\@talkaffiliation\par}
  \bigskip{\itshape\the\@talkacknowledgement\par}
  \bigskip\the\@talklogo
  \vfill
  \par
}
\def\maketalktitlepage{%
  \begin{talktitlepage}
    \talktitlepagetitle
  \end{talktitlepage}}
\let\titlepage=\maketalktitlepage
\def\talktitlepage{\newpage
  \let\tmptalkslide=\cmptalk@style
  \basetalkstyle\talkafterpage={\settalkstyle{\tmptalkslide}}%
  \null\bigskip % VZ 08-10-25
  \begin{center}}
\def\endtalktitlepage{%
  \end{center}
  \cmptalk@note@checkallnotes
  \par\vfil\newpage
}

% Page numbering
\count1=1
\def\memlaststep{0}
\newcount\slideno \slideno=0
\newcount\totalslides \totalslides=1
\def\settotalslides#1{\global\totalslides=#1 }
\setcounter{page}{0}
\AtEndDocument{\vfil\clearpage
  {%\advance\slideno by1
  \immediate\write\@mainaux{%
    \string\settotalslides\string{\the\cmptalkoldslideno\string}}}\writeprintcmptalk}

%----------------------------------------------------------------- printcmptalk
\newwrite\fprintcmptalk
\def\iwf{\immediate\write\fprintcmptalk}
\def\writeprintcmptalk{%
  \immediate\openout\fprintcmptalk=\jobname-print.tex
  \iwf{\string\documentclass[a4paper]\string{article\string}}%
  \iwf{\string\usepackage\string{pdfpages\string}}%
  \iwf{\string\begin\string{document\string}}%
  \iwf{\string\includepdf[pages=-\cmptalkgetrawslideno,scale=.97,nup=1x3,offset=-3.5cm 0cm]%
    \string{\jobname.pdf\string}}%
  \iwf{\string\end\string{document\string}}%
  \immediate\closeout\fprintcmptalk}

%--------------------------------------------------- lists (itemize, enumerate)
\def\labelitemimark{\raise.2ex\hbox{%
    $\m@th\scriptstyle\textcolor{\labelitemicolor}{\blacksquare}$}}
\def\labelitemicolor{black}
\AtBeginDocument{%
  \def\labelitemi{\ifx\rotatebox\undefined\labelitemimark%
    \else\rotatebox{45}{\labelitemimark}\fi}}
\def\labelitemii{$\m@th\textcolor{\labelitemicolor}{\bullet}$}
% \let\olditemize=\itemize
% \def\itemize{\olditemize
%   %\setlength{\itemsep}{1ex plus3ex minus 1ex}
%   %\setlength{\topsep}{1ex plus3ex minus1ex}%\setlength{\parskip}{0pt}
%   %\setlength{\partopsep}{1ex plus1ex minus.5ex}}
%   \setlength{\itemsep}{0ex plus0ex minus 0ex}
%   \setlength{\topsep}{0ex plus0ex minus0ex}
%   \setlength{\parsep}{0ex plus0ex minus0ex}
%   \setlength{\parskip}{0ex plus0ex minus0ex}
%   \setlength{\partopsep}{0ex plus0ex minus0ex}}
\def\listparam{%
  \itemsep=1ex plus3ex minus1ex
  \parsep=.5ex plus1.5ex minus.5ex
  \topsep=1ex plus3ex minus1ex
  \parskip=.5ex plus1.5ex minus.5ex
  \partopsep=0ex plus0ex minus0ex}
\def\itemlistparam{%
  \leftmargin=2em \rightmargin=0pt
  \labelwidth=1.5em \labelsep=.5em \itemindent=0pt}
\def\mylistparam{}   % for user parameter redefinition
\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\listparam\itemlistparam\mylistparam\def\makelabel##1{\hss\llap{##1}}}%
  \fi}
%\let\oldenumerate=\enumerate
%\def\enumerate{\oldenumerate\setlength{\itemsep}{0pt plus3ex}
%  \setlength{\topsep}{0pt plus6ex}
%  %\setlength{\parskip}{0pt}
%  \setlength{\partopsep}{0pt plus5ex}}
\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\listparam\itemlistparam\mylistparam
         \usecounter\@enumctr\def\makelabel##1{\hss\llap{##1}}}%
  \fi}
\renewenvironment{description}{\list{}{\listparam\itemlistparam\labelwidth\z@
  \itemindent-\leftmargin \mylistparam\let\makelabel\descriptionlabel}}{\endlist}

%---------------------------- maskfoil: material after last page before bigfig
\long\def\maskfoil#1#2{\AtEndDocument{\clearpage\hypertarget{#1}{}%
  \setbox0=\hbox{\strut}\wd0=1em
  \shyperlink{talkslide1.1}{\box0}\slidetitle{\appendixname}\kern-1em #2}}
\newwrite\fappendixfoil \immediate\openout\fappendixfoil=\jobname.apx
%\def\appendixfoil#1{%
%  \@ifnextchar[{\Appendixfoil{#1}}{\Appendixfoil{#1}[\appendixname]}}
\newtoks\apxtoksi
\newtoks\apxtoksii
\def\appendixfoil#1{%
  \@ifnextchar[{\AppendixFoil{#1}}{\AppendixFoil{#1}[\appendixname]}}
\def\AppendixFoil#1[#2]{\apxtoksii={{#1}[#2]}%
  \afterassignment\AppendixFoiL\apxtoksi=}
\def\AppendixFoiL{\expandafter\Appendixfoil\the\apxtoksii}
%\long\def\Appendixfoil#1[#2]#3{\immediate\write\fappendixfoil{%
%  % 1-ref_name [2-appendix_title] 3-text
%  \string\typeappendixfoil\string{#1\string}%
%  \string{#2\string}\string{#3\string}}}
\long\def\Appendixfoil#1[#2]{% 1-ref_name [2-appendix_title] 3-text
  \hypertarget{#1back}{}%
  \immediate\write\fappendixfoil{%
    \string\typeappendixfoil\string{#1\string}%
    \string{#2\string}\string{\string}%
    \string{\the\apxtoksi\string}}}
\long\def\typeappendixfoil#1#2#3#4{% 1-ref_name 2-appendix_title 3-backpg 4-text
  \clearpage
  %\talkhead{%
  %  \Acrobatmenu{GoBack}{#2}\hfill}%
  \slidetitle{\hyperlink{#1back}{#2}}\basetalkstyle\cmptalk@headboxii
  \hypertarget{#1}{}#4}
\AtEndDocument{\immediate\closeout\fappendixfoil\talksoftinput{\jobname.apx}}

%----------------------------------------------------------------- bibliography
\renewenvironment{thebibliography}[1]{
 %\bigskip \noindent{\large\refname} \smallskip
 \list{\@biblabel{\arabic{enumiv}}}%
 {\settowidth\labelwidth{\@biblabel{#1}}%
 \leftmargin\labelwidth \advance\leftmargin\labelsep
 \if@openbib
   \advance\leftmargin\bibindent
   \itemindent -\bibindent
   \listparindent \itemindent
   \parsep \z@
 \fi
 \usecounter{enumiv}%
 \let\p@enumiv\@empty
 \renewcommand\theenumiv{\arabic{enumiv}}}
 \if@openbib
   \renewcommand\newblock{\par}
 \else
   \renewcommand\newblock{\hskip .11em \@plus .33em \@minus -.07em}
 \fi
 \sloppy\clubpenalty4000\widowpenalty4000%
 \sfcode`\.=\@m\relax}%
 {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
 \endlist}

%------------------------------------------------------------------- hyperlinks
\def\noBorderLinkAttr{\makeatletter%
  \def\pdfBorderAttrs{/Border [0 0 0] /H /N }%
  \def\hy@colorlink##1{\begingroup}\let\Hy@colorlink=\hy@colorlink
  \def\@pdfhighlight{/N }\def\@pdfborder{0 0 0}\def\@urlcolor{black}%
  \makeatother}
%\AtBeginDocument{%
\long\def\shyperlink#1#2{{\noBorderLinkAttr\hyperlink{#1}{#2}}}
\long\def\shref#1#2{{\noBorderLinkAttr\href{#1}{#2}}}
%}
%\long\def\menulink#1#2{\pdfstartlink attr{/Border [0 0 0] /H /N}%
%  user{/Subtype /Link /A << /S /Named /N /#1 >> }#2\pdfendlink}
%\def\reloaddoc#1{\pdfstartlink attr{/Border [0 0 0] /H /N}%
%  user{/Subtype /Link /A << /S /Named
%    /Next << /S /Named /N /PrevPage >> /N /PrevPage >> }#1\pdfendlink}

% --------------------------------------------------- Invisible mouse navigation
\def\invsbtLeft{\nointerlineskip
 \vbox to0pt{\hbox{\kern-.02\hsize\Acrobatmenu{PrevPage}{\vbox to\paperheight{
   \hrule width.03\hsize height0pt depth0pt\vss}}}\vss}}
\def\invsbtRight{\nointerlineskip
 \vbox to0pt{\hbox to\paperwidth{\kern.995\hsize\Acrobatmenu{NextPage}{%
  \vbox to\paperheight{\hrule width.3\hsize height0pt depth0pt\vss}}\hss}\vss}}

% --------------------------------------------------Absolut coordinate placement
\newtoks\placeatmm \placeatmm={}
\newtoks\placeat \placeat={}
\newtoks\cmptalkplaceateveryslide \cmptalkplaceateveryslide={}     % new 2.96
\newtoks\cmptalkplaceatmmeveryslide \cmptalkplaceatmmeveryslide={} % new 2.96

\newdimen\wunitlength
\newdimen\hunitlength
\def\placeatmmdef{\unitlength=1mm\begin{picture}(0,0)(0,0)\the\placeatmm%
  \end{picture}\global\placeatmm={}}
\def\placeatdef{{\long\def\putt(##1,##2)##3{\@killglue\raise##2\hunitlength
  \hb@xt@\z@{\kern##1\wunitlength ##3\hss}\ignorespaces}%
  \wunitlength=\textwidth\hunitlength=\textheight\unitlength=1mm
  \begin{picture}(0,0)(0,0)\the\placeat\end{picture}\global\placeat={}}}
\def\placeatmmeveryslidedef{\unitlength=1mm\begin{picture}(0,0)(0,0)\the\cmptalkplaceatmmeveryslide%
  \end{picture}}
\def\placeateveryslidedef{{\long\def\putt(##1,##2)##3{\@killglue\raise##2\hunitlength
  \hb@xt@\z@{\kern##1\wunitlength ##3\hss}\ignorespaces}%
  \wunitlength=\paperwidth\hunitlength=\paperheight\unitlength=1mm
  \begin{picture}(0,0)(0,0)\the\cmptalkplaceateveryslide\end{picture}}}
\def\Put(#1,#2){\@ifnextchar[{\@Put(#1,#2)}{\@Put(#1,#2)[c]}}
\def\@Put(#1,#2)[#3]#4{{%
    \setbox0=\hbox{#4}%
    \dimen0=\ht0 \advance\dimen0 by\dp0
    \dimen1=-.5\wd0                           % default horizontal center
    \dimen2=\ht0 \advance\dimen2 by-.5\dimen0 % default vertical center
    \@tfor\reserved@a :=#3\do{%
      \if l\reserved@a\dimen1=0pt
      \else\if r\reserved@a\dimen1=-\wd0
           \else\if t\reserved@a\dimen2=\ht0
                \else\if b\reserved@a\dimen2=-\dp0
                     \else\if B\reserved@a\dimen2=0pt
      \fi\fi\fi\fi\fi}%
    %\message{ <Box=(\the\wd0,\the\ht0x\the\dp0) H=\the\dimen1, V=\the\dimen2> }
    \putt(#1,#2){\hskip\dimen1\lower\dimen2\box0}}}

\def\cmptalkfooter#1{\cmptalkplaceateveryslide{\Put(.98,0)[rb]{#1\strut}}}

%============================================================== New slide syntax
\def\cmptalkslide{%
  \@ifnextchar[{\cmptalk@slide}{\cmptalk@slide[]}%
}
\def\cmptalk@slide[#1]{%
  \cmptalk@slide@init{#1}%
  \cmptalk@slide@pdf
  \cmptalk@slide@type
  \bgroup
}
\def\endcmptalkslide{%
  %\cmptalknoteempty
  \let\next=\relax
  \cmptalk@note@checkallnotes
  \vfil\eject\egroup
}

\def\cmptalk@slide@init#1{%
  %\slidetitle{P\cmptalkgetrawslideno.\the\count1:S\the\slideno:#1}% Debug reason
  \slidetitle{#1}%
  \global\subsectno=1
  \global\count1=1
  \global\cmptalk@note@wasfalse
}
\def\cmptalk@slide@pdf{%
  \ifPDF
     {\cmptalk@increment\cmptalkrawslideno
     \pdfoutline goto name{talkslide\cmptalkgetrawslideno.1} count 0{\the\@slidetitle}%
     }
  \fi%
}
\def\cmptalk@slide@type{{%
  \def\tmp{cmpii}\ifx\cmptalk@style\tmp\cmptalk@headboxii\fi%
  \def\tmp{cakii}\ifx\cmptalk@style\tmp\cmptalk@headboxii\fi%
  \def\tmp{cggii}\ifx\cmptalk@style\tmp\cmptalk@headboxii\fi%
  \def\tmp{cvutii}\ifx\cmptalk@style\tmp\cmptalk@headboxii\fi%
  \def\tmp{nologoii}\ifx\cmptalk@style\tmp\cmptalk@headboxii\fi%
}}

\def\cmpslidelabel#1{%
  \immediate\write\@mainaux{%
    \string\newlabel\string{#1\string}%
    \string{%
      \string{\cmptalkgetrawslideno\string}%
      \string{\the\cmptalkpageno\string}%
      \string{\string\relax\string}%
      \string{slide.\cmptalkgetrawslideno\string}%
      \string{\string}%
    \string}%
  }%
}

%========================================================================= Notes
% general verbatim write
\@ifundefined{verbatim@processline}{\RequirePackage{verbatim}}{}
\def\cmptalk@note@filename{\jobname-note.tex }
\newwrite \cmptalk@note@out
\def\cmptalk@note@open{\immediate\openout\cmptalk@note@out\cmptalk@note@filename}
\def\cmptalk@note@close{\immediate\closeout\cmptalk@note@out}
\def\cmptalk@note@write{\immediate\write\cmptalk@note@out}

% core
\newif\ifcmptalk@note@was

\newtoks\cmptalkeverynotes
\newtoks\cmptalkeverynote
\newtoks\cmptalkeverystartnote
\newtoks\cmptalkeverystopnote
\newtoks\cmptalkeverytrailer
\catcode`\%=12 \catcode`\*=14
\def\cmptalk@note@beginfile{*
  \cmptalk@note@write{% Automaticaly generated from \jobname.tex (\the\year-\the\month-\the\day)}*
  \cmptalk@note@write{\string\documentclass[a4paper]{article}}*
  \cmptalk@note@write{\string\usepackage{cmptalk-notes}}*
  \cmptalk@note@write{\string\cmptalknotestitle={\thetalktitle}}*
  \cmptalk@note@write{\string\cmptalknotesauthor={\thetalkauthorname}}*
  \cmptalk@note@write{}*
  \cmptalk@note@write{\the\cmptalkeveryslideandnote}*
  \cmptalk@note@write{}*
  \cmptalk@note@write{\the\cmptalkeverynotes}*
  \cmptalk@note@write{}*
  \cmptalk@note@write{\string\begin{document}}*
}
\def\cmptalk@note@endfile{*
  \cmptalk@note@write{\the\cmptalkeverytrailer}*
  \cmptalk@note@write{}*
  \cmptalk@note@write{\string\end{document}}*
  \cmptalk@note@write{}*
  \cmptalk@note@write{% --- end of \jobname-note.tex}*
}
\def\cmptalk@note@talkhead{{*
  *\tmpc=\count0 \advance\tmpc by1
  \cmptalk@note@write{}*
  \bgroup*
  \cmptalk@increment\cmptalkrawslideno*
  \cmptalk@note@write{% ------------------------------------------- Slide no \cmptalkgetrawslideno\space---}*
  \egroup*
  \cmptalk@note@write{\string\newpage}*
  \cmptalk@note@write{\the\cmptalkeverynote}*
  \cmptalk@note@write{\string\cmptalknoteslidereprint{\cmptalkgetpageno}{\jobname.pdf}}*
  \cmptalk@note@write{\the\cmptalkeverystartnote}*
  \cmptalk@note@write{}*
}}
\def\cmptalk@note@talktail{*
  \cmptalk@note@write{}*
  \cmptalk@note@write{\the\cmptalkeverystopnote}*
}
\catcode`\%=14 \catcode`\*=12
\def\cmptalk@note@start{\cmptalk@note@open\cmptalk@note@beginfile}
\def\cmptalk@note@stop{\cmptalk@note@endfile\cmptalk@note@close}

\def\cmptalk@note@beg{%
  \global\cmptalk@note@wastrue
  \nobreak
  \cmptalk@note@talkhead
  \@bsphack
}

\def\cmptalk@note@startverb{%
  \let\do\@makeother\dospecials
  \catcode`\^^M\active \catcode`\^^I=12
  \def\verbatim@processline{%
    \cmptalk@note@write{\the\verbatim@line}}%
  \verbatim@start
}

\def\cmptalknote{%
  \cmptalk@note@beg
  \cmptalk@note@startverb
}
\def\endcmptalknote{%
  \@esphack
  \cmptalk@note@talktail
}

\def\cmptalk@note@checkallnotes{%
  \let\next=\relax
  \ifcmptalkallnotes
    \ifcmptalk@note@was\else
      \let\next=\cmptalknoteempty
    \fi
  \fi
  \next
}

\def\cmptalknoteempty{%
  \cmptalk@note@beg
  \endcmptalknote
}

\AtBeginDocument{\cmptalk@note@start}
\AtEndDocument{\cmptalk@note@stop}

% --- both slide & note definitions
\newtoks\cmptalkeveryslideandnote
\AtBeginDocument{\the\cmptalkeveryslideandnote}

%============================================================== User definitions
%% \begin{narrow}{3} \end{narrow}
\newenvironment{narrow}[1][1]
  {\list{}{\rightmargin=#1\hrmargin \leftmargin=#1\hrmargin}\item[]\relax}
  {\endlist}

  \def\sideImgAB#1#2#3#4#5{\parbox[t]{.9\textwidth}{%
  \begin{minipage}[b]{#1\textwidth}\raggedright #4\end{minipage}\hfill%
  \begin{minipage}[b]{#2\textwidth}\centering#5\end{minipage}}}

%------------------------------------------------------------------------ video
%% %% {width}{proportion}{videofile}
%% \def\videoMode{/Open} % /Repeat /Once
%% \def\videoShowControls{true} % false
%% \def\videoPar{} % /Rate 0.1
%% \def\video#1#2{\@ifnextchar[{\@video{#1}{#2}}{\@video{#1}{#2}[]}}
%% \def\@video#1#2[#3]#4{{\dimen0=#1 \dimen1=#2\dimen0
%%  \ifx\bigfig\undefined\else\bigfigfalse\fi%
%%  \edef\tmp{#3}\ifx\tmp\empty\setbox0=\hbox{}\else%
%%  \setbox0=\hbox{\includegraphics[width=#1,height=\dimen1]{#3}}\fi%
%%  \wd0=#1 \ht0=\dimen1 \dp0=0pt
%%  \mbox{\ifPDF\pdfannot width #1 height \dimen1 depth 0cm {%
%%     /Subtype /Movie /T (Video)  
%%     /Movie << /F (#4) /Poster true >>
%%     /A << /ShowControls \videoShowControls\space /Mode \videoMode
%%           \videoPar\space >>}\fi%
%%   \copy0}}}

\usepackage{cmpvideo}

%\AtBeginDocument{%
%  \ifx\@MXV@newlabel\undefined
%    %\def\@MXV@newlabel{\message{ >>><<< }}%
%    \def\@MXV@newlabel#1#2#3#4#5{}%
%  \fi
%}

%------------------------------------------------------------- TexPower setting
\def\texpowersetting{%
  \ifx\replacecolorsbyone@TP\undefined\else%
    % change 2005-04-26 for texpower 2004/07/27
    %\definecolor{textcolor@whitebg}{gray}{0}%
    \defineTPcolor[whitebg]{textcolor}{rgb}{0,0,0}%    Normal text.
    \defineTPcolor[whitebg]{emcolor}{rgb}{1,0.4,0}%    Emphasised text (if coloremph option is given).
    \defineTPcolor[whitebg]{altemcolor}{rgb}{1,0.4,0}% Double emphasised text (if coloremph option is given).
    \whitebackground
  \fi%
}
\newcount\talkstepc
\newcount\talkstepbigfigc
\newif\ifcmptalkpausestep
\def\texpowerhypertargethack{%
  \def\filterwhatsits@TP{%
    %\message{ <!\the\c@step,\the\cbigfig!> }%
    \talkstepc=\c@step \advance\talkstepc by1
    \global\setbox\@cclv=\hbox{%
    \batchmode
%    \hypertarget{talkslide\the\cmptalkoldslideno.\the\talkstepc}{}%
    \pdfdest name{talkslide\the\cmptalkoldslideno.\the\talkstepc} xyz % !!! texpower redefined hypertarget
    \talkstepbigfigc=\cbigfig
    \loop\ifnum\talkstepbigfigc>0
      %\ifsmalfigtargetfalse{\the\talkstepbigfigc}%
%        \hypertarget{smallfig\the\talkstepbigfigc}{}%
         \pdfdest name{smallfig\the\talkstepbigfigc} xyz % !!! texpower redefined hypertarget
        %\defsmalfigtarget{\the\talkstepbigfigc}%
      %\fi%
      \advance\talkstepbigfigc by-1\relax
    \repeat
    \errorstopmode
    \leaders\copy\@cclv\hskip\wd\@cclv}}
  \def\pause{%
    \save@TP
    \insertfirstduplicate@TP
    \ifthenelse{\boolean{display}}%
    {\cmptalkpausesteptrue
     \outputduplicate@TP
     \cmptalkpausestepfalse
     \restorepausecounters@TP% Restore counters (page number). VZ: from TeX Live 2004
     %\global\count0=\mempageno@TP
     \global\slideno=\count0
     \global\advance\count1 by1
     \insertsecondduplicate@TP}
    {}}
}

%-------------------------------------------------------------- Compatibility
\def\talkslide{\cmptalk@style}

%------------------------------------------------------------- bigfig setting
%\def\bigfigsetting{\ifx\cbigfig\undefined\gdef\cbigfig{0}\fi}
\def\bigfigsetting{\ifx\cbigfig\undefined\newcount\cbigfig\fi}

\AtBeginDocument{\texpowersetting\texpowerhypertargethack\bigfigsetting}

\endinput

%% Documentation:
- sideImgAB
- texpower

%% End of cmptalk.cls
