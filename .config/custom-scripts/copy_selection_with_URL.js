// ==UserScript==
// @name         Copy Selection with URL (Custom Control+C for Mac)
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Copy selected text with page URL using Control+C on Mac without alert
// @author       Your Name
// @match        *://*/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    document.addEventListener('keydown', function(e) {
        if (e.key === 'c' && e.ctrlKey && !e.metaKey) { // Control+C on Mac
            const selection = window.getSelection().toString();
            const url = document.location.href;
            if (selection) {
                const textarea = document.createElement('textarea');
                textarea.value = `${selection} ${url}`;
                document.body.appendChild(textarea);
                textarea.select();
                document.execCommand('copy');
                document.body.removeChild(textarea);
            }
            e.preventDefault();
        }
    });
})();
