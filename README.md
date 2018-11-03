# awm(1) -- _Alfred_ Workflow Manager <img src="https://github.com/danielbayley/homebrew-alfred/blob/master/logo.svg" width="8%" align="right">

## SYNOPSIS
`awm command` [`--options`] [`arguments`]

DESCRIPTION
-----------
Extend _[homebrew-alfred][SEE ALSO]_ to manage your [Alfred][SEE ALSO] [workflow][SEE ALSO]* development cycle from the command line.

\* Requires the paid _[Powerpack][SEE ALSO]_ upgrade.

INSTALL
-------
brew(1) `tap danielbayley/alfred`  
brew(1) `install awm`

OPTIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| `command`                  | `[options]`/`arguments`               | `--help`                                                                                                                                                                                                                                                                                                              |
|:---------------------------|:--------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                            | `-`[`-h`]`elp`                        | Display this helpful summary.                                                                                                                                                                                                                                                                                         |
|                            | `-`[`-v`]`ersion`                     | Print the installed version of `awm`.                                                                                                                                                                                                                                                                                 |
|                            | `--workflows`                         | Print the `workflows` installation path. brew(1) `alfred --workflows` alias.                                                                                                                                                                                                                                          |
| `info`                     | [`alfred-`]`workflow`                 | Display `info`rmation about the given workflow[s]. brew(1) `alfred info` alias.                                                                                                                                                                                                                                       |
| `list`/`ls`                |                                       | List installed workflows. brew(1) `alfred list` alias.                                                                                                                                                                                                                                                                |
| [`un`]`install`/`rm`/`zap` | [`alfred-`]`workflow`                 | [`un`]`install` the given workflow[s]. brew(1) `alfred `[`un`]`install`/`zap` alias.                                                                                                                                                                                                                                  |
| `update`                   |                                       | Update all workflows. brew(1) `alfred update` alias.                                                                                                                                                                                                                                                                  |
| `disable`/`enable`         | [`alfred-`]`workflow`                 | Toggle activation of the given workflow[s] in Alfred.                                                                                                                                                                                                                                                                 |
| `init`                     | [`**/folder`]                         | git(1) `init`ialise a workflow based on the project [template][SEE ALSO].                                                                                                                                                                                                                                             |
|                            | `--template **/template`              | Specify a path to override the default workflow [template][SEE ALSO]. This takes precedence over [`HOMEBREW_AWM_TEMPLATE`][ENVIRONMENT].                                                                                                                                                                              |
| `dev`[`elop`]              | [`alfred-`]`workflow`                 | git(1) `clone` or download an existing workflow, ready for local development.                                                                                                                                                                                                                                         |
|                            | `--icon` [`"App Name"`/`*.app`]       | Generate a workflow icon with _[librsvg][SEE ALSO]_ if an `icon.svg` is present, or copy from a given app. Should the workflow _[bundle ID][SEE ALSO]_ **exactly** match that of an existing app, then the corresponding icon is copied. osascript(1) `-e 'id of app "Name"'` will give you the bundle ID of any app. |
| [`un`]`link`               |                                       | [Sym`link`][SEE ALSO] or `unlink` the current directory into the `workflows` install path for Alfred to [un]load.                                                                                                                                                                                                     |
| `prune`                    |                                       | Remove any broken [symlinks][SEE ALSO] in the `workflows` install path. brew(1) `alfred prune` alias.                                                                                                                                                                                                                 |
| `test`                     |                                       | Run any [`pre-commit` hook][SEE ALSO], or npm(1) [`test`][SEE ALSO] if a [`package.json`][SEE ALSO] is present.                                                                                                                                                                                                       |
| [`un`]`publish`            | [`M`]`ajor`/ [`m`]`inor`/ [`p`]`atch` | Bump the [_Semantic_ Version][SEE ALSO] number and cut a [release][SEE ALSO] using _[`ghr`][SEE ALSO]_.                                                                                                                                                                                                               |
|                            | [`v`]`M.m.p`/`--amend`                | Manually specify a version, or `--amend` the latest release. Existing given versions will be `--amend`ed.                                                                                                                                                                                                             |
|                            | `--preview`                           | List contents of the previously generated `.alfredworkflow`.                                                                                                                                                                                                                                                          |
|                            | `-`[`-i`]`nclude gl*b`                | Force inclusion of any extra un`commit`ted files matching the given [glob pattern][SEE ALSO]. These are passed to the underlying zip(1) command. Multiple patterns can be specified with additional `-`[`-i`]`nclude` patterns.                                                                                       |
|                            | `-`[`-t`]`itle`                       | Specify a release title, other than the default (`vM.m.p`).                                                                                                                                                                                                                                                           |
|                            | `-`[`-d`]`escription`                 | Describe this release.                                                                                                                                                                                                                                                                                                |

