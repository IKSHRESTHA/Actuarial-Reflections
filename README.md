# Quarto Website Project

This is a simple Quarto website created with a blog structure similar to themockup.blog. The website includes:

## Features

- **Blog section**: Main page displaying blog posts in a listing format
- **About Me section**: Simple about page
- **Article**: "How to Become an Actuary in Nepal" - a comprehensive guide
- **Clean design**: Modern styling with hover effects and responsive design
- **GitHub Actions**: Automated deployment to GitHub Pages

## Structure

```
quarto_website/
├── _quarto.yml          # Main configuration file
├── index.qmd            # Blog listing page
├── about.qmd            # About me page
├── styles.css           # Custom CSS styling
├── posts/
│   └── actuary-in-nepal.qmd  # Blog post about becoming an actuary in Nepal
└── .github/
    └── workflows/
        └── publish.yml  # GitHub Actions workflow for deployment
```

## Local Development

1. Install Quarto from https://quarto.org/docs/get-started/
2. Navigate to the project directory
3. Run `quarto preview` to start a local development server
4. Run `quarto render` to build the static site

## GitHub Pages Deployment

1. Push this project to a GitHub repository
2. Go to repository Settings > Pages
3. Set Source to "GitHub Actions"
4. The workflow will automatically build and deploy on every push to main branch

## Customization

- Edit `_quarto.yml` to change site title and navigation
- Modify `styles.css` to customize the appearance
- Add new blog posts in the `posts/` directory
- Update the About Me page in `about.qmd`

## Navigation

The website has a simple navigation bar with:
- **Blog**: Main page with blog post listings
- **About Me**: Information about the site creator

No external integrations like GitHub links, LinkedIn, comments, or Google Analytics are included as requested.

