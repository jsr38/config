(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(package-selected-packages
   (quote
    (htmlize org virtualenvwrapper use-package typescript-mode realgud python-test python-mode python-environment python-docstring python pylint paradox flycheck-protobuf flycheck-google-cpplint flycheck-clojure)))
 '(paradox-automatically-star t)
 '(safe-local-variable-values
   (quote
    ((flycheck-disabled-checkers quote
				 (c/c++-clang))
     (eval setq flycheck-gcc-include-path
	   (list
	    (expand-file-name "~/dev/nordic_sdk/nrf51_sdk_4_4_2/nrf51822/Include/")))
     (eval setq flycheck-clang-include-path
	   (list
	    (expand-file-name "~/dev/nordic_sdk/nrf51_sdk_4_4_2/nrf51822/Include/")
	    (expand-file-name "~/dev/nordic_sdk/nrf51_sdk_4_4_2/nrf51822/Include/ble/")
	    (expand-file-name "~/dev/nordic_sdk/nrf51_sdk_4_4_2/nrf51822/Include/ble/softdevice/")))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)

(setq paradox-github-token "SETME")
(setq ispell-program-name "/usr/local/bin/ispell")

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(require 'json)
(require 'flycheck)
(defun parse-jslinter-warning (warning)
  (flycheck-error-new
   :line (1+ (cdr (assoc 'line warning)))
   :column (1+ (cdr (assoc 'column warning)))
   :message (cdr (assoc 'message warning))
   :level 'error))
(defun jslinter-error-parser (output checker buffer)
  (mapcar 'parse-jslinter-warning
          (cdr (assoc 'warnings (aref (json-read-from-string output) 0)))))
(flycheck-define-checker javascript-jslinter
  "A JavaScript syntax and style checker based on JSLinter.

See URL `https://github.com/tensor5/JSLinter'."
  :command ("/usr/local/bin/jslint" "--raw" source)
  :error-parser jslinter-error-parser
  :modes (js-mode js2-mode js3-mode))

(add-hook 'after-init-hook #'global-flycheck-mode)

(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "/Users/jsr/virtualenvs")

(setq-default mode-line-format (cons '(:exec venv-current-name) mode-line-format))

;;; org-mode

(require 'ox-publish)
(setq org-publish-project-alist
      '(("org-jsr38"
         ;; Path to your org files.
         :base-directory "~/dev/bb-jsr38.github.io/_org"
         :base-extension "org"
         ;; Path to your Jekyll project.
         :publishing-directory "~/dev/jsr38.github.io/_posts"
         :recursive t
         ;; this was for org-mode pre-version 8
         ;;:publishing-function org-publish-org-to-html
         ;; this is for org-mode version 8 and on
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :html-extension "html"
         :body-only t ;; Only export section between <body> </body> (body-only)
	 :auto-preamble nil
         :auto-postamble nil
         )
        ("org-static-images-jsr38"
         :base-directory "~/dev/bb-jsr38.github.io/_org/images"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
         :publishing-directory "~/dev/jsr38.github.io/assets"
         :recursive t
         :publishing-function org-publish-attachment)

	("org-static-downloads-jsr38"
         :base-directory "~/dev/bb-jsr38.github.io/_org/downloads"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
         :publishing-directory "~/dev/jsr38.github.io/assets"
         :recursive t
         :publishing-function org-publish-attachment)

        ("jsr38" :components ("org-jsr38"
			      "org-static-images-jsr38"
			      "org-static-downloads-jsr38"))
        ))

(require 'ox-latex)
(unless (boundp 'org-latex-classes)
  (setq org-latex-classes nil))
(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")))

(setq org-html-mathjax-options
      '((path "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js")
        (scale "100")
        (align "center")
        (indent "2em")
        (mathml nil)))

(require 'ob-python)
(require 'ob-clojure)
(require 'ob-perl)
(require 'ob-dot)
(require 'ob-R)
(require 'ob-gnuplot)
(require 'ob-lisp)
(require 'ob-org)
(require 'ob-screen)
(require 'ob-calc)
(require 'ob-js)
(require 'ob-latex)
(require 'ob-plantuml)
(require 'ob-sh)
(require 'ob-ditaa)
(require 'ob-awk)
(require 'ob-octave)
(require 'ob-sed)
(require 'ob-sql)
(require 'ob-sqlite)
(require 'ob-sh)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (shell . t)))

(setq org-startup-with-inline-images t)
(setq org-startup-truncated nil)
(setq org-src-fontify-natively t)

(setq org-list-allow-alphabetical t)

(require 'org-ref)
(require 'org-ref-pdf)
(require 'org-ref-url-utils)

(setq reftex-default-bibliography '("~/dev/bibliography/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/dev/bibliography/notes.org"
      org-ref-default-bibliography '("~/dev/bibliography/references.bib")
      org-ref-pdf-directory "~/dev/bibliography/bibtex-pdfs/")

(setq bibtex-completion-bibliography "~/dev/bibliography/references.bib"
      bibtex-completion-library-path "~/dev/bibliography/bibtex-pdfs"
      bibtex-completion-notes-path "~/dev/bibliography/helm-bibtex-notes")

;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (start-process "open" "*open*" "open" fpath)))

;; alternative
;; (setq bibtex-completion-pdf-open-function 'org-open-file)

;;(when (executable-find "ipython")
;;  (setq python-shell-interpreter "ipython"))

(setq python-shell-interpreter "python")

(with-eval-after-load 'python
  (defun python-shell-completion-native-try ()
    "Return non-nil if can trigger native completion."
    (let ((python-shell-completion-native-enable t)
          (python-shell-completion-native-output-timeout
           python-shell-completion-native-try-output-timeout))
      (python-shell-completion-native-get-completions
       (get-buffer-process (current-buffer))
       nil "_"))))

(provide '.emacs)
;;; .emacs ends here