EXAMPLES
--------
Note that the `alfred-` prefix is optional when passing workflow names as arguments, of which multiple can be given.

* `awm info things alfred-numi`:
  Display brew(1) `alfred info`rmation about `alfred-things` and `alfred-numi`.

* `awm develop numi`:
  git(1) `clone` the associated repository and re`init`ialise it,  
  running any [`post-checkout` hook][SEE ALSO], then `awm link` it into the  
  `workflows` install path, ready for local development.

* `awm publish major -t "First Release"`:
  Generate the `.alfredworkflow` and cut a `v1.0.0` (if initial) [release][SEE ALSO], with the given `--title`.

* `awm publish --amend -i \*.md`:
  Add any un`commit`ed markdown files to the previous [release][SEE ALSO].

## ENVIRONMENT
[ENVIRONMENT]: #environment
Export a `HOMEBREW_AWM_TEMPLATE` variable with a specified path to override the default workflow [template][SEE ALSO].

## BUGS
Open an [issue](https://github.com/danielbayley/awm/issues)

## AUTHOR
[AUTHOR]: #author
[Daniel Bayley](https://github.com/danielbayley) <daniel.bayley@me.com>

## COPYRIGHT
[MIT] (C) 2018 [Daniel Bayley][AUTHOR]

[MIT]: https://github.com/danielbayley/awm/blob/master/LICENSE.md

## SEE ALSO
[SEE ALSO]: #see-also

[Homebrew](https://brew.sh)  
[External command](https://docs.brew.sh/External-Commands)  
[home`brew`-`alfred`](https://github.com/danielbayley/homebrew-alfred#readme)

[Alfred](http://alfredapp.com)  
[Powerpack](https://alfredapp.com/powerpack)  
[Workflow](https://alfredapp.com/workflows)  
<!--
[Template][template]  
[template]: https://github.com/danielbayley/awm/tree/master/template
-->
[Template](https://github.com/danielbayley/awm/tree/master/template)  
[Bundle ID](https://alfredapp.com/help/workflows/advanced/sharing-workflows)

git(1) [`init`](https://git-scm.com/docs/git-init)  
[Templates](https://git-scm.com/docs/git-init#_template_directory)  
[`pre-commit` hook](https://git-scm.com/docs/githooks#_pre_commit)  
[`post-checkout` hook](https://git-scm.com/docs/githooks#_post_checkout)

[`package.json`](https://docs.npmjs.com/files/package.json)  
npm(1) [`test`](https://docs.npmjs.com/cli/test)

[Glob patterns](https://npm.im/glob#glob-primer)  
[Sym[bolic] links](https://en.wikipedia.org/wiki/Symbolic_link)

[_Semantic_ Versioning](https://semver.org)  
[GitHub Releases](https://help.github.com/articles/about-releases)  
[`ghr`](https://deeeet.com/ghr)

[librsvg](https://wiki.gnome.org/Projects/LibRsvg)

brew(1), curl(1), git(1), npm(1), rsvg-convert(1), zip(1), zsh(1)
