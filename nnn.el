;;; nnn.el --- nnn plugin for your emacs.
;;; Commentary:
;; Copyright (C) 2021 by HackTheOxidation
;; Author: HackTheoxidation
;; URL: https://github.com/HackTheOxidation/nnn.el
;; Filename: nnn.el
;; Description: nnn plugin for your emacs
;; Created: 2021-12-18
;; Version: 0.0.1
;; Package-Requires: ((emacs "26.0"))
;; Keywords: nnn filemanager dired
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not,  write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Install:
;;
;; Autoloads will be set up automatically if you use package.el.
;;
;; Usage:
;;
;; M-x nnn
;;
;;; Code:

(defgroup nnn nil
  "Options for nnn.el"
  :group 'convenience)

(defcustom nnn/exe "nnn"
  "Path to nnn."
  :type 'string
  :group 'nnn)

(defconst nnn/buffer-name "*nnn*"
  "Buffer name for nnn session.")

;; Exit handler function that is called when the nnn process is killed.
(defun nnn/on-nnn-exit-handler (process status)
  "Kill the buffer when nnn exits.  Print PROCESS and STATUS to the message buffer."
  (kill-buffer nnn/buffer-name)
  (message (format "%s: %s" process status))
  ;; Removes the exit handler function so that it does not get called recursively.
  (advice-remove 'term-handle-exit 'nnn/on-nnn-exit-handler))

;; Default run function.
(defun nnn/run ()
  "Run nnn in a new term buffer."
  (require 'term) ;; Imports terminal emulator functionality.

  (let* ((buf (get-buffer-create nnn/buffer-name))) ;; Creates a buffer for nnn.
    (make-term nnn/exe "sh" nil "-c" nnn/exe) ;; Opens a term and executes nnn.
    (switch-to-buffer buf)
    (and (fboundp #'turn-off-evil-mode) (turn-off-evil-mode)) ;; Turns off evil-mode if installed.
    (linum-mode 0)
    (visual-line-mode 0)
    (term-char-mode)

    ; Adds the exit handler function to term-handle-exit which is called when the process is killed.
    (advice-add 'term-handle-exit :after 'nnn/on-nnn-exit-handler)
    (message "NNN")))

;;;###autoload
(defun nnn ()
  "Run an nnn session."
  (interactive)
  (nnn/run))

(provide 'nnn)

;;; nnn.el ends here
