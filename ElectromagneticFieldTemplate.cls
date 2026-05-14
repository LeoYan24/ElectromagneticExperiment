% ElectromagneticFieldTemplate.cls
% 电磁场与微波实验报告模板（最终版，符合所有要求）
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ElectromagneticFieldTemplate}[2026/05/14 电磁场与微波实验报告模板]

\LoadClass[UTF8,a4paper,12pt]{ctexart}

% 必用宏包
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{amsmath, amssymb}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{setspace}

% 页面设置
\geometry{left=2.5cm,right=2.5cm,top=2.5cm,bottom=2.5cm}
\renewcommand{\baselinestretch}{1.25}
\setlength{\headheight}{14pt}

% 页眉设置（宋体）
\pagestyle{fancy}
\fancyhf{}
\fancyhead[C]{\zihao{5}\songti 北京邮电大学《电磁场与微波》实验报告}
\fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

% 章节标题格式：左对齐、加粗、四号黑体，序号为中文数字“一、二、…”
\renewcommand{\thesection}{\chinese{section}}
\titleformat{\section}
    {\Large\bfseries\heiti\raggedright}
    {\thesection、}{0em}{}
\titlespacing*{\section}{0pt}{20pt}{10pt}

% 图片默认路径（请将图片放入 TemplateFigures 文件夹）
\graphicspath{{./TemplateFigures/}}

% ----- 封面信息变量（全部英文）-----
\newcommand{\@expname}{}
\newcommand{\@classname}{}
\newcommand{\@stuname}{}
\newcommand{\@stuid}{}
\newcommand{\@instructor}{}
\newcommand{\@expdate}{}

\newcommand{\setExperimentInfo}[6]{%
    \renewcommand{\@expname}{#1}%
    \renewcommand{\@classname}{#2}%
    \renewcommand{\@stuname}{#3}%
    \renewcommand{\@stuid}{#4}%
    \renewcommand{\@instructor}{#5}%
    \renewcommand{\@expdate}{#6}%
}

% ----- 封面制作（带页眉，顶部校名图片，标题下方校徽）-----
\renewcommand{\maketitle}{%
    \begin{titlepage}
        \thispagestyle{fancy}
        \centering
        
        % 顶部校名图片（BUPT）
        \includegraphics[width=12cm]{BUPT} \\[0.5cm]
        
        
        % 主标题
        {\zihao{2}\heiti 《电磁场与微波》实验报告}
        
        \vspace{0.8cm}
        
        % 校徽（badge）仅一次，放在标题下方
        \includegraphics[width=6cm]{badge} \\
        
        \vspace{1.5cm}
        
       % 信息表格（标签加粗三号宋体，内容加下划线三号宋体）
        \renewcommand{\arraystretch}{1.8}
        \begin{tabular}{p{3cm} p{8cm}}
            {\bfseries\zihao{3}\songti 实验：} & {\zihao{3}\songti\underline{\hspace{6cm}}} \\[0.5cm]
            {\bfseries\zihao{3}\songti 班\quad 级：} & {\zihao{3}\songti\underline{\hspace{6cm}}} \\[0.5cm]
            {\bfseries\zihao{3}\songti 姓\quad 名：} & {\zihao{3}\songti\underline{\hspace{6cm}}} \\[0.5cm]
            {\bfseries\zihao{3}\songti 学\quad 号：} & {\zihao{3}\songti\underline{\hspace{6cm}}} \\[0.5cm]
            {\bfseries\zihao{3}\songti 指导老师：} & {\zihao{3}\songti\underline{\hspace{6cm}}} \\[0.5cm]
        \end{tabular}

        \vspace{1cm}

        % 单独的年、月（无标签）
        {\zihao{3}\songti \hspace{2cm} 年 \hspace{2cm} 月}
        
        \vfill
        \centering
        \zihao{5}\songti 北京邮电大学 \hspace{1cm} 电子工程学院
        \vspace{1cm}
    \end{titlepage}
    \setcounter{page}{1}
}

% 正文页眉延续
\AtBeginDocument{\pagestyle{fancy}}
\endinput