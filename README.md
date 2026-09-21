# Center for Cybersecurity Website

This document explains how the code behind the Center for Cybersecurity website (available at <https://cs.fbk.eu>) is organized and how to work with it.

## Repository Structure

The website's code is organized as follows:

```text
.
|── .github/                => GitHub configuration (workflows, templates, etc.)
|── _collaborations/        => Collaboration pages
|── _data/                  => Data used to populate lists
|── _internships/           => Internship projects
|── _people/                => People pages
|── _plugins/               => Custom Jekyll plugins
|── _projects/              => Project pages
|── _tools/                 => Tool pages
|── assets/                 => Static assets
    └── areas/              => Area-related assets
|── _config.yml             => Site configuration
|── .gitignore              => Git ignore rules
|── .markdownlint.yml       => Markdown linting configuration
|── .yamllint               => YAML linting configuration
|── 404.md                  => Custom 404 error page
|── CNAME                   => Custom domain configuration for GitHub Pages
|── docker-compose.yml      => Docker configuration for local deployment
|── favicon.png             => Website favicon
|── Gemfile                 => Ruby gem dependencies
|── Gemfile.lock            => Locked gem versions
|── index.md                => Homepage
└── README.md               => This document
```

## Local Deployment

The website can be deployed locally to preview changes in real time. This requires [Docker](https://www.docker.com/products/docker-desktop/). From the website's root folder, the container can be built and started with:

```console
docker compose up --build
```

Once the "Server running..." message appears, the website is available at `http://localhost:4001`. Any changes are reflected in the local preview shortly after, once the rebuild completes.

Once the container is no longer needed, it can be stopped with:

```console
docker compose down
```
