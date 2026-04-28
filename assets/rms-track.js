// rms-track.js — extracted from index.html by WU-INFRA-00.
// Canonical multi-channel tracking helper used across the site.
// Convention: rmsTrack('<verb>_<noun>', { …meta })  — see AUDIT_2026-04-28.md §4.3.3.
// Each backend call is wrapped in try/catch so a missing pixel never breaks click handlers.
window.rmsTrack = function(name, params) {
  try { gtag('event', name, params || {}); } catch(e){}
  try { if (window.fbq) fbq('trackCustom', name, params || {}); } catch(e){}
  try { if (window.lintrk) lintrk('track', { conversion_id: 0 }); } catch(e){}
};
