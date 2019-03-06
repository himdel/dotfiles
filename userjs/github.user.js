// ==UserScript==
// @name       github
// @version    0.1
// @match      https://github.com/**/pull/*
// @grant      none
// ==/UserScript==

// when the branch is deleted
document.querySelectorAll(".post-merge-message a").forEach((el) => {
  // bad element
  if (el.text !== "Delete fork")
    return;

  // branch still exists
  if (el.parentElement.classList.contains('BtnGroup'))
    return;

  // just make the button look small and dangerous
  // el.classList.add('btn-sm', 'btn-danger');

  // or hide the whole box
  document.querySelectorAll("form[action$='/cleanup']").forEach((e) => {
    e.style.display = 'none';
  });
});
