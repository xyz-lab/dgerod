# User manual

## Structure

```
.
├── index.html            Home: Portfolio slideshow + project cards (left), latest notes (right)
├── projects/             Projects: index.html (one section per project) and its images
├── publications/         Publications: index.html (articles, conference papers, PhD thesis, patents, talks)
├── about-me.html         About me
├── style.css             Styles for the whole site
├── favicon.svg           Favicon ("DE");
├── images/
├── portfolio/            Portfolio slideshow images + captions.md (captions and links)
├── blog/
│   ├── index.html        Blog page (/blog/): posts by year and by tag
│   ├── _posts/           Blog posts, in Markdown
│   ├── images/           Images used by the posts
│   ├── files/            Other files used by the posts (e.g. talk slides, PDF)
│   └── _drafts/          Drafts (not published)
├── _includes/
│   ├── header.html       Header (logo and menu) shared by every page
│   ├── favicon.html      Links to the favicon, shared by every page
│   └── email.html        Email link (address hidden from simple bots)
├── _layouts/
│   ├── default.html      Header, menu and footer for the blog and posts
│   └── post.html         Template for each post
├── _config.yml           Jekyll configuration
├── Gemfile               Dependencies to preview the site locally
├── README.md             Short description of the repo
└── docs/user-manual.md   This document (not published on the site)
```

### What needs Jekyll

