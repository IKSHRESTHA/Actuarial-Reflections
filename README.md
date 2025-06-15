# Actuarial Reflections

A Quarto website for actuarial and data science reflections, structured for GitHub Pages deployment.

## Features
- Top navigation bar: Home, Actuarial Projects, Data Science Projects, About
- 3-column project grid on homepage
- Project listing pages with filterable tags, date sorting, summaries
- Standardized YAML headers for projects
- SEO: sitemap.xml, robots.txt
- Actuarial project cards with icons and blue/green color scheme
- Data science project template with code snippets and ML badges
- Automated Related Articles section
- Responsive author bio, CV download, contact form with CAPTCHA
- Mobile responsive, hamburger menu, dark/light mode toggle
- GitHub Actions for build/deploy
- Accessibility (WCAG 2.1 AA)
- Page speed optimizations
- 404 error page with search and home link

## Local Preview
1. Install [Quarto](https://quarto.org/docs/get-started/)
2. In this folder, run:
   ```powershell
   quarto preview
   ```
3. Check for missing dependencies in the Quarto output

## GitHub Pages Deployment
1. Push this project to a new GitHub repository
2. In repo settings, set GitHub Pages source to `main` branch, `/docs` folder
3. Add the provided GitHub Actions workflow for auto-deploy
4. Visit your site at `https://<your-github-username>.github.io/<your-repo-name>/`

## License
[MIT](LICENSE)
