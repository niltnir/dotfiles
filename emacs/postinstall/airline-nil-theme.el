

;;; Code:

(deftheme airline-nil
  "source: me niltnir!")

(let ((normal-outer-foreground   "#080808") (normal-outer-background   "#1CDDF1")
      (normal-inner-foreground   "#1CDDF1") (normal-inner-background   "#080808")
      (normal-center-foreground  "#1CDDF1") (normal-center-background  "#080808")

      (insert-outer-foreground   "#080808") (insert-outer-background   "#3EDD89")
      (insert-inner-foreground   "#3EDD89") (insert-inner-background   "#080808")
      (insert-center-foreground  "#3EDD89") (insert-center-background  "#080808")

      (visual-outer-foreground   "#080808") (visual-outer-background   "#ECFF87")
      (visual-inner-foreground   "#ECFF87") (visual-inner-background   "#080808")
      (visual-center-foreground  "#ECFF87") (visual-center-background  "#080808")

      (replace-outer-foreground  "#080808") (replace-outer-background  "#F975FF")
      (replace-inner-foreground  "#F975FF") (replace-inner-background  "#080808")
      (replace-center-foreground "#F975FF") (replace-center-background "#080808")

      (emacs-outer-foreground    "#080808") (emacs-outer-background    "#1CDDF1")
      (emacs-inner-foreground    "#1CDDF1") (emacs-inner-background    "#080808")
      (emacs-center-foreground   "#1CDDF1") (emacs-center-background   "#080808")

      (inactive1-foreground      "#080808") (inactive1-background      "#080808")
      (inactive2-foreground      "#1CDDF1") (inactive2-background      "#080808")
      (inactive3-foreground      "#1CDDF1") (inactive3-background      "#080808"))

  (airline-themes-set-deftheme 'airline-nil)

  (when airline-cursor-colors
    (setq evil-emacs-state-cursor   emacs-outer-background
          evil-normal-state-cursor  normal-outer-background
          evil-insert-state-cursor  `(bar ,insert-outer-background)
          evil-replace-state-cursor replace-outer-background
          evil-visual-state-cursor  visual-outer-background))
)

(airline-themes-set-modeline)

(provide-theme 'airline-nil)
;;; airline-nil.el ends here