**Every page needs Jekyll**: to see the site on your computer, always run it with Jekyll (see [Previewing locally](#previewing-locally)). Opening the HTML files directly in the browser does not work.

| Part | Needs Jekyll? |
|---|---|
| `index.html`, `projects/index.html`, `publications/index.html`, `about-me.html` | Yes: they are HTML, but Jekyll fills in the version of the style sheet (and, in `index.html`, the latest notes). Opened directly, the styles do not load |
| `blog/`, the posts and the RSS feed (`feed.xml`) | Yes: opened directly they look broken (you see `{% ... %}` code) |

### Folders starting with `_`

They are special Jekyll folders: Jekyll reads them to build the site but does not publish them as they are.

- `_posts/` and `_drafts/` can live in any subfolder (here, `blog/`).
- `_layouts/` and `_config.yml` must stay at the root; that is the only place Jekyll looks for them.

The names are fixed: if you rename them, Jekyll stops recognising them.

## Pages

- **Home** (`index.html`): tagline, the Portfolio (image slideshow and project cards), and the latest notes on the right. On screens narrower than 860 px the latest notes move below the Portfolio.
- **Blog** (`blog/index.html`): all posts grouped by year, and a list by tag.
- **Projects** (`projects/index.html`): one section per project, newest first, with its images in the same folder (separate from the slideshow images in `portfolio/`). Each section has an `id` that the slideshow and the project cards of the home page link to.
- **Publications** (`publications/index.html`): journal articles, conference papers, the PhD thesis, the patents and the public talks, written by hand. The full record, with citations and legal status, is in `perfil-base` (`publications.md`, `patents.md` and `talks.md`); the page only shows what is worth publishing. Patents are grouped by line of work and link to Google Patents; applications that were refused or withdrawn are shown only as their WO/EP number.
- **About me** (`about-me.html`): bio, photo and links to other profiles.

Menu: Home · Projects · Publications · Scratchpad · GitHub · X / Twitter · LinkedIn · About me.

## Writing a post

1. Create `blog/_posts/YYYY-MM-DD-short-title.md`.
2. Start it like this (the first `# ...` line is the title):

   ```markdown
   ---
   tags: robotics ROS simulation
   ---

   # Post title

   Text...
   ```

3. It is published at `/blog/YYYY/MM/DD/short-title.html` and shows up in `/blog/` and in the RSS feed.
4. In `/blog/` (Scratchpad) each post shows its first paragraph (cut at 35 words) as an intro, so start the post with a plain text paragraph. To write a different intro, add `summary: "..."` to the front matter.

Drafts go in `blog/_drafts/` without a date in the file name. To preview them locally: `bundle exec jekyll serve --drafts`.

## Previewing locally

GitHub Pages builds the site with Jekyll automatically when you push. On your computer you always have to run Jekyll to see it: opening the HTML files directly in the browser shows the pages without styles, without the latest notes and without the portfolio cards.

First time only (Ubuntu):

```bash
sudo apt install ruby-full build-essential zlib1g-dev
cd website-dgerod
bundle config set --local path vendor/bundle
bundle install
```

Every time you want to preview the site, from the `website-dgerod` folder:

```bash
bundle exec jekyll serve
```

and open http://localhost:4000. The site rebuilds when a file changes; just reload the browser. To stop it, press `Ctrl+C` in the terminal.

To include the drafts of `blog/_drafts/`, add `--drafts`. If port 4000 is busy, use another one with `--port 4001`.

> The `Gemfile` includes `csv`, `base64`, `bigdecimal` and `logger` because Ruby 3.4+ no longer ships them by default and Jekyll 3 (the version GitHub Pages uses) needs them.

## Maintenance

- **Title, description and link previews:** every page has `{% seo %}` (plugin `jekyll-seo-tag`) in its `<head>`, which writes the `<title>`, the description and the Open Graph / Twitter tags used by LinkedIn, WhatsApp, X, etc. to show a preview card. Each page sets them in its front matter (`title:` and `description:`); the home page uses `title` and `tagline` from `_config.yml`. The card image is the "DE" logo, `apple-touch-icon.png`, for every page (set in `defaults` in `_config.yml`); a page or post can use another one with `image:` in its front matter.
- **Style sheet version:** every page links `style.css?v=…`, where the number is the time the site was built. Each publication changes it, so browsers download the new `style.css` instead of using a cached copy (GitHub Pages lets them keep it for 10 minutes).
- **Email:** the contact address is `email:` in `_config.yml`. Pages show it with `{% include email.html %}` (or `{% include email.html text="Email" %}` for a fixed text). The include writes the `mailto:` link with JavaScript, so the full address is not in the HTML for simple spam bots; without JavaScript it shows `user [at] domain`. It is used in the About me page and in the contact line at the end of each post (`_layouts/post.html`).

- **Menu:** the header (logo and menu) lives in one place, `_includes/header.html`, included by every page. The current page is marked when its URL matches `page.url`; the Scratchpad is also marked while reading a post. To add a page to the menu, add an entry there with its URL.
- **Portfolio images:** they are in `portfolio/`, named `NN.ext` or `NN-M.ext` (`NN` = group, `M` = photo in the group); the slideshow shows them ordered by file name. Their captions and links are in the table of `portfolio/captions.md`. To add a photo, copy it into `portfolio/` and add a row to the table. The page reads the table when it loads, so to preview it locally you need a web server (`bundle exec jekyll serve` or `python3 -m http.server`), not the file opened directly.
- **Portfolio projects:** the cards under the slideshow come from two places, both marked with `portfolio`: the projects of `projects/index.html` and the GitHub repositories. See [Choosing the portfolio projects](#choosing-the-portfolio-projects).
- **Latest notes:** the five newest posts, listed by Jekyll when the site is built. Nothing to maintain: publishing a post updates them.
- **Post images:** they go in `blog/images/`, not in `blog/_posts/`: Jekyll 3 (the version GitHub Pages uses) does not publish files from `_posts/` that are not posts. Reference them with an absolute path, e.g. `![Diagram](/blog/images/name.png)`.
- **Post files:** other files that belong to a post (talk slides, PDFs) go in `blog/files/`, named in lower case without accents (e.g. `tdd-iri-2014.pdf`). Files live next to the content that explains them; the Publications page only links to them.

## Choosing the portfolio projects

The project cards of the home page are not written in `index.html`: they are read when the page opens from two places, and both use the same word, `portfolio`, to choose what is shown:

- **Projects of the website** (`projects/index.html`) with the class `portfolio`. Their cards link to the project in the Projects page.
- **GitHub repositories** of `dgerod` with the topic `portfolio`. Their cards link to the repository.

The cards are shown in two blocks: first the projects of the website, followed by the link "All projects", and then the GitHub repositories, followed by the link "All repositories". Each block is sorted alphabetically by title (ignoring upper and lower case). If no repository can be shown, the GitHub cards are hidden and a message with a link to the GitHub repositories is shown instead; the link "All repositories" is always shown.

Each source works on its own: if one cannot be read, the cards of the other are still shown. If the projects of the website cannot be read, a message with a link to the Projects page is shown instead.

### Projects of the website

To show a project on the home page, add `portfolio` to the class of its `<article>` in `projects/index.html`; to hide it, remove it:

```html
<article class="case portfolio" id="robstar">
```

For each marked project, the card shows:

| In the card | Taken from |
|---|---|
| Title (with a link to `projects/#id`) | the `<h3>` and the `id` of the `<article>` |
| Text | the first sentence of the first paragraph after `case-meta`, cut at about 170 characters with "…" |
| Dates and organisation | the `<p class="case-meta">` |

The image, the other paragraphs and the links of the project are not shown in the card.

Tips:

- Write a short first sentence that says what the project is: it is the text of the card.
- The cards are shown in two columns, so an even number of projects looks better.
- The projects of the website are sorted alphabetically by title, not in the order of `projects/index.html`.
- The page reads `projects/index.html` when it loads, so to preview the cards locally you need a web server (`bundle exec jekyll serve`), not the file opened directly.

### GitHub repositories

To show a repository on the home page, add the topic `portfolio` to it on GitHub (repository page → ⚙ next to "About" → Topics); to hide it, remove the topic. Only public repositories owned by `dgerod` are considered.

| In the card | Taken from |
|---|---|
| Title (with a link to the repository) | the name of the repository |
| Text | the first sentence of the repository description ("About"), cut at about 170 characters with "…" |
| Meta | "GitHub", the main language and the stars, if any |

Write a description that says what the repository is: it is the text of the card. The GitHub API allows about 60 requests per hour per visitor without logging in; if the limit is reached, only the projects of the website are shown.

## Publishing

The site lives in the `xyz-lab/dgerod` repo and is published with GitHub Pages at https://dgerod.xyz-lab.org.es/ (the `CNAME` file sets the custom domain; in IONOS, `dgerod.xyz-lab.org.es` is a CNAME to `xyz-lab.github.io`). After a push to the main branch, GitHub Pages builds and publishes the site within a few minutes.

### How to publish

Stage the changes and run, from `main`:

```bash
tools/publish.sh <branch>              # Claude proposes the commit message
tools/publish.sh <branch> -c "<why>"   # ... using this context too
tools/publish.sh <branch> "<message>"  # Use only this message
```

The script commits what is staged on a new branch, pushes it, fast-forwards `main`, pushes `main` and waits for the Pages build. Unstaged changes are left as they are. It stops before doing anything if `main` is not in sync with `origin/main`, or if a staged page uses an image (`src="..."`) that is not in the repository.

Without a message it runs `claude -p` (Claude Code) on the staged diff, shows the proposed message and asks whether to use it, edit it or cancel.

After publishing, CSS changes may take up to 10 minutes to show (Pages caches them); reload with Ctrl+Shift+R.

### URLs

- posts are at `/blog/YYYY/MM/DD/title.html` (set by `permalink` in `_config.yml`);
- `/blog.html`, `/archive.html` and `/by_tags.html` redirect to `/blog/`;
- the RSS feed is at `/feed.xml`.
