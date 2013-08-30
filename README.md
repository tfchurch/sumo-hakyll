# SUMO in Hakyll

The [website for SUMO (Stanford University Math
Organization)](http://sumo.stanford.edu/) needs a rewrite, so I'm giving it
a mobile-responsive redesign with implementation in Hakyll.

## Setting up your machine for development

This is a simple guide to editing the SUMO website for Eddy and Raymond and
whoever else wants to edit the content of the website. 

### How do I install things? 

First, you'll need GHC and cabal-install, the easiest way to do this is to
install the [Haskell Platform](http://www.haskell.org/platform/) for your OS. 

Once you have Haskell, in a terminal run `cabal install hakyll` to install the
magical [Hakyll library](http://jaspervdj.be/hakyll/) that we use for building
the site into static HTML files. Then clone this repo. If you plan to be doing
many edits to the site ask Lennart to add you as a collaborator on this
repository in GitHub so you can push directly. Otherwise, fork and open pull
requests. 

In your cloned repo, run `ghc --make site.hs` to build the `site` executable,
which is the tool to build the website, clean the built files, and other such
useful tasks. To make sure things are working, run `./site rebuild`, this will
clean out all built files and rebuild things from scratch. This command builds
and copies files into the `_site` directory, these are the files that are
deployed to Stanford AFS. 

Once the site builds, run `./site preview` to start a simple static file preview
server, then point your browser to `localhost:8000` to test the site. If you see
the friendly SUMO home page, all is well! If not, complain to Lennart.

### How do I change things?

All the content for the site is conveniently written in Markdown format. The
pages that exist right now are `index.md`, `smt.md`, `speakers.md` and
`contact.md`. `index.md` and `contact.md` showcase some more complicated markup
patterns, use them for reference. If you just need to change a couple words,
then everything should be self-explanatory.

### How do I add a page?

Each page has a `.md` file for the content and a `.md.metadata` file for the
metadata. The metadata file needs to have two keys, the title for the page and
a variable name to use for the navbar (to get the current page highlighted).
Choose a unique identifier for this. Then, to add a new page to the navbar, edit
`templates/default.html`, and add a new `li` to the navbar `ul` with the
templating `$if$` just like the other navbar items.

Static files can be added easily to the `images`, `js`, or `css` directories and
they will be copied over into the compiled site.

To add new partial-creating macros like the ones used in `index.md`, create
simple HTML files in the `templates` directory. Then add a Haskell tuple to the
list of tuples in `partialmacros.hs`, where the first element in the desired
macro name to use in files and the second element is the filename in the
`templates` directory. This is useful for introducing more complicated markup
into pages than is possible with just Markdown syntax.

### Okay, I'm done. How do I deploy?

Once you've done your edits and made sure everything works properly (using the
preview server described above), do a fresh rebuild with `./site rebuild`. Then,
deploy with the command `./site deploy`. You will be prompted for your SUNet
username and password to connect to Stanford AFS, and then the site will
magically be deployed!

But then you'll definitely also want to push back to this repo so your deployed
changes don't get stomped by the next guy. If you have collaboration privileges,
just `git push` your changes back (after merging from upstream if someone else
has changed something). If not, push to your own branch and open a pull request.

**Let Lennart know if you have any remaining questions!**
