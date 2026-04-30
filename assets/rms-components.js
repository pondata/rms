/**
 * rms-components.js — Custom elements for the RMS site.
 * Single source of truth for <nav> and <footer> across every page.
 *
 * Usage on each page:
 *   <rms-nav active="services"></rms-nav>     (active is optional)
 *   <rms-footer></rms-footer>
 *
 * To prevent layout shift, every page should include the matching
 * <link rel="stylesheet" href="/assets/rms-nav.css"> in <head>. Custom
 * elements upgrade asynchronously, so we render an inline skeleton via
 * connectedCallback() that uses the same CSS classes as the final markup —
 * the swap is then style-identical.
 *
 * Why custom elements (not <iframe>, not server-side includes):
 *   - GitHub Pages has no build step; this works in plain HTML
 *   - Custom elements are a web standard, no framework dependency
 *   - Googlebot renders JS, so SEO sees the rendered nav
 *   - Style isolation is opt-in via attachShadow (we don't, on purpose:
 *     the existing <link>'d stylesheet must reach into the nav)
 */

(function () {
  'use strict';

  // ----- shared markup (HTML strings) -------------------------------------
  // Keep these in sync with assets/rms-nav.css class names. Changing nav copy
  // here updates every page on next deploy.

  const NAV_ITEMS = [
    { key: 'it',           href: '/services/it-operations.html',     label: 'IT' },
    { key: 'logistics',    href: '/services/logistics-events.html',  label: 'Logistics' },
    { key: 'industries',   href: '/industries/',                     label: 'Industries' },
    { key: 'pricing',      href: '/pricing.html',                    label: 'Pricing' },
    { key: 'how-we-work',  href: '/case-studies/',                   label: 'How we work' },
    { key: 'about',        href: '/about.html',                      label: 'About' },
    { key: 'contact',      href: '/contact.html',                    label: 'Contact' },
    { key: 'blog',         href: '/blog/',                           label: 'Blog' }
  ];

  const LOGO_SVG =
    '<svg width="32" height="32" viewBox="0 0 32 32" fill="none" aria-hidden="true">' +
      '<rect width="32" height="32" rx="7" fill="#0d9488"/>' +
      '<path d="M7 23 L12 11 L16 18 L20 9 L25 23" stroke="#fff" stroke-width="3.2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>' +
    '</svg>';

  const HAMBURGER_SVG =
    '<svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true">' +
      '<path d="M4 6h16M4 12h16M4 18h16"/>' +
    '</svg>';

  const FOOTER_LINKS = [
    { href: '/',                label: 'Home' },
    { href: '/services/',       label: 'Services' },
    { href: '/industries/',     label: 'Industries' },
    { href: '/pricing.html',    label: 'Pricing' },
    { href: '/about.html',      label: 'About' },
    { href: '/contact.html',    label: 'Contact' },
    { href: '/case-studies/',   label: 'How we work' },
    { href: '/blog/',           label: 'Blog' },
    { href: '/sla.html',        label: 'SLA' },
    { href: '/pilot-terms.html',label: 'Pilot terms' },
    { href: '/privacy.html',    label: 'Privacy' }
  ];

  const PHONE_HREF = 'tel:+13606444820';
  const PHONE_LABEL = '📞 (360) 644-4820'; // 📞 (360) 644-4820

  // ----- helpers ----------------------------------------------------------

  function track(verb_noun, meta) {
    if (window.rmsTrack) {
      try { window.rmsTrack(verb_noun, meta || {}); } catch (e) { /* ignore */ }
    }
  }

  function buildNavHTML(activeKey) {
    let liItems = NAV_ITEMS.map(item => {
      const ariaCurrent = (activeKey && activeKey === item.key) ? ' aria-current="page"' : '';
      return `<li><a href="${item.href}"${ariaCurrent}>${item.label}</a></li>`;
    }).join('');

    return (
      '<nav>' +
        '<div class="nav-inner">' +
          '<a href="/" class="logo">' + LOGO_SVG + ' River Mountain Systems</a>' +
          '<ul class="nav-links" id="navLinks">' +
            liItems +
            '<li><a href="/tools/it-health-check.html" class="nav-tool">Free IT Check</a></li>' +
            '<li><a href="' + PHONE_HREF + '" class="nav-phone" data-phone-track>' + PHONE_LABEL + '</a></li>' +
          '</ul>' +
          '<button class="mobile-toggle" type="button" aria-label="Open navigation menu" aria-expanded="false" aria-controls="navLinks">' +
            HAMBURGER_SVG +
          '</button>' +
        '</div>' +
      '</nav>'
    );
  }

  function buildFooterHTML() {
    const liItems = FOOTER_LINKS.map(item =>
      `<li><a href="${item.href}">${item.label}</a></li>`
    ).join('');

    return (
      '<footer>' +
        '<a href="/" class="logo">' + LOGO_SVG + ' River Mountain Systems</a>' +
        '<ul class="footer-links">' + liItems + '</ul>' +
        '<p>&copy; <span class="ry">2026</span> River Mountain Systems · Vancouver, WA · Serving the Portland metro area.</p>' +
        '<p class="footer-disclosure">This site uses Microsoft Clarity to record sessions and Google Analytics for traffic measurement. See <a href="/privacy.html">privacy</a>.</p>' +
      '</footer>'
    );
  }

  // ----- custom elements --------------------------------------------------

  class RmsNav extends HTMLElement {
    static get observedAttributes() { return ['active']; }
    connectedCallback() { this.render(); }
    attributeChangedCallback() { this.render(); }
    render() {
      const active = this.getAttribute('active') || autoDetectActive();
      this.innerHTML = buildNavHTML(active);

      // Wire mobile toggle + tracking after render.
      const toggle = this.querySelector('.mobile-toggle');
      const links = this.querySelector('#navLinks');
      if (toggle && links) {
        toggle.addEventListener('click', function () {
          const opened = links.classList.toggle('open');
          toggle.setAttribute('aria-expanded', opened ? 'true' : 'false');
        });
      }
      const phone = this.querySelector('[data-phone-track]');
      if (phone) {
        phone.addEventListener('click', function () { track('phone_click', { location: 'nav' }); });
      }
    }
  }

  class RmsFooter extends HTMLElement {
    connectedCallback() {
      this.innerHTML = buildFooterHTML();
      // Year span — same convention as legacy ry-update script.
      const yearEls = this.querySelectorAll('.ry');
      const y = String(new Date().getFullYear());
      yearEls.forEach(function (el) { el.textContent = y; });
    }
  }

  // Auto-detect active nav item from current path. Override per page via
  // <rms-nav active="..."> if needed (e.g., a deep page that doesn't match a top-level slug).
  function autoDetectActive() {
    const path = location.pathname;
    if (path === '/' || path === '/index.html') return null;
    if (/^\/services\//.test(path)) return 'it';
    if (/^\/industries\//.test(path)) return 'industries';
    if (/^\/pricing/.test(path)) return 'pricing';
    if (/^\/case-studies/.test(path)) return 'how-we-work';
    if (/^\/about/.test(path)) return 'about';
    if (/^\/contact/.test(path)) return 'contact';
    if (/^\/blog/.test(path)) return 'blog';
    if (/^\/logistics-systems/.test(path)) return 'logistics';
    return null;
  }

  // Register on DOMContentLoaded fallback, but custom-element registration is
  // safe to run immediately — the upgrade happens whenever the element shows up.
  if (!customElements.get('rms-nav')) {
    customElements.define('rms-nav', RmsNav);
  }
  if (!customElements.get('rms-footer')) {
    customElements.define('rms-footer', RmsFooter);
  }

  // ----- Cal.com link attribution ----------------------------------------
  // Decorates every <a href*="cal.com/rivermountainsystems"> with UTM + notes
  // params so each booking arrives stamped with which page + which button it
  // came from. Justin sees the result in:
  //   - the Cal.com booking dashboard (UTM source/medium/campaign/content)
  //   - the booking confirmation email (the "Additional notes" field is
  //     prefilled with a human-readable source line, which the buyer can edit
  //     but rarely does)
  //   - any Cal.com webhook payload sent to GA4 / Slack / Zapier
  //
  // Sources (priority, first-wins):
  //   1. data-cal-source="..."  attribute on the <a>
  //   2. location:'X' inside the existing onclick rmsTrack call
  //   3. nearest <section id="...">
  //   4. nearest heading text (h1/h2/h3)
  //   5. literal "unknown"

  function deriveCalSource(a) {
    if (a.dataset.calSource) return a.dataset.calSource;
    var onclickStr = a.getAttribute('onclick') || '';
    var m = onclickStr.match(/(?:location|loc)\s*:\s*['"]([^'"]+)['"]/);
    if (m) return m[1];
    var sect = a.closest('section');
    if (sect && sect.id) return sect.id;
    var head = a.closest('section, article, main, div');
    while (head) {
      var h = head.querySelector('h1, h2, h3');
      if (h && h.textContent.trim()) return h.textContent.trim().slice(0, 50);
      head = head.parentElement && head.parentElement.closest('section, article, main, div');
    }
    return 'unknown';
  }

  function pageSlug() {
    var p = location.pathname.replace(/\/$/, '');
    if (!p || p === '') return 'homepage';
    return p.replace(/^\//, '').replace(/\.html$/, '').replace(/\//g, '-');
  }

  function decorateCalLinks() {
    try {
      var links = document.querySelectorAll('a[href*="cal.com/rivermountainsystems"]');
      var slug = pageSlug();
      var pageLabel = (document.title || '').split('|')[0].trim().slice(0, 50) || slug;

      links.forEach(function (a) {
        if (a.dataset.calDecorated === '1') return;
        var src = deriveCalSource(a);
        var btnText = (a.textContent || '').trim().replace(/^\W+/, '').slice(0, 40);

        try {
          var url = new URL(a.href);
          if (!url.searchParams.has('utm_source'))   url.searchParams.set('utm_source', 'site');
          if (!url.searchParams.has('utm_medium'))   url.searchParams.set('utm_medium', 'cta');
          if (!url.searchParams.has('utm_campaign')) url.searchParams.set('utm_campaign', slug);
          if (!url.searchParams.has('utm_content'))  url.searchParams.set('utm_content', src);
          if (!url.searchParams.has('notes')) {
            var notes = '📍 ' + pageLabel + ' → "' + btnText + '" (' + src + ')';
            url.searchParams.set('notes', notes);
          }
          a.href = url.toString();
          a.dataset.calDecorated = '1';
        } catch (e) { /* malformed href, leave alone */ }
      });
    } catch (e) { /* never break a page over this */ }
  }

  // Run after DOM is ready. rms-components.js loads with defer, so DOM is parsed
  // by the time we get here, but be defensive.
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', decorateCalLinks);
  } else {
    decorateCalLinks();
  }
  // Re-run if a custom element later injects new Cal links (e.g., rms-footer
  // adds a Cal CTA in the future). MutationObserver scoped to the body.
  if (window.MutationObserver) {
    var mo = new MutationObserver(function () { decorateCalLinks(); });
    if (document.body) mo.observe(document.body, { childList: true, subtree: true });
    else document.addEventListener('DOMContentLoaded', function(){ mo.observe(document.body, { childList: true, subtree: true }); });
  }
})();
