\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ExpressiveResume}[2024/12/03 Expressive Resume Template]



\LoadClass{Expressive}

\RequirePackage[paperwidth=14in, paperheight=20in, margin=1in]{geometry}
\pagestyle{empty}

\newcommand{\headersep}{\hspace{25pt}}

\newkeycommand{\resumeheader}[
    firstname,middleinitial,lastname,
    email,
    phone,
    github,
    kaggle,
    webpage,
    linkedin,
    city,
    state,
    qrcode
]{%
\begin{center}
    \fontsize{35}{42}\selectfont\textsc{\commandkey{firstname}\space\commandkey{lastname}}
    % \commandkey{firstname}%
    % \ifcommandkey{middleinitial}{\space\commandkey{middleinitial}.}{}%
    % \space\commandkey{lastname}%
    \\[5pt]
    \vspace{5pt}
\fontsize{16}{19.2}\selectfont{
    \ifcommandkey{state}{\location{\ifcommandkey{city}{\commandkey{city}, }{}\commandkey{state}}}{}%
    \ifcommandkey{phone}{\headersep\phone{\commandkey{phone}}}{}%
    \ifcommandkey{email}{\headersep\email{\commandkey{email}}}{}%
    \ifcommandkey{linkedin}{\headersep\linkedin{\commandkey{linkedin}}}{}%
    \ifcommandkey{github}{\headersep\github{\commandkey{github}}}{}%
    \ifcommandkey{kaggle}{\headersep\kaggle{\commandkey{kaggle}}}{}%
    \ifcommandkey{webpage}{\headersep\webpage{\commandkey{webpage}}}{}%
    \ifcommandkey{qrcode}{%
        \begin{tikzpicture}[remember picture,overlay]
            \node[anchor=north east, yshift=-.33in, xshift=-.5in]
            at (current page.north east)
            {\includegraphics[width=.1\linewidth]{\commandkey{qrcode}}};
        \end{tikzpicture}
         % <--- MOVED TO HERE
    }{}%

} % End of \noindent\normaltextfont group
\end{center}
\vspace{2pt}
}


\newcommand{\tagline}[2]{%
    \begin{flushleft}
        \textsc{#1}: #2
    \end{flushleft}
}
\newcommand{\summary}[1]{\tagline{Summary}{#1}}
\newcommand{\objective}[1]{\tagline{Objective}{#1}}



% \pagenumbering{arabic}
