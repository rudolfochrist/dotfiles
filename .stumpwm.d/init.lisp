(in-package :stumpwm)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (ql:quickload :clx-truetype)
  (ql:quickload :xembed))
;;; prefix
(set-prefix-key (kbd "s-t"))

;; load modules
(dolist (module '("cpu" "mem" "net" "wifi" "ttf-fonts" "stumptray" "battery-portable" "swm-gaps"))
  (load-module module))

;; utils

(defun global-set-key (key command)
  (define-key *top-map* key command))

(defun prefix-set-key (key command)
  (define-key *root-map* key command))

(defun echo-progress (val &key label width)
  (message "~A ~A% ~A"
	   (if label (concat label ":") "")
	   (round val)
	   (progress-string val width)))

(defun progress-string (val &optional (width 20))
  (let* ((progress (round (* width (/ val 100))))
	 (rest (- width progress)))
    (concat "["
	    (apply #'concat (loop repeat progress collect "|"))
	    "|"
	    (apply #'concat (loop repeat rest collect " "))
	    "]")))

;; colors
(set-fg-color "#61afef")
(set-bg-color "#21252b")
(set-border-color "magenta")
(set-win-bg-color "#21252b")
(set-focus-color "magenta")
(set-unfocus-color "#21252b")

(setf *mode-line-background-color* "#38394c"
      *mode-line-foreground-color* "#61afef"
      *mode-line-border-color* "magenta")

;; size
(setf *window-border-style* :thin
      *maxsize-border-width* 1
      *transient-border-width* 1
      *normal-border-width* 1
      *message-window-gravity* :center
      *input-window-gravity* :center
      *mode-line-border-width* 1
      *message-window-padding* 10)

(set-msg-border-width 10)


;; font
;; (xft:cache-fonts);
(set-font (make-instance 'xft:font
			 :family "Liberation Mono"
			 :subfamily "Bold"
			 :size 10
			 :antialiased t))


;; modeline

(setf *window-format* "%n%s%c")
(setf *screen-mode-line-format*
      (list "[λ] %w | %c | %M | %l | %I | %B | "
	    '(:eval (run-shell-command "date +\"%a %d | %H:%M\"" t))))

;;; mouse

(setf *mouse-focus-policy* :click
      *mouse-follows-focus* t)

;;; volume control
;; head tip to Nicolas Petton

(defun volume-get ()
  (let ((output (run-shell-command "amixer get Master" t)))
    (multiple-value-bind (result matches)
        (cl-ppcre:scan-to-strings "([0-9]+)%" output)
      (read-from-string (aref matches 0)))))

(defun volume-adjust (delta)
  (run-shell-command (format nil "amixer set Master ~D" delta))
  (echo-progress (volume-get) :label "Volume" :width 40))

(defcommand volume-inc ()
    ()
  (volume-adjust "5%+"))

(defcommand volume-dec ()
    ()
  (volume-adjust "5%-"))

(defcommand volume-toggle () ()
  (run-shell-command "exec amixer set Master toggle"))

(global-set-key (kbd "s-+") "volume-inc")
(global-set-key (kbd "s--") "volume-dec")
(global-set-key (kbd "s-m") "volume-toggle")

;;; brightness control

(defun brightness-adjust (delta)
  (run-shell-command (format nil "xbacklight ~A" delta))
  (echo-progress (brightness-get) :label "Brightness"))

(defun brightness-get ()
  (read-from-string (run-shell-command "xbacklight" t)))

(defcommand brightness-inc () ()
  (brightness-adjust "+10"))

(defcommand brightness-dec () ()
  (brightness-adjust "-10"))

(global-set-key (kbd "s-]") "brightness-inc")
(global-set-key (kbd "s-[") "brightness-dec")

;;; commands

(global-set-key (kbd "s-e") "emacs")

(defcommand cal ()
  ()
  (run-shell-command "cal -3" t))

(defcommand logout ()
  ()
  (run-shell-command "pkill -KILL -u $USER"))

(defcommand (pull-from-windowlist-by-class tile-group) () ()
  (let ((pulled-window (select-window-from-menu
                        (group-windows (current-group))
                        *window-format-by-class*)))
    (when pulled-window
      (pull-window pulled-window))))

(prefix-set-key (kbd "C-p") "pull-from-windowlist-by-class")
(global-set-key (kbd "s-p") "pull-from-windowlist-by-class")

;;; terminals
(defcommand st ()
  ()
  (run-or-raise "st" '(:class "st")))
(prefix-set-key (kbd "c") "st")
(prefix-set-key (kbd "C-c") "st")
(global-set-key (kbd "s-c") "st")

(defcommand firefox ()
  ()
  (run-or-raise "firefox" '(:class "Firefox")))
(prefix-set-key (kbd "b") "firefox")
(prefix-set-key (kbd "C-b") "firefox")
(global-set-key (kbd "s-b") "firefox")

(defcommand dmenu ()
    ()
  (run-shell-command "dmenu_run"))
(global-set-key (kbd "s-z") "dmenu")

(defcommand slack ()
  ()
  (run-or-raise "slack" '(:class "Slack")))

(prefix-set-key (kbd "a") "slack")
(prefix-set-key (kbd "C-a") "slack")
(global-set-key (kbd "s-a") "slack")

(defcommand slock ()
  ()
  (run-shell-command "slock"))
(global-set-key (kbd "s-l") "slock")

(global-set-key (kbd "s-w") "windowlist-by-class")
(prefix-set-key (kbd "w") "windowlist-by-class")
(prefix-set-key (kbd "C-w") "windowlist-by-class")

(global-set-key (kbd "s-TAB") "fnext")

(prefix-set-key (kbd "1") "only")
(prefix-set-key (kbd "2") "vsplit")
(prefix-set-key (kbd "3") "hsplit")
(prefix-set-key (kbd "0") "remove")

;;; swank
#+ignore
(let ((swank-loader "~/.emacs.d/site-lisp/slime/swank-loader.lisp"))
  (when (probe-file swank-loader)
    (load swank-loader)
    (swank-loader:init)

    (defcommand swank ()
      ()
      (swank:create-server :port 4005
                           :style swank:*communication-style*
                           :dont-close t)
      (echo-string (current-screen)
                   "Starting swank on port 4005."))))

;; startup
(unless (head-mode-line (current-head))
  (toggle-mode-line (current-screen) (current-head))
  (stumptray:stumptray))

#+ignore
(unless swm-gaps::*gaps-on*
  (swm-gaps:toggle-gaps))


