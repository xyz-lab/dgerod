# User manual

## Structure

```
.
├── index.html            Home: Portfolio slideshow + projects (left), Lifestream (right)
├── about-me.html         About me
├── style.css             Styles for the whole site
├── images/               Logo and About me photo
├── portfolio/            Portfolio slideshow images (01.jpg … 30.jpg)
├── blog/
│   ├── index.html        Blog page (/blog/): posts by year and by tag
│   ├── _posts/           Blog posts, in Markdown
│   └── _drafts/          Drafts (not published)
├── _layouts/
│   ├── default.html      Header, menu and footer for the blog and posts
│   └── post.html         Template for each post
├── _config.yml           Jekyll configuration
├── Gemfile               Dependencies to preview the site locally
├── README.md             Short description of the repo
└── docs/README.md        This document (not published on the site)
```

### What needs Jekyll

| Part | Needs Jekyll? |
|---|---|
| `index.html`, `about-me.html` | No: plain HTML, you can open them directly in a browser |
| `blog/`, the posts and the RSS feed (`feed.xml`) | Yes: opened directly they look broken (you see `{% ... %}` code) |

### Folders starting with `_`

They are special Jekyll folders: Jekyll reads them to build the site but does not publish them as they are.

- `_posts/` and `_drafts/` can live in any subfolder (here, `blog/`).
- `_layouts/` and `_config.yml` must stay at the root; that is the only place Jekyll looks for them.

The names are fixed: if you rename them, Jekyll stops recognising them.

## Pages

- **Home** (`index.html`): tagline, the Portfolio (image slideshow and project cards), and the Lifestream on the right. On screens narrower than 860 px the Lifestream moves below the Portfolio.
- **Blog** (`blog/index.html`): all posts grouped by year, and a list by tag.
- **About me** (`about-me.html`): bio, photo and links to other profiles.

Menu: Home · Blog · Twitter · LinkedIn · GitHub · About me.

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

Drafts go in `blog/_drafts/` without a date in the file name. To preview them locally: `bundle exec jekyll serve --drafts`.

## Previewing locally

GitHub Pages builds Jekyll automatically; locally you have to install it.

First time only (Ubuntu):

```bash
sudo apt install ruby-full build-essential zlib1g-dev
cd website
bundle config set --local path vendor/bundle
bundle install
```

Every time you want to preview the site:

```bash
bundle exec jekyll serve
```

and open http://localhost:4000. The site rebuilds when a file changes; just reload the browser.

> The `Gemfile` includes `csv`, `base64`, `bigdecimal` and `logger` because Ruby 3.4+ no longer ships them by default and Jekyll 3 (the version GitHub Pages uses) needs them.

## Maintenance

- **Menu:** it lives in three places: `index.html`, `about-me.html` and `_layouts/default.html`. If you change it, change all three.
- **Portfolio images:** they are in `portfolio/` and listed in the `<script>` at the end of `index.html` (the `FILES` array). To add one, copy the image and add its name to the array.
- **Portfolio projects:** loaded from GitHub when the page opens: every repo of `dgerod` with the topic `portfolio`, most starred first. To show or hide a repo, add or remove that topic on GitHub (repo page → ⚙ next to "About" → Topics). If GitHub cannot be reached or no repo has the topic, a message with a link to the GitHub repositories is shown instead.
- **Lifestream:** uses the official X widget. It may not load for visitors who are not logged in to X, so there is a fallback link.

## Publishing

The site lives in the `xyz-lab/dgerod` repo and is published with GitHub Pages at https://dgerod.xyz-lab.org.es/ (the `CNAME` file sets the custom domain; in IONOS, `dgerod.xyz-lab.org.es` is a CNAME to `xyz-lab.github.io`). After a push to the main branch, GitHub Pages builds and publishes the site within a few minutes.

URLs:

- posts are at `/blog/YYYY/MM/DD/title.html` (set by `permalink` in `_config.yml`);
- `/blog.html`, `/archive.html` and `/by_tags.html` redirect to `/blog/`;
- the RSS feed is at `/feed.xml`.
