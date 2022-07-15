;;; common init file for various CLs  -*- mode: lisp; -*-
;;; see also http://www.cliki.net/Common%20Lisp%20implementation
;;; for startup file names
;;; - ~./clisprc.lisp (clisp)
;;; - ~/.cmucl-init.lisp (cmucl)
;;; - ~/.eclrc (ecl)
;;; - ~/.ccl-init.lisp (ccl)
;;; - ~/.sbclrc (sbcl)
;;; - ~/.abclrc (abcl)
;;; - ~/.mkclrc (mkcl)
;;; - ~/.clinit.cl (acl/allegro cl)

(require 'asdf)

;;; with-debug
(proclaim '(optimize (speed 0) (compilation-speed 0) (safety 3) (debug 3)))

;;; quicklisp
;;;
;;; QL Installation:
;;;
;;; 1. Clone quicklisp-client from https://github.com/quicklisp/quicklisp-client.git
;;;    to ~/quicklisp
;;;
;;; 2. Clone ql-https from https://github.com/rudolfochrist/ql-https.git to
;;;    to ~/common-lisp/ql-https
;;;
;;; 3. In ~/quicklisp/setup.lisp comment out the last line (quicklisp:setup)
;;;
;;; 4. Start a fresh REPL and (require 'asdf)
;;;
;;; 5. Load ~/quicklisp/setup.lisp
;;;
;;; 6. Eval (asdf:load-system "ql-https")
;;;
;;; 7. Eval (quicklisp:setup) - use the USE-HTTPS restart if you hit the network
;;;
;;; 8. DONE
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)
    (asdf:load-system "ql-https")
    (uiop:symbol-call :quicklisp :setup)))

#+ql-https
(setf ql-https:*quietly-use-https* t)

#+quicklisp
(progn
  (ql:quickload "ql-file-fetcher" :verbose nil :silent t)
  (ql:quickload "project-loader" :verbose nil :silent t))

#+sbcl
(setf sb-impl::*default-external-format* :utf-8)

(load #p"~/.swank-user.lisp")

;;; Allegro CL REPL
#+sbcl
(progn
  (ignore-errors (require 'sb-aclrepl))
  (when (find-package :sb-aclrepl)
    (load "~/.sb-aclrepl.lisp")
    (push :aclrepl *features*)))


;;; Machine information
(defun machine-info ()
  "Print this host's details."
  (format t "~@{~A: ~A~^~%~}~%"
          "Machine Information"  ""
          "-- Arch"  (machine-type)
          "-- CPU"  (machine-version)
          "-- OS" (software-type)
          "-- Version" (software-version)
          "-- Hostname"  (machine-instance)
          "-- HOME"  (user-homedir-pathname)
          "-- Site Name"  (list (short-site-name) (long-site-name))
          "Lisp Information"  ""
          "-- Implementation"  (lisp-implementation-type)
          "-- Version"  (lisp-implementation-version)))
