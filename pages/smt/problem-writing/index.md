# Information for SMT problem writers {.title}

This page has information on problem writing resources and instructions for the technical aspects of problem writing, including for installing LaTeX, setting up the Git problem writing repository, and using the repository.

If you need help with LaTeX, Git, or any of the other technology we're using, just ask us. Moor is currently the (temporary) primary contact for technical help.

# General information

We will prepare six short-answer tests containing a total of 80 problems, a
proof-based Power Round, and tiebreakers, and all of our problems must be
original and of high quality. This is a lot of work! Keep in mind that in order
to pull this off, we need many different people handling many different tasks,
not only writing but also compiling, editing, test-solving, proof-reading,
and so on. This means that you can and will be a great asset to us no matter
your background or lack thereof in problem writing or math contests in
general. Do not be intimidated!

You can find archives of past contests on the [SMT homepage](/smt/index.html).
If you're unfamiliar with the format of the tests, see the description of the
tests on the [SMT rules page](/smt/rules.html). Looking at the SMT 2012 or 2013
tests is the best way to get a sense of the style, format, and difficulty level
we're aiming for. (The 2011 tests share about the same style and format, but
are much harder than our tests should be. Tests from 2010 and earlier may
be very different in style, difficulty, and quality.) We aim for tests that
cover much of the AMC/AIME range of difficulty.

See the [mathematical expectations](/pdfs/mathematical-expectations.pdf)
document for our publicly available guidelines on the topics that may appear
on each test, and the SMT private syllabus document (which can be found in the
`smt_private_syllabus` file in the problem writing repository) for a set
of guidelines on the balance of topics and difficulties we aim for.

Some of our more experienced problem writers have put together some tips on [how to write an original problem](/smt/problem-writing/how-to-write.html). If you're feeling nervous or uninspired, take a look! Remember that we need problems at all levels of difficulty, and whatever you can come up with is very much welcome.

<!--If you are at Stanford, you can easily view the problem writing repository without any setup from our online WebAuth-protected site. Most Stanford problem writers should already have access; if you don't, let us know and we'll add you (contact Moor). Note: this online copy of the repository is usually updated within a few hours, but it may not always be regularly updated. You can check the timestamp on the LAST_UPDATED file to see when the last successful update was.-->

*Obvious but extremely important warning:* the SMT repository contains sensitive materials, including problems and power round topics, so you must keep it private. **Do not communicate any information whatsoever about the problems except to another SMT problem-writer.** Security is crucial to our ability to run a fair and enjoyable tournament for our students.

To view, edit, and write problems on your computer, you'll need to set up LaTeX and our Git problem writing repository — the instructions for this are below. We've done a lot of work to make this as easy as possible, and if you run into any problems, just ask us for help.

If you have a good problem but don't have the Git repository set up, you can email it to Lynnelle (preferably in LaTeX `.tex` source). Warning: we cannot guarantee that we will add your problems to the repository in a timely manner. If you intend to do more than a minimal amount of problem writing and editing, you're better off using Git.

We also have some more information about problem writing, such as schedules for problem writing, in Google Docs. If you haven't been shared the Google Docs, let us know what email address you usually use for your Google account (e.g. your Gmail address), and we'll add you.

# Installing LaTeX

Below are recommended ways to install LaTeX on each OS, but you can use a
different LaTeX installation if you prefer. If you already have LaTeX
installed, it may work as is, but you may need to install some extra LaTeX
packages to compile the SMT documents. See the OS-specific instructions below.

## Windows

