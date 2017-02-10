% CMPthesis: LaTeX class for both master and phd thesis
% cmpthesis.cls: class definition file
% (c) 2007-2008 Vit Zyka
%
% 2007-03-23 v0.1 first version
% 2007-05-13 v0.2 abbreviation
% 2008-05-16 v0.3 fix of abbreviation
% 2008-05-19 v0.4 caption2 -> koma; hyperrref: none->UseNone

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmpthesis}[2008/05/19 v0.4 (Vit Zyka)]

% --- options
\def\CMPThesisTypeBsc{bsc}
\def\CMPThesisTypeMsc{msc}
\def\CMPThesisTypePhd{phd}
\let\CMPThesisType\CMPThesisTypeMsc
\DeclareOption{bsc}{\let\CMPThesisType\CMPThesisTypeBsc}
\DeclareOption{msc}{\let\CMPThesisType\CMPThesisTypeMsc}
\DeclareOption{phd}{\let\CMPThesisType\CMPThesisTypePhd}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrreprt}}
\ProcessOptions

% --- load standard KOMA script class
\LoadClass
  [11pt,a4paper,twoside,bibliography=totoc,index=totoc,headings=normal,abstracton,
   cleardoublepage=empty]
  {scrreprt}
%\areaset{150mm}{48\baselineskip}
\typearea[25mm]{14}
\advance\footskip by-\baselineskip
\advance\topmargin by3mm
\columnsep=2em

%\parindent=1.5em

% --- packages
\usepackage{ifpdf}

\ifpdf
  \usepackage[pdftex]{color,graphicx}
  \definecolor{lgray}{gray}{.9}
  \definecolor{dgreen}{rgb}{0,0.4,0}
  \definecolor{dblue}{rgb}{0,0,0.5}
  \definecolor{dred}{rgb}{0.4,0,0}  
  \usepackage[pdftex,backref=page]{hyperref}
  \hypersetup{colorlinks,pdfhighlight=/O,citecolor=dgreen,
     filecolor=dblue,urlcolor=dblue,linkcolor=dred,
     breaklinks=true,pdfpagemode=UseNone,plainpages=false,
%     backref=true,pagebackref=true,breaklinks=true,
     pdfauthor={Pavel Trutman},
     pdfsubject={Master thesis},
     pdftitle={Semidefinite Programming for Geometric Problems in Computer Vision},
     pdfcreator={Pavel Trutman},
     pdfkeywords={computer vision} {robotics} {minimal problems} {polynomials equations} {Gr\"obner basis},
  }
\else
  \usepackage{color,graphicx}
\fi

%\usepackage[small]{caption2}
%  \renewcommand*\captionlabelfont{\sfb}
%  \renewcommand*\captionlabeldelim{}
%  %\renewcommand*\captionformat{\ } % does not operate!
%  \captionindent=\parindent
\addtokomafont{caption}{\small}
\addtokomafont{captionlabel}{\sffamily \bfseries}
\renewcommand*{\captionformat}{~~}
\setcapindent{\parindent}

%\usepackage{subfigure}
%  \def\subfigtopskip{5pt}             % subfigure spacing
%  \def\subfigbottomskip{0pt}
%  \def\subfigcapskip{2pt}
%  \def\subfigcapmargin{5pt}
%  \def\thesubfigure{\alph{subfigure}} % subfigure referencing
%  \def\@thesubfigure{{\sfb\thesubfigure)\space}\raggedright}
%  \def\p@subfigure{\thefigure}

\usepackage{makeidx}\makeindex
%\usepackage{wrapfig}
%\usepackage{wideenv}
%\usepackage{ifrpage}
\usepackage{url}

\def\LoadCMPCover{\usepackage[\CMPThesisType thesis]{cmpcover}}
%\AtBeginDocument{\LoadCMPCover} % due to Czech style dependency

%\ifx\CMPThesisType\CMPThesisTypeMsc
%  \usepackage[mscthesis]{cmpcover}
%\else\ifx\CMPThesisType\CMPThesisTypePhd
%  \usepackage[phdthesis]{cmpcover}
%\fi\fi

% =========================================================== settings
\setcounter{tocdepth}{3}

% ============================================================= labels
\def\abbrvname{Abbreviations}

% ======================================================== definitions
\def\startThesisInfo{\LoadCMPCover} % due to Czech style dependency
\def\stopThesisInfo{}

% lists
\def\setgenlistparam{%
  \setlength{\itemsep}{0pt}\setlength{\parsep}{0pt plus2pt}%
  \setlength{\topsep}{0pt}\setlength{\parskip}{0pt plus2pt}}

% itemize
\setlength\leftmargini{\parindent}
\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\def\makelabel##1{\hss\llap{##1}}\setgenlistparam}%
  \fi}

% enumerate
\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\usecounter\@enumctr\def\makelabel##1{\hss\llap{##1}}%
         \setgenlistparam}%\setlength\leftmargin{2\parindent}}%
  \fi}

% description
\renewenvironment{description}
  {\list{}{\labelwidth\z@ \itemindent-\leftmargin \setgenlistparam
           \let\makelabel\descriptionlabel}}
  {\endlist}

% --- usefull registers
\newdimen\tmpd
\newdimen\tmpD
\newdimen\Tmpd
\newdimen\TmpD

\newcount\tmpc
\newcount\tmpC
\newcount\Tmpc
\newcount\TmpC

\newbox\tmpb
\newbox\tmpB
\newbox\Tmpb
\newbox\TmpB

% --- list of abbreviation
\newdimen\AbbrvIndent \AbbrvIndent=7em
\newdimen\AbbrvSep    \AbbrvSep=1em

\def\startAbbreviations{%
  \@ifnextchar[{\dostartAbbreviations}{\dostartAbbreviations[]}%
}
\def\dostartAbbreviations[#1]{%
  \clearpage
  \chapter*{\abbrvname}
  #1\par\medskip
  \list{}{\bgroup
    \labelwidth=\z@ \labelsep=\z@
    \leftmargin\AbbrvIndent \itemindent-\leftmargin \setgenlistparam
    \def\makelabel##1{%
      \setbox\Tmpb=\hbox{%
        \normalfont%\sffamily\bfseries
        ##1\hskip\AbbrvSep}%
      \ifdim\wd\Tmpb>\AbbrvIndent\Tmpd=\wd\Tmpb \else\Tmpd=\AbbrvIndent \fi
      \hbox to\Tmpd{\unhbox\Tmpb\hfill}}%
    \let\abbrv\item}
}

\def\stopAbbreviations{%
  \endgraf\egroup\endlist
}

% --- abbreviations
\newdimen\LW \let\LW\linewidth
\newdimen\BL \let\BL\baselineskip

\def\mref#1{(\ref{#1})}

\endinput
% end of cmpthesis.cls
