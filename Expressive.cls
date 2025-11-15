\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Expressive}[2024/08/10 Base Class for Expressive Resumes/Cover Letters]

\newcommand{\spacesmall}{0pt}
\newcommand{\spacenormal}{0pt}


\newcommand{\sectionfont}{\fontsize{21}{25.2}\selectfont} % Slightly bigger than normal
\newcommand{\subsectionfont}{\fontsize{18}{21.6}\selectfont} % Slightly smaller than section
\newcommand{\normaltextfont}{\fontsize{16.3}{19.56}\selectfont} % Base text

 % \AtBeginDocument{\normaltextfont}


\LoadClass[letterpaper]{article}

\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{fontawesome5}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{enumitem}

\RequirePackage{array}
\newcolumntype{L}[1]
{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\newcolumntype{C}[1]
{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\newcolumntype{R}[1]
{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}p{#1}}
\RequirePackage{multirow}


\RequirePackage[colorlinks]{hyperref}
\definecolor{linkcolour}{rgb}{0,0.0,0.0}
\definecolor{citecolour}{rgb}{0.0, 0.2, 0.6}
\hypersetup{
    colorlinks,
    breaklinks,
    urlcolor=linkcolour,  % Color them black
    linkcolor=linkcolour,  % Color them black
    citecolor=citecolour
}


\RequirePackage{enumitem}
\setlist{nosep,topsep=1.8pt, partopsep=0pt, parsep=0pt, itemsep=0pt,leftmargin=13pt}


\RequirePackage{titlesec}

\titleformat{\section} % command
  {\vspace{-19pt}\color{blue}\sectionfont\bfseries\selectfont\sectionfont\scshape\raggedright} % format
  {} % label
  {0em} % sep
  {\vspace{-2pt}\\[-3pt]} % before-code (top rule)
  [] % after-code (bottom rule)

\titlespacing{\section}
  {-5pt}  % left
  {4pt}  % before-sep % 3pt
  {2pt}  % after-sep
  [0pt]


% Subsection Formatting (slightly smaller)
\titleformat{\subsection}
{\subsectionfont\scshape\raggedright}  % reduced from default (which is often \large)
{}
{0em}
{}
[]
\titlespacing{\subsection}
{0pt}
{\spacesmall}
{\spacetiny}  % slightly reduced after-spacing
[0pt]


%% Add support for commands with named arguments
\RequirePackage{keycommand}
% patch by Joseph Wright ("bug in the definition of \ifcommandkey (2010/04/27 v3.1415)"),
% https://tex.stackexchange.com/a/35794/
\begingroup
\makeatletter
\catcode`\/=8 %
\@firstofone
{
\endgroup
\renewcommand{\ifcommandkey}[1]{%
\csname @\expandafter \expandafter \expandafter
\expandafter \expandafter \expandafter \expandafter
\kcmd@nbk \commandkey {#1}//{first}{second}//oftwo\endcsname
}
}

%% ----- Custom Commands -----
% Contact Information
\newcommand{\nametitle}[2]{%
    { \huge #1 {#2} }\\
}

\newcommand{\contactseparator}{\hspace{3pt}·\hspace{4pt}}

\newcommand{\email}[1]{\faIcon{envelope} \href{mailto:#1}{#1}}
\newcommand{\phone}[1]{\faIcon{phone-alt} \href{tel:+1-#1}{#1}}
\newcommand{\github}[1]{\faIcon{github} \href{https://github.com/#1/}{#1}}
\newcommand{\linkedin}[1]{\faIcon{linkedin} \href{https://linkedin.com/in/#1/}{#1}}
\newcommand{\location}[1]{\faIcon{map-marker-alt} #1}


\newcommand{\kaggle}[1]{\faIcon{kaggle} \href{https://www.kaggle.com/#1/code/}{#1}}

\newcommand{\webpage}[1]{\faIcon{globe} \href{https://zafarmahmood.com}{#1}}

% Experience/Achievements
\newcommand{\equivalent}{\textnormal{\textsc{equivalent}}}
\newcommand{\honors}[1]{\textnormal{\emph{#1}}}
\newcommand{\roletitle}[1]{\textbf{#1}}
\newcommand{\tech}[1]{{{\color{Brown}{\fontseries{sb}\selectfont{#1}}}}}
\newcommand{\tenure}[1]{\textsc{#1}}

\setlist[itemize]{label=\raisebox{0.2ex}{\small$\bullet$}, leftmargin=1.5em}

\newcommand{\achievement}[1]{%
  {\normaltextfont  % or \normaltextfont if defined
    \setlength{\itemsep}{0pt}
    \setlength{\parskip}{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\topsep}{0pt}
    \begin{itemize}[leftmargin=0.7em]
      \item \setlength{\baselineskip}{0.92\baselineskip} 
      #1
    \end{itemize}
    \vspace{0.3em}
  }%
}

\newcommand{\achievementSkill}[1]{%
  {\normaltextfont  % or \normaltextfont if defined
    \setlength{\itemsep}{0pt}
    \setlength{\parskip}{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\topsep}{0pt}
    \begin{itemize}[leftmargin=0em]
      \item[] \setlength{\baselineskip}{0.92\baselineskip} 
      #1
    \end{itemize}
    \vspace{0.3em}
  }%
}


\newcommand{\project}[3]{%
  \noindent\begin{tabular*}{\linewidth}{@{}l@{\extracolsep{\fill}}r@{}}
    {\subsectionfont\bfseries #1} & {\subsectionfont\bfseries #2}\\
  \end{tabular*}\par
  \vspace{0.5pt}#3 \vspace{1pt}
}


\newcommand{\role}[4]{%
  \noindent
  % Box 1: Left-aligned. 
  % \rlap prints this box but makes it take up 0 width,
  % so the cursor stays at the left margin.
  \rlap{\makebox[\linewidth][l]{{\subsectionfont\bfseries\selectfont{#1}}}}%
  %
  % Box 2: Center-aligned.
  % This is also in an \rlap. It prints #2 at the exact
  % center of the page. The cursor stays at the left margin.
  \rlap{\makebox[\linewidth][c]{{\subsectionfont\bfseries\selectfont{#2}}}}%
  %
  % Box 3: Right-aligned.
  % This is the final box, not in an \rlap. It prints #3
  % at the right margin and properly moves the cursor
  % to the next line.
  \makebox[\linewidth][r]{{\subsectionfont\bfseries\selectfont{#3}}}\par
  %
  % The description text below
  \vspace{0.3em}#4 \vspace{5pt}
}



\newcommand{\mooc}[4]{

 \noindent\begin{tabular*}{\linewidth}{@{}l@{\extracolsep{\fill}}r@{}}
{

\href{#1}{{\subsectionfont\bfseries{\selectfont{#2}}} \contactseparator{\normaltextfont{#3} \tech{\ExternalLink}}} } & {\subsectionfont\bfseries\selectfont{#4}}\\
  \end{tabular*}\par
  \vspace{2pt}
}


\newcommand{\experience}[1]{%

    #1
}


% \pagenumbering{arabic}