Download and install the latest version of [MiKTeX](http://miktex.org/download). The installation process should be fairly straightforward, but if you need help, the section on MiKTeX in [AoPS's LaTeX installation guide](http://www.artofproblemsolving.com/Wiki/index.php/LaTeX:Downloads) may be useful.

When you first try to compile the SMT documents, MiKTeX will install any additional LaTeX packages that it needs.

## Linux

Install `texlive` using your package manager.

If you are using Debian, Ubuntu, etc., install the following packages using your package manager (e.g. by running `sudo apt-get install`): `texlive texlive-latex-recommended texlive-latex-extra texlive-math-extra`

## Mac

Install [MacTeX](http://www.tug.org/mactex/).

# Setting up the Git repository

The git repository for SMT 2014 is now located at
`git@smtpw.unfuddle.com:smtpw/smt2014.git`. Follow the instructions below to
set up the repository. If you used last year's repository (and haven't switched
    computers), setup is super-easy: just skip to [Cloning the SMT 2014
repository](#cloning-the-smt-2014-repository). If you have git installed, skip to [SSH keys](#ssh-keys).

## Installing Git

A listing of git downloads is available [here](http://git-scm.com/download).
Here are OS-specific instructions:

### Windows

Download and install the latest version of the msysgit full installer
[here](http://code.google.com/p/msysgit/downloads/list).  After installing,
open up Git Bash to get a command prompt for the next configuration steps.
(Note: If you have Cygwin, you can use Cygwin's version of git instead.)

### Linux

Installing git should be easy; just use your package manager. For example, Ubuntu users should type: `sudo apt-get install git`.

### Mac

If you have a package manager, you can just use that. Otherwise, download the appropriate installer from [here](http://code.google.com/p/git-osx-installer/downloads/list?can=3).

## SSH keys

If you already have set up SSH keys for SMT on your computer (e.g. if you used last year's repository), skip to the next section, [Configuring Git](#configuring-git).

Open a terminal for the next configuration steps. (If you're using msysgit on Windows, open up Git Bash to get a command prompt.)

1.  If you already have an SSH key pair on your computer, skip to step 2.

    At the prompt, type: `ssh-keygen -t rsa -C "<your email address>"`.

    When it asks for passphrase / file location, leave it blank and hit enter.

2.  Open the file where the previous command said it had stored your public key. By default, this is located at `~/.ssh/id_rsa.pub`, or on Windows, this is probably in your My Documents folder at `C:\Documents and Settings\<your user name>\.ssh\id_rsa.pub` or `C:\Users\<your user name>\Documents\.ssh\id_rsa.pub`.

    Copy and paste the contents of the public key file **id_rsa.pub** (NOT the id_rsa file, which is your private key) and send it to Moor to get access to the repository. You will not be able to clone or otherwise access the repository until we have added your public key.

    The id_rsa.pub file is just a plain text file. You can run `cat ~/.ssh/id_rsa.pub` at the command prompt, or open it any text editor (e.g. Notepad). If you're on Windows and you have difficulty opening it, you can copy it to `id_rsa.pub.txt` and open that.

    The public key should look something like this:

        ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA2UWJG6SSiM5TLCR+mCsMy52WoPixngcQ2G1aQOrPIK282kkWnjhNEL+R pSXKaf7yYzCkPbYIyZzeVxo7XQsadFXzsBzWR79c2di2HQFPN7DvdAYBTOvXCNTbjOiHSgfY3X/tuphSY98QGicpcNzn sJocdy5cBXvF6NIfmDuXgsHN9Yp8BeTdPEosF4JLe0RAD2glDytwesVLkaKE/2ZKacFzp== example&#64;example.com

## Configuring Git

At the prompt,

  * Type: `git config --global user.name "<your name>"` (e.g. git config --global user.name "More Shoe")

  * Type: `git config --global user.email "<your email address>"` (e.g. git config --global user.email "moreshoe&amp;#64;stanford.edu")

  * If you want git commands to produce output with color, `type: git config --global color.ui auto`

  * If you want to change the editor git opens for entering commit messages to something other than vi (which is highly recommended if you don't know how to use vi), type: `git config --global core.editor <your editor>`

      * If you're on Linux or Mac and don't know what editor to use, you can try gedit (for GNOME users), kate (for KDE users), or nano as &lt;your editor&gt;.
      * If you're on Windows and don't know what editor to use, you can try WordPad: `git config --global core.editor "'C:/Program Files/Windows NT/Accessories/wordpad.exe'"` (note that you need two sets of quotes)

## Cloning the SMT 2014 repository

1. `cd` to the directory where you want the SMT files to exist.
2. At the prompt, type: `git clone git@smtpw.unfuddle.com:smtpw/smt2014.git`
3. This command creates a smt2014 directory, which contains the SMT repository.
4. Enter the smt2014 directory by typing: `cd smt2014`
5. At the prompt, type: `./SetupRepository`
You're now done with the setup! Read the sections below for instructions on how to use Git and how to compile and create problems.

# Using Git

  * Before you start viewing or editing, update your local copy of the files with everyone else's changes by typing at the prompt: `git pull`
      * This is important! If you haven't run git pull for a long time, your copy of the files may be badly out of date.
      * You can run the `./AutoUpdate` script instead, which automatically pulls changes and compiles files if necessary.
  * You can now view/edit the problems, tests, etc. See the next section, [Instructions for problem writing](#instructions-for-problem-writing), on how to do this. If you're just viewing things, you don't need to do anything else with Git (other than run `git pull` to get new updates). If you're making edits, read on for instructions.
  * We strongly recommend that after you make changes to problems, you compile them and make sure things look as you expected.
  * If you created a new file that should be added to the repository, type at the prompt: `git add <file>`
  * You can use `git diff` to see what changes you made and git status to see a list of files you modified, added, etc.
  * To save an update, type at the prompt: `git commit -a`
      * The `-a` option makes the commit include all files in the repository that you modified as well as all files you staged via git add. Without the -a option, only the files you staged via git add are included.

    Then, follow the instructions to enter a message.
      * Try to enter a helpful message summarizing your changes. It can be very short if you want. Just please note that messages like "a" or "pi" are not very helpful.
      * If there are problems with bringing up an editor, try configuring git to use another editor. If that still fails, use the `-m` or the `-F` option to specify a commit message. You can specify the message on the command line with `git commit -m "<message>"`, or write a commit message in a file and use `git commit -F <file>`.
      * It's a good idea to have the first line of the commit message be a short summary of the changes. This can be followed by a more detailed description. Many tools display just the first line, so it should be a stand-alone summary.
  * After you commit an update, to submit it so everyone else can see it, type at the prompt: `git push`

Note that `git commit` only saves your changes locally; no one else can see that you have committed changes until you run `git push`. You must both commit and push for others to be able to see your changes.

When you git push, if someone else pushed between when you started editing and when you pushed, the push will fail. You must first git pull, then git push again.

When you git pull, you may end up with a merge conflict, which means that your changes conflict with someone else's. This is probably because you both made edits to the same line of the same file. In this situation, you must manually resolve the merge conflict. You may want to see the [git user manual's section on merging](http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#how-to-merge) to learn how to deal with a merge conflict. **Please ask for help if you don't know what to do.** Just don't blindly charge ahead without any idea of what you're doing, as there's a good chance you'll mess up the merge if you do.

Because having to manually deal with merge conflicts can be painful, try to avoid editing the same part of a file as someone else (this is a bad idea in general). Try to pull frequently, especially before you begin making changes. You should also commit and push frequently. Both of these are because the more out-of-sync your copy of the repository becomes with other people's, the more likely it is for work to be duplicated or for a merge conflict to appear. In addition, commiting and pushing frequently means that your edits are saved and backed up, which keeps you from possibly losing work and allows you to return to previous versions, perhaps after you make a mistake.

Other helpful commands:

  * Use `git help` to get help.
  * Use `git log` to see a listing of previous commits.
  * Use `git checkout <file>` to revert a file back to the version in the latest commit.
  * You can also use git-gui, a graphical user interface for git, if you prefer not to work with the command line interface. In addition, you can use gitk to display a nice visualization of the commit history.

If you'd like to learn more about git, there are many tutorials and resources for git. For a relatively brief but very useful tutorial, see the [official git tutorial](http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html) also available via `man gittutorial`. This tutorial also has a number of helpful links at the bottom. Unfortunately, gittutorial provides little coverage of some topics, like branching and merging. For a more comprehensive tutorial, see the git user manual.

# Instructions for problem writing

There are a number of LaTeX files for the problems and tests. The easiest way to compile all of these is to run `make` or `./CompileEverything`.

You can view any problem by compiling its file.

You can view all of the problems by compiling all-problems.tex (the problems only) or all-draft.tex (the full draft including problems and solutions). You can run `make` or `./CompileAllProblems` to automatically compile these files.

You can also view all problems by category by compiling the files under the categorized/ directory, such as categorized/team-problems.tex.

See [Compiling](#compiling) for more details.

## Problem format

Every problem for SMT should be placed in its own file in the problems directory. Such files should contain just the problem, formatted as in the following example:

    \input{../other/problem-preamble.tex}
    \ques[Alg]
    \label{MS01}
    \begin{question}
    Compute &#36;1 + 1&#36;.
    \end{question}

    \begin{comment}
    This is an optional comment.
    \end{comment}

    \begin{answer}
    &#36;2&#36;
    \end{answer}

    \begin{solution}
    &#36;1 + 1 = \ans{2}&#36;.
    \end{solution}

    \problemend

The argument to `\ques` indicates which test the problem belongs in: Gen, Alg, Geo, AT, Calc, Team, or Fun. Omit the argument to leave the problem unsorted.

The comment section is optional. Comments show up only on draft versions of the test, not on the final test.

The problem label (MS01 in the example) should be the same as the problem's file name. Labels and file names are case-sensitive!

We are using the convention of naming problems with the author's initials followed by two digits, (e.g. MS01, MS02, etc.), in order to prevent conflicts in problem labels.

If the answer appears at the end of a solution, it should be placed in \ans, which adds formatting.

Please break long lines. If possible, keep lines under around 80 characters, or at least ensure that you don't have entire paragraphs on the same line. Git works better with short lines, and avoiding long lines makes the text easier to read in narrow windows. Many text editors can automatically break long lines, including Emacs (Auto-Fill) and vim (textwidth).

## Categorizing problems

Here are guidelines on how to categorize problems:

  * Alg/AT/Calc/Geo: A problem that could appear on the relevant subject test (or on the general test if it is easy enough).
  * Gen: A problem written for the general test that should not appear on any other test.
  * Team: A problem either written for the team test or a problem that does not fit well on any of the other tests.
  * Fun: A problem that cannot be used on the general/subject/team tests, and can be used as a fun round problem if any sites wishes to hold one.

## Multiple solutions

If a problem has multiple solutions, each solution should be in a separate `\begin{solution*}` and `\end{solution*}` (note the `solution*` instead of `solution`), and should start with `\soln{1}`, `\soln{2}`, etc. Here is an example:

    \input{../other/problem-preamble.tex}
    \ques[Alg]
    \label{MS01}
    \begin{question}
    Compute &#36;1 + 1&#36;.
    \end{question}

    \begin{answer}
    &#36;2&#36;
    \end{answer}

    \begin{solution*}
    \soln{1}
    Trivial.
    \end{solution*}

    \begin{solution*}
    \soln{2}
    Obvious.
    \end{solution*}

    \problemend

## Making tests

The problems for each individual test, tiebreaker, and the team test should be listed in the inputs.txt file in the relevant directory (just a list of the problem IDs, in order, with one on each line). You can optionally add comments to a test in the comments.tex file.

For example, to create the algebra test, create the `algebra/inputs.txt` file containing a list of problem IDs, as in the following example:

    NW15
    RJ06
    LY01
    ...

## Compiling

There are a number of LaTeX files for the problems and tests. The easiest way to compile all of these is to run make or `./CompileEverything`.

You can view any single problem simply by compiling the file containing that problem. This means you can easily edit and compile a problem with your LaTeX program of choice.

The all-problems and all-draft files include all problems. You can run make or `./CompileAllProblems` to automatically compile these files. Of course, you can also compile these files with your favorite LaTeX program. However, if you are compiling these files without using one of our scripts and you add a problem, you'll have to manually add your problem to other/inputs.tex for it to show up.

You can compile all of the files for each test by running `./CompileTests <test>`, or run `./CompileTests all` to compile all tests.
