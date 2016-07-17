(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)

(require 'package)
(add-to-list 'package-archives
              '("melpa" . "https://melpa.org/packages/") t)
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
