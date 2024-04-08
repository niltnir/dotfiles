// ==UserScript==
// @name         Invidious Recommendation Blocker
// @description  Removes recommendations from Invidious sites 
// @author       niltnir
// @version      1
// @include      *
// @grant        none
// ==/UserScript==

(function () {
    "use strict";

    const initStyle = document.body.style;
    checkPage(() => {
        document.body.style.display = "none";
    });

    window.addEventListener("load", function () {
        // do things after the DOM loads fully
        //console.log("Everything is loaded");
        checkPage(modifyInvidious);
        document.body.style = initStyle;
    });

    function removeDOMElement(el) {
        if (el) el.parentNode.removeChild(el);
    }

    function modifyInvidious() {
        const playerEl = document.getElementById("player-container");
        if (playerEl) {
            const recommendedEl =
                playerEl.nextElementSibling.nextElementSibling.children[2];
            removeDOMElement(recommendedEl);
        }
    }

    function checkPage(lambda) {
        //invidious
        const contentsEl = document.getElementById("contents");

        if (
            contentsEl &&
            contentsEl.children[0] &&
            contentsEl.children[0].children[0]
        ) {
            const title = contentsEl.children[0].children[0].innerText;
            if (title.toUpperCase().includes("INVIDIOUS")) lambda();
        }
    }
})();
