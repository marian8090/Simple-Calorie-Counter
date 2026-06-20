# Simple Calorie Counter

## Overview

A vanilla JS Progressive Web App (PWA) for tracking daily calorie intake. Zero dependencies, no build tools — entirely self-contained in a single HTML file served statically.

## Project Structure

```
index.html      All HTML, CSS (embedded <style>), and JS (embedded <script>)
manifest.json   PWA manifest (name, icons, theme color, display mode)
sw.js           Service worker — cache-first offline strategy
icons/          PNG app icons (120, 152, 167, 180, 192, 512 px)
README.md       Brief project description
```

## How to Run

Any static file server works:

```bash
python3 -m http.server 8080
# then open http://localhost:8080
```

No build step, no npm install, no dependencies.

## Architecture

### Single-file app (`index.html`)

- **CSS** (lines 21–346): All styles using CSS custom properties for theming. Dark mode variables live in `@media (prefers-color-scheme: dark)` and `[data-theme="dark"]`.
- **HTML** (lines 349–484): Three `<section class="screen">` elements (today / meals / settings), a bottom `<nav class="tabs">`, and an "Add Food" modal.
- **JS** (lines 486–893): Vanilla ES2020+, no framework. Key functions:
  - `initialize()` — called on load, seeds the UI
  - `renderToday()` — updates the progress bar and entry list
  - `showScreen(name)` — tab navigation
  - `openAddFoodModal()` / `closeAddFoodModal()` — modal control
  - `addEntry()`, `deleteEntry()` — calorie log mutations
  - `saveMeal()`, `deleteMeal()` — personal meal CRUD
  - `toggleTheme()` — light/dark mode toggle; persists to `localStorage`

### Data (`localStorage`)

Key: `"simpleCalorieCounterData"`

```js
{
  dailyBudget: 2000,       // number
  meals: [{ id, name, calories }],
  entries: [{ id, date, time, name, calories, source }]
}
```

`date` is `YYYY-MM-DD` (ISO string slice). `source` is `"manual"`, `"personal meal"`, or `"reference food"`.

### Theme preference

Key: `"theme"` → `"light"` | `"dark"` | absent (follows OS).  
Applied as `data-theme` attribute on `<html>`.

## PWA Notes

- **Service worker** (`sw.js`): cache-first, cache name `calorie-counter-v1`. Bump this string whenever cached assets change.
- **Icons**: Adding new sizes requires updating both `manifest.json` and the `<link rel="apple-touch-icon">` tags in `index.html`.
- **Manifest**: `display: standalone` — hides browser chrome, renders as a native-like app.

## CSS Theming

All colors go through CSS custom properties defined in `:root`. To change the color scheme, edit only the variable values — no need to touch individual rules.

Key variables: `--bg`, `--card`, `--text`, `--muted`, `--primary`, `--border`, `--shadow`, `--stat-bg`, `--input-bg`, `--primary-tint`, `--progress-track`, `--modal-handle`, `--toast-bg`, `--toast-text`.
